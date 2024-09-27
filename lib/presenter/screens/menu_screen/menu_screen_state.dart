import 'package:flutter/material.dart';

import '../../../domain/company_model.dart';
import '../../../services/api_service.dart';
import '../../../services/connectivity_service.dart';

enum MenuScreenStatus { loading, loaded, error }

class MenuScreenState extends ChangeNotifier {
  final ApiService _apiService;
  final ConnectivityService _connectivityService;

  MenuScreenStatus status = MenuScreenStatus.loading;
  List<CompanyModel> companies = [];

  MenuScreenState({
    required ApiService apiService,
    required ConnectivityService connectivityService,
  })  : _apiService = apiService,
        _connectivityService = connectivityService;

  Future<void> loadCompanies() async {
    status = MenuScreenStatus.loading;
    notifyListeners();

    final bool hasInternetAccess =
        await _connectivityService.hasInternetAccess();

    if (!hasInternetAccess) {
      status = MenuScreenStatus.error;
      notifyListeners();
      return;
    }

    try {
      companies = await _apiService.fetchCompanies();
      status = MenuScreenStatus.loaded;
    } catch (e) {
      status = MenuScreenStatus.error;
    }
    notifyListeners();
  }
}
