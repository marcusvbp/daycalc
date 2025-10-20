import 'package:flutter/material.dart';
import 'package:daycalc/app/modules/open_holidays/models/public_holiday.dart';
import 'holiday_card.dart';

class HolidaysList extends StatelessWidget {
  final List<PublicHoliday> holidays;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<PublicHoliday>? onItemTap;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const HolidaysList({
    super.key,
    required this.holidays,
    this.padding,
    this.onItemTap,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (holidays.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      itemCount: holidays.length,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final holiday = holidays[index];
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
}