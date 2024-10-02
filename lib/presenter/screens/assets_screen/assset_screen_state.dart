import 'dart:developer';

import 'package:flutter/foundation.dart';

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
      final processedLocations = await _fetchAndProcessAssets(companyId);

      if (processedLocations != null) {
        locations = processedLocations;
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

  Future<List<LocationModel>?> _fetchAndProcessAssets(String companyId) async {
    final fetchedLocations =
        await _apiService.fetchLocations(companyId: companyId);

    final fetchedAssets = await _apiService.fetchAssets(companyId: companyId);

    if (fetchedLocations != null && fetchedAssets != null) {
      return fetchedLocations.map((location) {
        return LocationModel(
          id: location.id,
          name: location.name,
          subLocations: location.subLocations,
          assets: fetchedAssets
              .where((asset) => asset.locationId == location.id)
              .toList(),
        );
      }).toList();
    }
    return null;
  }
}
