import 'package:daycalc/app/modules/open_holidays/models/country.dart';
import 'package:daycalc/app/modules/open_holidays/models/localized_text.dart';
import 'package:flutter/material.dart';

typedef CountryChanged = void Function(Country? selected);

/// Widget de seleção de país usando DropdownMenu com pesquisa.
///
/// Recebe uma lista de `Country`, um `defaultValue` opcional e
/// um callback `onChange` que dispara o valor selecionado.
class CountrySelect extends StatelessWidget {
  final List<Country> countries;
  final Country? defaultValue;
  final CountryChanged onChange;

  /// Texto de dica exibido quando nada está selecionado.
  final String? hintText;

  /// Um rótulo opcional acima do campo.
  final Widget? label;

  /// Define se o seletor está habilitado.
  final bool enabled;

  const CountrySelect({
    super.key,
    required this.countries,
    required this.onChange,
    this.defaultValue,
    this.hintText,
    this.label,
    this.enabled = true,
  });

  String _displayName(BuildContext context, Country country) {
    final preferred = Localizations.localeOf(
      context,
    ).languageCode.toLowerCase();
    LocalizedText? match;
    for (final n in country.name) {
      if (n.language.toLowerCase().startsWith(preferred)) {
        match = n;
        break;
      }
    }
    return match?.text ??
        (country.name.isNotEmpty ? country.name.first.text : country.isoCode);
  }

  @override
  Widget build(BuildContext context) {
    final entries = countries
        .map(
          (c) => DropdownMenuEntry<Country>(
            value: c,
            label: _displayName(context, c),
          ),
        )
        .toList();

    final Country? selected = defaultValue != null
        ? countries.firstWhere((e) => e.isoCode == defaultValue!.isoCode)
        : null;

    return DropdownMenu<Country>(
      enabled: enabled,
      initialSelection: selected,
      hintText: hintText,
      label: label,
      enableFilter: true,
      requestFocusOnTap: true,
      onSelected: onChange,
      width: double.infinity,
      menuHeight: MediaQuery.of(context).size.height * 0.3,
      filterCallback: (entries, filter) {
        final query = filter.toLowerCase();
        return entries.where((e) {
          return e.label.toLowerCase().contains(query) ||
              e.value.isoCode.toLowerCase().contains(query);
        }).toList();
      },
      dropdownMenuEntries: entries,
    );
  }
}
