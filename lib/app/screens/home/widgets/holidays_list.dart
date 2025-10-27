import 'package:daycalc/app/modules/open_holidays/models/public_holiday.dart';
import 'package:flutter/material.dart';

import 'holiday_card.dart';

class HolidaysList extends StatelessWidget {
  final List<PublicHoliday> holidays;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<PublicHoliday>? onItemTap;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final DateTime? validFrom;
  final DateTime? validTo;

  const HolidaysList({
    super.key,
    required this.holidays,
    this.padding,
    this.onItemTap,
    this.physics,
    this.shrinkWrap = false,
    this.validFrom,
    this.validTo,
  });

  @override
  Widget build(BuildContext context) {
    if (holidays.isEmpty) {
      return const SizedBox.shrink();
    }

    final filtered = _applyDateFilter(holidays, validFrom, validTo);
    if (filtered.isEmpty) {
      return const SizedBox.shrink();
    }

    final items = _flattenGroupedByYear(filtered);

    return ListView.builder(
      itemCount: items.length,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final item = items[index];
        if (item.isHeader) {
          return _yearHeader(context, item.year!);
        }

        final holiday = item.holiday!;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: HolidayCard(
            holiday: holiday,
            onTap: onItemTap != null ? () => onItemTap!(holiday) : null,
          ),
        );
      },
    );
  }

  Widget _yearHeader(BuildContext context, int year) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        year.toString(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  List<PublicHoliday> _applyDateFilter(
    List<PublicHoliday> items,
    DateTime? from,
    DateTime? to,
  ) {
    if (from == null || to == null) {
      return items;
    }

    final fromDay = DateTime(from.year, from.month, from.day);
    final toDay = DateTime(to.year, to.month, to.day);

    return items.where((h) {
      DateTime? start = DateTime.tryParse(h.startDate);
      DateTime? end = DateTime.tryParse(h.endDate);

      if (start == null && end == null) {
        return false;
      }

      start ??= end!;
      end ??= start;

      final startDay = DateTime(start.year, start.month, start.day);
      final endDay = DateTime(end.year, end.month, end.day);

      final overlaps = !(endDay.isBefore(fromDay) || startDay.isAfter(toDay));
      return overlaps;
    }).toList();
  }

  List<_GroupItem> _flattenGroupedByYear(List<PublicHoliday> items) {
    final Map<int, List<PublicHoliday>> grouped = {};
    for (final h in items) {
      final year = _holidayYear(h);
      if (year == null) continue;
      grouped.putIfAbsent(year, () => []).add(h);
    }

    // Ordena anos em ordem decrescente
    final years = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    final result = <_GroupItem>[];
    for (final y in years) {
      // Ordena feriados dentro do ano por data (start/end) em ordem crescente
      final list = grouped[y]!;
      list.sort((a, b) {
        final aDate = _primaryDate(a);
        final bDate = _primaryDate(b);
        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;
        return aDate.compareTo(bDate);
      });

      result.add(_GroupItem.header(y));
      result.addAll(list.map(_GroupItem.holiday));
    }
    return result;
  }

  int? _holidayYear(PublicHoliday h) {
    final date = _primaryDate(h);
    return date?.year;
  }

  DateTime? _primaryDate(PublicHoliday h) {
    return DateTime.tryParse(h.startDate) ?? DateTime.tryParse(h.endDate);
  }
}

class _GroupItem {
  final bool isHeader;
  final int? year;
  final PublicHoliday? holiday;

  _GroupItem._(this.isHeader, this.year, this.holiday);

  factory _GroupItem.header(int year) => _GroupItem._(true, year, null);
  factory _GroupItem.holiday(PublicHoliday h) => _GroupItem._(false, null, h);
}
