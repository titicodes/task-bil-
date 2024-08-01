import 'package:flutter/cupertino.dart';
import 'package:taskitly/routes/routes.dart';

import '../../../core/models/all_selected_categories_list.dart';
import '../../../core/models/get-category-response.dart';
import '../../base/base.vm.dart';
import 'bookmark/bookmark-ui.dart';

class BrowseViewViewModel extends BaseViewModel {
  GetCategoryResponse? categoryResponse;
  List<Category> categories = [];
  List<Category> displayCategories = [];
  var searchController = TextEditingController();

  filterCategory() {
    if (searchController.text.trim().isEmpty) {
      displayCategories = categories;
    } else {
      displayCategories = categories
          .where((category) => category.name!
              .toLowerCase()
              .contains(searchController.text.trim().toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  init() async {
    await getLocalCategories();
    getCategories();
  }

  navigateToBookmark() async {
    navigationService.navigateToWidget(const BookmarkScreen());
  }

  Future<GetCategoryResponse?> getLocalCategories() async {
    startLoader();
    var response = await repository.getLocalCategories();
    categoryResponse = response;
    if (response?.results != null) {
      categories = response?.results ?? [];
      filterCategory();
    }
    stopLoader();
    notifyListeners();
    return response;
  }

  Future<GetCategoryResponse?> getCategories() async {
    startLoader();
    try {
      var response = await repository.getCategories();
      categoryResponse = response;
      if (response?.results != null) {
        categories = response?.results ?? [];
        filterCategory();
      }
      stopLoader();
      notifyListeners();
      return response;
    } catch (err) {
      print(err);
      stopLoader();
      notifyListeners();
      return null;
    }
  }

  goToCategory(Category category) {
    appCache.category = category;
    print(category);
  }

  onTap(Category selectedCategory) async {
    appCache.category = selectedCategory;
    navigationService.navigateTo(categoryDetailRoute);
  }
}
