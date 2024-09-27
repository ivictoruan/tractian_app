import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractian_app/utils/app_assets.dart';
import 'package:tractian_app/utils/app_colors.dart';

import 'menu_screen_state.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuScreenState>().loadCompanies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MenuScreenState menuScreenState = context.watch<MenuScreenState>();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppAssets.logo),
      ),
      body: switch (menuScreenState.status) {
        MenuScreenStatus.loading => buildWhenLoading(),
        MenuScreenStatus.loaded => Column(
            children: [
              const SizedBox(height: 30),
              ListView.builder(
                shrinkWrap: true,
                itemCount: menuScreenState.companies.length,
                itemBuilder: (BuildContext context, int index) {
                  final company = menuScreenState.companies[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      left: 21,
                      right: 22,
                      bottom: 40,
                    ),
                    width: 317,
                    height: 76,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        log('deve ir para tela de assets da companhia.');
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 32),
                          Image.asset(
                            AppAssets.asset,
                            width: 24,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${company.name} Unit',
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        MenuScreenStatus.error => buildWhenWithError(),
      },
    );
  }

  Widget buildWhenWithError() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Erro ao carregar empresas!'),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.read<MenuScreenState>().loadCompanies(),
              child: const Text('Tente novamente'),
            ),
          ],
        ),
      );

  Widget buildWhenLoading() => const Center(child: CircularProgressIndicator());
}
