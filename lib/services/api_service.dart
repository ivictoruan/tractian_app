import 'dart:developer';

import 'package:dio/dio.dart';

import '../domain/company_model.dart';

abstract class ApiService {
  // QUESTION: returns must be null?;
  Future<List<CompanyModel>> fetchCompanies();

  // Future<List<AssetModel>>? fetchAssets();

  // Future<List<LocationModel>>? fetchLocations();
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
}
