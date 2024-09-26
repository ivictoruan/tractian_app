class ComponentModel {
  final String id;
  final String name;
  final String? assetId; // Id do ativo pai
  final String?
      locationId; // Id do local pai (se não estiver associado a um ativo)
  final String status; // "operating" ou "alert"
  final String sensorType; // "vibration" ou "energy"

  ComponentModel({
    required this.id,
    required this.name,
    this.assetId,
    this.locationId,
    required this.status,
    required this.sensorType,
  });
}
