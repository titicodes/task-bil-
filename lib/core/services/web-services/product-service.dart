import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../locator.dart';
import '../../models/get-category-response.dart';
import '../../models/prodiders-service-response.dart';
import '../../models/skills-response.dart';
import '../local-service/storage-service.dart';
import '../local-service/user.service.dart';
import 'base-api.dart';

class ProductService {
  StorageService storageService = locator<StorageService>();
  UserService userService = locator<UserService>();

  Future<GetCategoryResponse?> getCategories({int? page}) async {
  try {
    final queryParams = {"page": page ?? 1};
    final response = await connect().get(
      "/service/categories",
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.data);

      // Potential issue: Check if "results" is empty before parsing
      if (responseData['results'] == null || responseData['results'].isEmpty) {
        print('API returned empty categories list for page $page');
        // Handle empty results in the view model (e.g., return empty list)
        return null;
      }

      return GetCategoryResponse.fromJson(responseData);
    } else {
      print('Error fetching categories. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching categories: $e');
  }

  return null;
}


  // Future<GetCategoryResponse?> getCategories({int? page}) async {
  //   try {
  //     final queryParams = {"page": page ?? 1};
  //     final response = await connect().get(
  //       "/service/categories",
  //       queryParameters: queryParams,
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.data);
  //       // final transformedJson = transformJson(responseData);
  //       return GetCategoryResponse.fromJson(responseData);
  //     } else {
  //       print('Error fetching categories. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching categories: $e');
  //   }

  //   return null;
  // }

  // Map<String, dynamic> transformJson(Map<String, dynamic> originalJson) {
  //   final results = originalJson['results'] as List<dynamic>;
  //   final transformedResult = results.map((item) {
  //     return {'name': item['name'] as String,"uid":item["uid"]}; // Access by key 'name'
  //   }).toList();

  //   return {
  //     'count': originalJson['count'],
  //     'next': originalJson['next'],
  //     'previous': originalJson['previous'],
  //     'results': transformedResult,
  //   };
  // }

  Future<GetSkillsResponse?> getCategoriesSkills(String categoryID,
      {int? page}) async {
    try {
      Response response = await connect()
          .get("/service/categories/$categoryID/skills/?page=${page ?? '1'}");
      GetSkillsResponse? dataResponse =
          GetSkillsResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }
//   Future<GetSkillsResponse?> getCategoriesSkills(String categoryID, {int? page}) async {
//   try {
//     var queryParams = {"page": page ?? 1};
//     Response response = await connect()
//         .get("/service/categories/$categoryID/skills", queryParameters: queryParams);
//     GetSkillsResponse? dataResponse =
//         GetSkillsResponse.fromJson(jsonDecode(response.data));
//     return dataResponse;
//   } on DioError catch (e) {
//     print(e.response);
//     return null;
//   }
// }

  Future<List<ProviderUserResponse>?> getProvidersFromCategory(
      String categoryID) async {
    try {
      Response response =
          await connect().get("/service/by_category/?category_id=$categoryID");
      List<ProviderUserResponse>? dataResponse =
          geProviderUserListFromJson(response.data);
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<List<ProviderUserResponse>?> getPopularProviders(
      {String? categoryId}) async {
    try {
      final response = await connect().get("/service/by_category/",
          queryParameters: {'category_id': categoryId});
      List<ProviderUserResponse>? dataResponse =
          geProviderUserListFromJson(response.data);
      return dataResponse;
    } on DioError catch (e) {
      print(
          "Dio error fetching popular providers: ${e.response?.data ?? e.message}");
      return null;
    } catch (error) {
      print("Error fetching popular providers: $error");
      return null;
    }
  }
}
