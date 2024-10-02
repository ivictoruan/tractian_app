import 'asset_model.dart';
import 'location_model.dart';

class CompanyModel {
  final String id;
  final String name;
  List<LocationModel>? locations;
  List<AssetModel>? assets;

  CompanyModel({
    required this.id,
    required this.name,
    this.locations,
    this.assets,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json['id'] as String,
        name: json['name'] as String,
      );
}
