import '../domain/asset_model.dart';
import '../domain/company_model.dart';
import '../domain/location_model.dart';

abstract class ApiService {
  Future<List<CompanyModel>> fetchCompanies();
  Future<List<AssetModel>> fetchAssets();
  Future<List<LocationModel>> fetchLocations();
}
