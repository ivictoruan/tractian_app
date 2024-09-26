import 'asset_model.dart';
import 'location_model.dart';

class CompanyModel {
  final String id;
  final String name;
  List<LocationModel>? locations; // Locais pertencentes à empresa
  List<AssetModel>?
      assets; // Ativos diretamente associados à empresa, sem local definido

  CompanyModel({
    required this.id,
    required this.name,
    this.locations,
    this.assets,
  });
}
