import 'package:daycalc/app/config/constants.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/providers/holidays_collection_provider.dart';
import 'package:daycalc/app/providers/holidays_params_provider.dart';
import 'package:daycalc/app/providers/home_tabs_provider.dart';
import 'package:daycalc/app/utils/format_localized_date.dart';
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
    final localizations = AppLocalizations.of(context)!;

    // Garante que a data inicial seja sempre a menor entre startDate e endDate,
    // evitando intervalos negativos quando o usuário inverte as datas.
    DateTime validFrom = startDate.isAfter(endDate) ? endDate : startDate;
    // Garante que a data final seja sempre a maior entre startDate e endDate,
    // evitando intervalos negativos quando o usuário inverte as datas.
    DateTime validTo = startDate.isAfter(endDate) ? startDate : endDate;

    // Garante que a data inicial não seja anterior a 01/01/2020.
    if (validFrom.isBefore(DateTime(2020, 01, 01))) {
      validFrom = DateTime(2020, 01, 01);
    } else if (validFrom.isAfter(DateTime(DateTime.now().year, 12, 31))) {
      // Garante que a data inicial não seja posterior ao último dia do ano corrente.
      validFrom = DateTime(DateTime.now().year, 12, 31);
    }

    if (validTo.difference(validFrom).inDays > openHolidaysMaxInterval) {
      validTo = validFrom.add(Duration(days: openHolidaysMaxInterval));
    } else if (validTo.isBefore(DateTime(2020, 01, 01))) {
      validTo = DateTime(2020, 01, 01);
    } else if (validTo.isAfter(DateTime(DateTime.now().year, 12, 31))) {
      validTo = DateTime(DateTime.now().year, 12, 31);
    }

    String validFromStr = getLocalizedDate(validFrom, localizations.localeName);
    String validToStr = getLocalizedDate(validTo, localizations.localeName);

    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        color: Theme.of(context).colorScheme.secondaryContainer,
        textColor: Theme.of(context).colorScheme.onSecondary,
        onPressed: () async {
          final currentYearEnd = DateTime(DateTime.now().year, 12, 31);
          final minStartDate = DateTime(2020, 01, 01);
          final maxEndByStart = startDate.add(
            Duration(days: openHolidaysMaxInterval),
          );

          final isStartInvalid =
              startDate.isBefore(minStartDate) ||
              startDate.isAfter(currentYearEnd);
          final isEndInvalid =
              endDate.isAfter(maxEndByStart) || endDate.isAfter(currentYearEnd);

          if (isStartInvalid || isEndInvalid) {
            final confirmed =
                await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Datas fora do intervalo'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('As datas informadas não podem:'),
                        SizedBox(height: 5),
                        Text('- Serem anteriores a 01/01/2020;'),
                        Text(
                          '- Serem maiores que ${getLocalizedDate(DateTime(DateTime.now().year, 12, 31), localizations.localeName)};',
                        ),
                        Text(
                          '- Ter um intervalo maior que $openHolidaysMaxInterval dias.',
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Serão mostrados os feriados entre $validFromStr e $validToStr.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('Deseja continuar?'),
                      ],
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
          ref
              .read(holidaysParamsProvider.notifier)
              .setRange(from: validFrom, to: validTo);
          ref.read(holidaysCollectionProvider.notifier).refresh();
          ref.read(homeTabsProvider.notifier).set(2);
        },
        child: const Text('Ver feriados no Período'),
      ),
    );
  }
}
