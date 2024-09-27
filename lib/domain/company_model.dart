import 'asset_model.dart';
import 'location_model.dart';

class CompanyModel {
  final String id;
  final String name;
  // Locais pertencentes à empresa
  List<LocationModel>? locations;
  // Ativos diretamente associados à empresa, sem local definido
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
