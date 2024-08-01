import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskitly/core/services/local-service/user.service.dart';
import 'package:taskitly/locator.dart';
import 'package:taskitly/routes/routes.dart';

import '../../constants/reuseables.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  // init() async {
  //   final box = GetStorage();
  //   String? userToken = box.read(DbTable.TOKEN_TABLE_NAME);
  //   Timer(const Duration(seconds: 0), () {

  //     navigationService.navigateToAndRemoveUntil(
  //         userToken == null ? onBoardingRoute : homeRoute);
  //   });
  // }
  init() async {
    final box = GetStorage();

    // Check if service creation is complete
    final hasCreatedService = await box.read(DbTable.haService) ?? false;

    // Logic for user login and service provider status
    if (!locator<UserService>().isUserLoggedIn) {
      navigationService.navigateToAndRemoveUntil(onBoardingRoute);
    } else if (locator<UserService>().isUserServiceProvider) {
      if (locator<UserService>().loginResponse.hasService == true) {
        // Navigate to home screen if service is created
        navigationService.navigateToAndRemoveUntil(homeRoute);
      } else if (!hasCreatedService) {
        // Navigate to update provider details only on first login after creation
        navigationService.navigateToAndRemoveUntil(updateProviderRoute);
        // Update flag to prevent future navigations to update screen
        await box.write(DbTable.haService, true);
      } else {
        // Navigate to home screen if service is not created but flag is set
        navigationService.navigateToAndRemoveUntil(homeRoute);
      }
    } else {
      navigationService.navigateToAndRemoveUntil(homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
