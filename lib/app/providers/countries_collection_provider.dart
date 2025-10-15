import 'package:daycalc/app/models/countries_collection.dart';
import 'package:daycalc/app/services/countries_collection_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'countries_collection_provider.g.dart';

@Riverpod(keepAlive: true)
class CountriesCollectionNotifier extends _$CountriesCollectionNotifier {
  late final CountriesCollectionStorageService _storage;

  @override
  Future<CountriesCollection> build() async {
    _storage = CountriesCollectionStorageService();

    final collection = await _storage.getCollection();
    if (collection == null) {
      return CountriesCollection();
    }

    // Verifica expiração de 6 meses usando a data de criação
    final createdAtDate = DateTime.fromMillisecondsSinceEpoch(collection.createdAt);
    final expiryDate = DateTime(
      createdAtDate.year,
      createdAtDate.month + 6,
      createdAtDate.day,
      createdAtDate.hour,
      createdAtDate.minute,
      createdAtDate.second,
      createdAtDate.millisecond,
      createdAtDate.microsecond,
    );

    if (DateTime.now().isAfter(expiryDate)) {
      await _storage.clearCollection();
      return CountriesCollection();
    }

    return collection;
  }

  /// Salva a collection atualizando o createdAt com o timestamp do salvamento
  Future<void> setCollection(CountriesCollection collection) async {
    final withTimestamp = CountriesCollection(
      countries: collection.countries,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _storage.setCollection(withTimestamp);
    state = AsyncData(withTimestamp);
  }

  /// Limpa a collection do storage e reseta o estado
  Future<void> clearCollection() async {
    await _storage.clearCollection();
    state = AsyncData(CountriesCollection());
  }
}