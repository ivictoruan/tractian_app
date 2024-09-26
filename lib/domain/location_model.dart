import 'asset_model.dart';

class LocationModel {
  final String id;
  final String name;
  List<LocationModel>? subLocations; // Locais dentro de um local maior
  List<AssetModel>? assets; // Ativos presentes nesse local

  LocationModel({
    required this.id,
    required this.name,
    this.subLocations,
    this.assets,
  });
}
