import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidaysParameters extends ConsumerWidget {
  const HolidaysParameters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: [
            Text(
              'Intervalo de datas',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
              children: [
                Expanded(child: Text('Data inicial')),
                IconButton(
                  onPressed: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    // Você pode utilizar selectedDate conforme necessário
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text('Data final')),
                IconButton(
                  onPressed: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    // Você pode utilizar selectedDate conforme necessário
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text('País')),
                TextButton(onPressed: () {}, child: Text('Selecionar país')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
