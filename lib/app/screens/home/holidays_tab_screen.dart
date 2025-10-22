import 'package:daycalc/app/providers/holidays_collection_provider.dart';
import 'package:daycalc/app/providers/holidays_params_provider.dart';
import 'package:daycalc/app/screens/home/widgets/holidays_list.dart';
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
    final holidaysCollectionAsync = ref.watch(holidaysCollectionProvider);
    final holidaysParams = ref.watch(holidaysParamsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const HolidaysParameters(),
            holidaysCollectionAsync.when(
              data: (collection) {
                if (collection == null ||
                    collection.allHolidaysSorted.isEmpty) {
                  return const SizedBox.shrink();
                }
                return HolidaysList(
                  holidays: collection.allHolidaysSorted,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  validFrom: holidaysParams.validFrom,
                  validTo: holidaysParams.validTo,
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
