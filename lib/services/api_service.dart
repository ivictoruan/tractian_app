import 'dart:developer' show log;

import 'package:dio/dio.dart';

import '../domain/asset_model.dart';
import '../domain/company_model.dart';
import '../domain/location_model.dart';

abstract class ApiService {

  Future<List<CompanyModel>> fetchCompanies();

  Future<List<AssetModel>>? fetchAssets({required String companyId});

  Future<List<LocationModel>>? fetchLocations({required String companyId});
}

class DioApiServiceImpl implements ApiService {
  DioApiServiceImpl({required this.dio}) {
    _configureDio();
  }
  final Dio dio;

  final String _baseApi = 'https://fake-api.tractian.com';

  void _configureDio() => dio.options.baseUrl = _baseApi;

  @override
  Future<List<CompanyModel>> fetchCompanies() async {
    const String companiesUrl = '/companies';
    try {
      final Response response = await dio.get(companiesUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<CompanyModel> companies = data
            .map<CompanyModel>(
              (json) => CompanyModel.fromJson(json),
            )
            .toList();

        return companies;
      } else {
        log('Error response:${response.data}');
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      log('fetchCompanies Error:$e');

      // Lida com exceções como timeout, erros de rede etc.
      throw Exception('Error fetching companies: $e');
    }
  }

  @override
  Future<List<AssetModel>> fetchAssets({required String companyId}) async {
    final String assetsUrl = '/companies/$companyId/assets';

    try {
      final Response response = await dio.get(assetsUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<AssetModel> assets = data
            .map<AssetModel>(
              (json) => AssetModel.fromJson(json),
            )
            .toList();

        return assets;
      } else {
        log('Error response: ${response.data}');
        throw Exception('Failed to load assets');
      }
    } catch (e) {
      log('fetchAssets Error: $e');
      throw Exception('Error fetching assets: $e');
    }
  }

  @override
  Future<List<LocationModel>> fetchLocations(
      {required String companyId}) async {
    final String locationsUrl = '/companies/$companyId/locations';
    try {
      final Response response = await dio.get(locationsUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<LocationModel> locations = data
            .map<LocationModel>(
              (json) => LocationModel.fromJson(json),
            )
            .toList();

        return locations;
      } else {
        log('Error response: ${response.data}');
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      log('fetchLocations Error: $e');
      throw Exception('Error fetching locations: $e');
    }
  }
}
