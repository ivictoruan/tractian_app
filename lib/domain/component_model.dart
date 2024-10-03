/// São as partes que constituem um ativo.
/// São normalmente associados a um ativo, mas o cliente [pode]
/// querer adicionar componentes sem um ativo como pai [ou]
/// com um local como pai normalmente incluem sensores de
/// [vibração ou energia] e têm um status [operacional] ou [alerta]
library;

class ComponentModel {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;

  const ComponentModel({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
  });

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      locationId: json['locationId'] as String?,
      sensorId: json['sensorId'] as String?,
      sensorType: json['sensorType'] as String?,
      status: json['status'] as String?,
      gatewayId: json['gatewayId'] as String?,
    );
  }
}
