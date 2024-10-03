import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/asset_model.dart';
import '../../../domain/location_model.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import 'assset_screen_state.dart';
import 'widgets/expanded_tile_widget.dart';

class AssetsScreen extends StatefulWidget {
  final String companyId;

  const AssetsScreen({super.key, required this.companyId});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  late final AssetScreenState assetScreenState;
  List<LocationModel> locations = [];
  List<AssetModel> assets = [];

  @override
  void initState() {
    super.initState();
    assetScreenState = context.read<AssetScreenState>();
    WidgetsBinding.instance.addPostFrameCallback((_) async => _initScreen());
  }

  Future<void> _initScreen() async {
    await assetScreenState.fetchAssets(widget.companyId);

    await assetScreenState.fetchLocations(widget.companyId);
    locations = assetScreenState.locations;
    assets = assetScreenState.assets;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          title: const Text('Assets'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Consumer<AssetScreenState>(
          builder: (context, assetState, child) {
            switch (assetState.status) {
              case AssetScreenStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case AssetScreenStatus.error:
                return const Center(
                  child: Text('An error occurred. Please try again.'),
                );
              case AssetScreenStatus.loaded:
                return _buildBody(
                  assets: assetState.assets,
                  locations: assetState.locations,
                );
            }
          },
        ),
      );

  Widget _buildBody({
    required List<AssetModel> assets,
    required List<LocationModel> locations,
  }) =>
      Column(
        children: [
          Expanded(
            child: ListView(
              children: _buildTreeNodes(
                locations,
                assets,
                null,
              ),
            ),
          ),
        ],
      );

  List<Widget> _buildTreeNodes(
      List<LocationModel> locations, List<AssetModel> assets, String? parentId,
      [int depth = 0]) {
    List<Widget> nodes = [];

    // Adiciona locais no nível atual
    for (LocationModel location
        in locations.where((location) => location.parentId == parentId)) {
      nodes.add(_buildLocationNode(
        location: location,
        allLocations: locations,
        allAssets: assets,
        depth: depth,
      ));
    }

    // Adiciona ativos no nível atual
    for (AssetModel asset
        in assets.where((asset) => asset.locationId == parentId)) {
      // Verifica se é um ativo sem parentId (ativo principal) ou um componente
      if (asset.parentId == null) {
        nodes.add(_buildAssetNode(
          asset: asset,
          allAssets: assets,
          depth: depth,
        ));
      }
    }

    return nodes;
  }

  Widget _buildLocationNode({
    required LocationModel location,
    required List<LocationModel> allLocations,
    required List<AssetModel> allAssets,
    required int depth,
  }) =>
      _buildTreeItem(
        assetName: AppAssets.location,
        title: location.name,
        depth: depth,
        children: _buildTreeNodes(
          allLocations,
          allAssets,
          location.id,
          depth + 1,
        ),
      );

  Widget _buildAssetNode({
    required AssetModel asset,
    required List<AssetModel> allAssets,
    required int depth,
  }) {
    List<Widget> childNodes = allAssets
        .where((childAsset) => childAsset.parentId == asset.id)
        .map((childAsset) => _buildAssetNode(
              asset: childAsset,
              allAssets: allAssets,
              depth: depth + 1,
            ))
        .toList();

    final bool isSensor = asset.sensorType != null;

    return _buildTreeItem(
      assetName: isSensor ? AppAssets.sensor : AppAssets.component,
      title: asset.name,
      depth: depth,
      trailing: _getStatusIcon(asset),
      children: childNodes,
    );
  }

  Widget _buildTreeItem({
    required String assetName,
    required String title,
    required int depth,
    List<Widget>? children,
    Widget? trailing,
  }) =>
      ExpansionTileWidget(
        assetName: assetName,
        depth: depth,
        title: title,
        trailing: trailing,
        children: children,
      );

  Widget? _getStatusIcon(AssetModel asset) {
    if (asset.sensorType == 'energy') {
      return const Icon(
        Icons.bolt,
        color: Colors.green,
        size: 16,
      );
    } else if (asset.sensorType == 'vibration') {
      return Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      );
    }
    return null;
  }
}
