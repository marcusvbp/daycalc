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

    return ListView.builder(
      itemCount: filtered.length,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final holiday = filtered[index];
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

  List<PublicHoliday> _applyDateFilter(
    List<PublicHoliday> items,
    DateTime? from,
    DateTime? to,
  ) {
    if (from == null || to == null) {
      return items;
    }

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

      // Overlap condition: [startDay, endDay] intersects [fromDay, toDay]
      final overlaps = !(endDay.isBefore(from) || startDay.isAfter(to));
      return overlaps;
    }).toList();
  }
}
