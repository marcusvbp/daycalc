import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/modules/open_holidays/models/public_holiday.dart';
import 'package:daycalc/app/utils/format_localized_date.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HolidayCard extends StatelessWidget {
  final PublicHoliday holiday;
  final VoidCallback? onTap;

  const HolidayCard({super.key, required this.holiday, this.onTap});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final start = _tryParseDate(holiday.startDate);
    final end = _tryParseDate(holiday.endDate);

    final title = _localizedName(context);

    final dateLabel = end != null && start != null && !_isSameDay(start, end)
        ? '${getLocalizedDate(start, localizations.localeName)} — ${getLocalizedDate(end, localizations.localeName)}'
        : getLocalizedDate(start ?? end, localizations.localeName);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title.isNotEmpty ? title : holiday.type,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () async {
                      final res = await SharePlus.instance.share(
                        ShareParams(
                          text:
                              '''
${holiday.name.first.text}
${holiday.type == 'School' ? localizations.holidayTypeSchool : localizations.holidayTypeNormal}
$dateLabel \n${holiday.type} ${holiday.regionalScope != null ? ' - ${holiday.regionalScope}' : ''}''',
                        ),
                      );
                      if (res.status == ShareResultStatus.success) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Compartilhado com sucesso',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.share, size: 16),
                  ),
                ],
              ),
              if (dateLabel.isNotEmpty)
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        dateLabel,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              if (holiday.type == 'School')
                Row(
                  children: [
                    const Icon(Icons.school, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        localizations.school,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  Chip(
                    label: Text(
                      localizations.translateHolidayFragment(holiday.type),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  if (holiday.regionalScope != null &&
                      holiday.regionalScope!.isNotEmpty)
                    Chip(
                      label: Text(
                        localizations.translateHolidayFragment(
                          holiday.regionalScope!,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  if (holiday.temporalScope != null &&
                      holiday.temporalScope!.isNotEmpty)
                    Chip(
                      label: Text(
                        localizations.translateHolidayFragment(
                          holiday.temporalScope!,
                        ),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  for (final s in holiday.subdivisions)
                    Chip(
                      label: Text(
                        localizations.translateHolidayFragment(s.shortName),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _localizedName(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode.toLowerCase();
    try {
      final match = holiday.name.firstWhere(
        (n) => n.language.toLowerCase().startsWith(langCode),
      );
      return match.text;
    } catch (_) {
      if (holiday.name.isNotEmpty) {
        return holiday.name.first.text;
      }
      return '';
    }
  }

  DateTime? _tryParseDate(String value) {
    try {
      return DateTime.tryParse(value);
    } catch (_) {
      return null;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
