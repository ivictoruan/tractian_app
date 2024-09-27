import 'component_model.dart';

class AssetModel {
  final String id;
  final String name;
  final String? locationId; // Id de referência do local
  List<AssetModel>? subAssets; // Ativos menores, se aplicável
  List<ComponentModel>? components;

  AssetModel({
    required this.id,
    required this.name,
    this.locationId,
    this.subAssets,
    this.components,
  });
}
