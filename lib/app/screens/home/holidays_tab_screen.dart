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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const HolidaysParameters()],
        ),
      ),
    );
  }
}
