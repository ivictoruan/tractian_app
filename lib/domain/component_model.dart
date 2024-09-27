/// São as partes que constituem um ativo.
/// São normalmente associados a um ativo, mas o cliente [pode]
/// querer adicionar componentes sem um ativo como pai [ou]
/// com um local como pai normalmente incluem sensores de
/// [vibração ou energia] e têm um status [operacional] ou [alerta]
library;

// enum Status { operating, alert }

// enum SensorType { vibration, energy }

class ComponentModel {
  final String id;
  final String name;
  // Id do ativo pai
  final String? assetId;
  // Id do local pai (se não estiver associado a um ativo)
  final String? locationId;
  // TODO: criar enum status {Operating, Alert}
  final String status;
  // TODO: criar enum sensorType {Vibration, Energy}
  final String sensorType;

  ComponentModel({
    required this.id,
    required this.name,
    this.assetId,
    this.locationId,
    required this.status,
    required this.sensorType,
  });
}
