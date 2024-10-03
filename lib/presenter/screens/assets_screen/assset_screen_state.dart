import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../domain/asset_model.dart';
import '../../../domain/location_model.dart';
import '../../../services/api_service.dart';
import '../../../services/connectivity_service.dart';

enum AssetScreenStatus { loading, loaded, error }

class AssetScreenState extends ChangeNotifier {
  AssetScreenState({
    required ApiService apiService,
    required ConnectivityService connectivityService,
  })  : _apiService = apiService,
        _connectivityService = connectivityService;

  final ApiService _apiService;
  final ConnectivityService _connectivityService;

  AssetScreenStatus status = AssetScreenStatus.loading;

  List<LocationModel> locations = [];
  List<AssetModel> assets = [];

  Future<void> fetchAssets(String companyId) async {
    status = AssetScreenStatus.loading;
    notifyListeners();

    final bool hasInternetAccess =
        await _connectivityService.hasInternetAccess();

    if (!hasInternetAccess) {
      status = AssetScreenStatus.error;
      notifyListeners();
      return;
    }

    try {
      final processedData = await _fetchAndProcessAssets(companyId);

      if (processedData != null) {
        // TODO: remover esta coleta de localização na da função de coletar assets.
        locations = processedData['locations'] as List<LocationModel>;
        assets = processedData['assets'] as List<AssetModel>;
        status = AssetScreenStatus.loaded;
      } else {
        status = AssetScreenStatus.error;
      }
    } catch (e) {
      log(e.toString());
      status = AssetScreenStatus.error;
    }
    notifyListeners();
  }

  Future<Map<String, List<dynamic>>?>? _fetchAndProcessAssets(
      String companyId) async {
    final fetchedLocations =
        await _apiService.fetchLocations(companyId: companyId);
    final fetchedAssets = await _apiService.fetchAssets(companyId: companyId);

    if (fetchedLocations != null && fetchedAssets != null) {
      return {
        'locations': fetchedLocations.map((location) {
          return LocationModel(
            id: location.id,
            name: location.name,
          );
        }).toList(),
        'assets': fetchedAssets,
      };
    }
    return null;
  }

  Future<void> fetchLocations(String companyId) async {
    try {
      final fetchedLocations =
          await _apiService.fetchLocations(companyId: companyId);
      if (fetchedLocations != null) {
        locations = fetchedLocations;
      } else {
        log('No locations found for company: $companyId');
      }
    } catch (e) {
      log('fetchLocations Error: $e');
      throw Exception('Error fetching locations: $e');
    }
  }
}
