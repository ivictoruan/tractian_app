import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractian_app/utils/app_assets.dart';
import '../../../domain/asset_model.dart';
import '../../../domain/location_model.dart';
import 'assset_screen_state.dart';

class AssetsScreen extends StatefulWidget {
  final String companyId;

  const AssetsScreen({super.key, required this.companyId});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  void initScreen() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final assetState = context.read<AssetScreenState>();
        if (mounted) {
          await assetState.fetchAssets(widget.companyId);
        }

      },
    );
  }

  @override
  void initState() {
    super.initState();
    initScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: const Text('Assets'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
      );

  Widget _buildBody(BuildContext context) {
    return Consumer<AssetScreenState>(
      builder: (context, assetState, child) {
        switch (assetState.status) {
          case AssetScreenStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case AssetScreenStatus.error:
            return const Center(
                child: Text('An error occurred. Please try again.'));
          case AssetScreenStatus.loaded:
            return _buildTreeView(assetState.locations);
        }
      },
    );
  }

  Widget _buildTreeView(List<LocationModel> locations) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return _buildLocationTile(location);
      },
    );
  }

  Widget _buildLocationTile(LocationModel location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.location),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(location.name, style: const TextStyle(fontSize: 16)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              if (location.subLocations != null)
                ...location.subLocations!.map(
                  (subLoc) => _buildLocationTile(subLoc),
                ),
              if (location.assets != null)
                ...location.assets!.map(
                  (asset) => _buildAssetTile(asset),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssetTile(AssetModel asset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    asset.subAssets?.isEmpty ?? false
                        ? AppAssets.cube
                        : AppAssets.codePen,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(asset.name, style: const TextStyle(fontSize: 14)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              if (asset.subAssets != null)
                ...asset.subAssets!
                    .map((subAsset) => _buildAssetTile(subAsset)),
              if (asset.components != null)
                ...asset.components!.map(
                  (component) => ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: _getComponentStatusColor(component.status),
                      size: 12,
                    ),
                    title: Text(component.name),
                    subtitle: Text('Sensor Type: ${component.sensorType}'),
                    trailing: Icon(
                      Icons.bolt,
                      color: component.sensorType == 'Energy'
                          ? Colors.green
                          : Colors.transparent,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getComponentStatusColor(String? status) {
    switch (status) {
      case 'critical':
        return Colors.red;
      case 'normal':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
