import 'package:daycalc/app/config/constants.dart';
import 'package:daycalc/app/providers/home_tabs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckHolidaysButton extends ConsumerWidget {
  final DateTime startDate;
  final DateTime endDate;
  const CheckHolidaysButton({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.secondaryContainer,
        textColor: Theme.of(context).colorScheme.onSecondary,
        onPressed: () async {
          final currentYearEnd = DateTime(DateTime.now().year, 12, 31);
          final minStartDate = DateTime(2020, 01, 01);
          final maxEndByStart = startDate.add(Duration(days: openHolidaysMaxInterval));

          final isStartInvalid = startDate.isBefore(minStartDate) || startDate.isAfter(currentYearEnd);
          final isEndInvalid = endDate.isAfter(maxEndByStart) || endDate.isAfter(currentYearEnd);

          if (isStartInvalid || isEndInvalid) {
            final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirmar datas fora do intervalo'),
                    content: Text(
                      'Validação de datas:\n\n'
                      '- Data inicial deve estar entre 01/01/2020 e 31/12/${DateTime.now().year}.\n'
                      '- Data final não pode exceder 3 anos a partir da inicial (±1095 dias) nem passar de 31/12/${DateTime.now().year}.\n\n'
                      'Deseja continuar mesmo assim?'
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('Confirmar'),
                      ),
                    ],
                  ),
                ) ??
                false;

            if (!confirmed) {
              return;
            }
          }

          ref.read(homeTabsProvider.notifier).set(2);
        },
        child: const Text('Ver feriados no Período'),
      ),
    );
  }
}
