import 'package:flutter/material.dart';

import '../../../../core/models/all_selected_categories_list.dart' as ALL;
import '../../../../core/models/prodiders-service-response.dart';
import '../../../../routes/routes.dart';
import '../../../base/base.vm.dart';

class CategoryDetailTabViewModel extends BaseViewModel {
  late ALL.Category category;

  init() async {
    category = appCache.category;
    await getLocalBlockedUser();
    getBlockedUsers();
    await fetchBookMarkedProvider();
    fetchLocalProvider(appCache.category.uid ?? "");
    fetchProvider(appCache.category.uid ?? "");
  }

  bookMark(ProviderUserResponse serviceID) async {
    print(serviceID.companyName);
    await repository.storeBookMark(serviceID);
    await fetchBookMarkedProvider();
    notifyListeners();
  }

  fetchBookMarkedProvider() async {
    try {
      var response = await repository.getBookMarks();
      if (response != null) {
        bookMarkedProvider = response;
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  removeBookMark(ProviderUserResponse provider) async {
    try {
      await repository.removeBookMark(provider);
      await fetchBookMarkedProvider();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  navigateToDetails(ProviderUserResponse serviceID) async {
    appCache.serviceProvider = serviceID;
    navigationService.navigateTo(providerDetailViewRoute).whenComplete(init);
  }

  var searchController = TextEditingController();

  List<ProviderUserResponse> providers = [];
  List<ProviderUserResponse> bookMarkedProvider = [];
  List<ProviderUserResponse> filteredProviders = [];

  filter() async {
    if (searchController.text.trim().isEmpty) {
      filteredProviders = providers;
    } else {
      filteredProviders = providers
          .where((element) =>
              element.companyName!
                  .toLowerCase()
                  .contains(searchController.text.trim().toLowerCase()) ||
              element.state!
                  .toLowerCase()
                  .contains(searchController.text.trim().toLowerCase()) ||
              element.country!
                  .toLowerCase()
                  .contains(searchController.text.trim().toLowerCase()) ||
              element.description!
                  .toLowerCase()
                  .contains(searchController.text.trim().toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  fetchProvider(String categoryID) async {
    startLoader();
    try {
      var response = await repository.getProvidersFromCategory(categoryID);
      if (response != null) {
        List<ProviderUserResponse> data = response;
        providers = data
            .where((provider) => !blockedUsers
                .any((element) => element.uid == provider.provider?.uid))
            .toList();
        await filter();
      }
    } catch (err) {
      print(err);
    }
    stopLoader();
    notifyListeners();
  }

  fetchLocalProvider(String categoryID) async {
    try {
      var response = await repository.getLocalProvidersFromCategory(categoryID);
      if (response != null) {
        List<ProviderUserResponse> data = response;
        providers = data
            .where((provider) => !blockedUsers
                .any((element) => element.uid == provider.provider?.uid))
            .toList();
        await filter();
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
