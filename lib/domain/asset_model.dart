class AssetModel {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final String? sensorType;
  final String? status;

  const AssetModel({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
    this.sensorType,
    this.status,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        id: json['id'] as String,
        name: json['name'] as String,
        parentId: json['parentId'] as String?,
        locationId: json['locationId'] as String?,
        sensorType: json['sensorType'] as String?,
        status: json['status'] as String?,
      );
}
