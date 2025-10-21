import 'package:daycalc/app/screens/home/widgets/holidays_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidaysTabScreen extends ConsumerStatefulWidget {
  const HolidaysTabScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HolidaysTabScreenState();
}

class _HolidaysTabScreenState extends ConsumerState<HolidaysTabScreen> {
  @override
  Widget build(BuildContext context) {
    // final holidaysAsync = ref.watch(holidaysFetchProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const HolidaysParameters(),
            // holidaysAsync.when(
            //   data: (items) {
            //     if (items == null || items.isEmpty) {
            //       return const SizedBox.shrink();
            //     }
            //     return HolidaysList(
            //       holidays: items,
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //     );
            //   },
            //   loading: () => const Padding(
            //     padding: EdgeInsets.symmetric(vertical: 24.0),
            //     child: Center(child: CircularProgressIndicator()),
            //   ),
            //   error: (error, _) => Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 12.0),
            //     child: Text('Error: $error'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
