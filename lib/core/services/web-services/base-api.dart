import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskitly/constants/reuseables.dart';
import 'package:taskitly/core/services/local-service/user.service.dart';

import '../../../locator.dart';
import '../../../utils/snack_message.dart';
import '../local-service/storage-service.dart';
import 'auth.api.dart';
import 'nertwork_config.dart';

StorageService storageService = locator<StorageService>();
AuthenticationApiService auth = locator<AuthenticationApiService>();
String? newToken;

connect() {
  BaseOptions options = BaseOptions(
      baseUrl: NetworkConfig.BASE_URL,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        print(options.uri.path);
        print(options.data.toString());
        options.validateStatus = (status) => true;
        final box = GetStorage();
        String? value = box.read(DbTable.TOKEN_TABLE_NAME);
        print("ACCESS TOKEN::: $value");
        if (value != null && value.isNotEmpty) {
          options.uri.path == "/account/verify-otp/"
              ? null
              : options.headers['Authorization'] = "Token $value";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        print("SERVER STATUS::: ${response.statusCode}");
        print("SERVER RESPONSE::: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        if (e.response == null) {
          showCustomToast("Connect Internet to proceed");
          return handler.next(e);
        } else {
          Map<String, dynamic> jsonMap = {};
          print(e.response?.statusCode);

          if (isJson(e.response?.data)) {
            jsonMap = jsonDecode(e.response?.data);
            print("RECEIVED ${jsonMap['detail']}");
            if (jsonMap['detail'] == null) {
              e.requestOptions.uri.path.contains("notification/device/gcm/")
                  ? null
                  : showCustomToast(displayFirstMessages(jsonMap));
            } else {
              e.requestOptions.uri.path.contains("notification/device/gcm/")
                  ? null
                  : handleError(e);
            }
          } else {
            if (isHtml((e.response?.data).toString())) {
              String title = getTitleFromHtml((e.response?.data).toString());
              print('<title>$title</title>');
            } else {
              e.requestOptions.uri.path.contains("notification/device/gcm/")
                  ? null
                  : showCustomToast((e.response?.data).toString());
            }
          }
          return handler.next(e);
        }
        // return handler.next(e);
      },
    ),
  );

  return dio;
}

String getTitleFromHtml(String htmlString) {
  RegExp regex = RegExp(r'<title>(.*?)<\/title>');
  Match? match = regex.firstMatch(htmlString);
  if (match != null) {
    return match.group(1)!;
  } else {
    return 'No title found';
  }
}

bool isHtml(String text) {
  RegExp regex = RegExp(r'<[^>]+>');
  return regex.hasMatch(text);
}

bool isJson(String str) {
  try {
    json.decode(str);
    return true;
  } catch (e) {
    return false;
  }
}

privateConnect() {
  BaseOptions options = BaseOptions(
      baseUrl: NetworkConfig.BASE_URL,
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // print(options.uri.path);
        // print(options.data.toString());
        final box = GetStorage();
        String? value = box.read(DbTable.TOKEN_TABLE_NAME);
        // print("ACCESS TOKEN::: $value");
        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = "Token $value";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // print("SERVER RESPONSE::: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        if (e.response == null) {
          showCustomToast("Connect Internet to proceed");
          return handler.next(e);
        } else {
          Map<String, dynamic> jsonMap = {};
          print(e.response?.statusCode);
          print(e.response?.data);
          // print(jsonDecode(jsonEncode(e.response?.data))['detail']);
          print(e.response?.statusMessage);

          // handleError(e);
          jsonMap = jsonDecode(e.response?.data);
          print(jsonMap['detail']);
          if (jsonMap['detail'] == null) {
            showCustomToast(displayFirstMessages(jsonMap));
          } else {
            handleError(e);
          }
          return handler.next(e);
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
}

withdrawConnect() {
  BaseOptions options = BaseOptions(
      baseUrl: NetworkConfig.BASE_URL,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      responseType: ResponseType.plain);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // print(options.uri.path);
        // print(options.data.toString());
        final box = GetStorage();
        String? value = box.read(DbTable.TOKEN_TABLE_NAME);
        // print("ACCESS TOKEN::: $value");
        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = "Token $value";
          options.headers['Content-Type'] = 'application/json';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // print("SERVER RESPONSE::: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        Map<String, dynamic> jsonMap = {};
        if (e.response != null) {
          print(e.response?.statusCode);
          print(e.response?.data);
          // print(jsonDecode(jsonEncode(e.response?.data))['detail']);
          print(e.response?.statusMessage);

          // handleError(e);
          jsonMap = jsonDecode(e.response?.data);
          print(jsonMap['detail']);
          if (jsonMap['detail'] == null) {
            showCustomToast(displayFirstMessages(jsonMap));
          } else {
            handleError(e);
          }
        } else {
          handleError(e);
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
}

String displayFirstMessages(Map<String, dynamic> jsonMap) {
  String errorMessage = "";
  List<String> list = [];

  // Extract and display the first message from each list
  jsonMap.forEach((key, value) {
    if (value is List && value.isNotEmpty) {
      list = [...list, "${value[0]}"];
    }
  });

  for (int i = 0; i < list.length; i++) {
    errorMessage += '• ${list[i]}';

    if (i < list.length - 1) {
      // Add line break unless it's the last item
      errorMessage += '\n';
    }
  }

  return errorMessage;
}

// privateConnect() {
//   BaseOptions options = BaseOptions(
//       baseUrl: NetworkConfig.BASE_URL,
//       connectTimeout: const Duration(milliseconds: 100000),
//       receiveTimeout: const Duration(milliseconds: 100000),
//       responseType: ResponseType.plain);
//   Dio dio = Dio(options);
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         // print(options.uri.path);
//         SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//         String? value = sharedPreferences.getString(DbTable.TOKEN_TABLE_NAME);
//
//         if (value != null && value.isNotEmpty) {
//           options.headers['Authorization'] = "token $value";
//         }
//         return handler.next(options);
//       },
//       onResponse: (response, handler) async {
//         return handler.next(response);
//       },
//       onError: (DioError e, handler) async {
//         // handleError(e);
//         if (e.response?.statusCode == 401 &&
//             jsonDecode(e.response!.data)['message'] != null &&
//             jsonDecode(e.response!.data)['message']
//                 .toString()
//                 .contains("token")) {
//           await storageService.storage.deleteAll();
//           locator<NavigationService>().navigateToAndRemoveUntil(homeRoute);
//         }
//         return handler.next(e);
//       },
//     ),
//   );
//
//   return dio;
// }

// Future<bool> refreshAuthToken() async {
//   final refreshToken_ = await storageService.readItem(key: refreshToken);
//   try {
//     Response response = await connect()
//         .post('api/v1/auth/token/refresh/', data: {'refresh': refreshToken_});
//
//     if (response.statusCode == 201 || response.statusCode == 200) {
//       print('refresh token went through');
//       print("result : ${response.data}");
//       newToken = jsonDecode(response.data)['access'];
//       storageService.storeItem(
//           key: accessToken, value: jsonDecode(response.data)['access']);
//
//       return true;
//     } else if (response.statusCode == 401) {
//       print('refreshAuthToken');
//       return false;
//     } else {
//       print('refresh token is wrong');
//       storageService.deleteItem(key: refreshToken);
//       storageService.deleteItem(key: accessToken);
//
//       return false;
//     }
//   } catch (e) {
//     return false;
//   }
// }

// Future _retry(RequestOptions requestOptions) async {
//   final options = Options(
//       method: requestOptions.method,
//       headers: {HttpHeaders.authorizationHeader: 'Bearer $newToken'});
//
//   return connect().request(requestOptions.path,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//       options: options);
// }

void handleError(dynamic error) {
  var errorString = error.response.toString();
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.cancel:
        // showCustomToast("Request to API server was cancelled");
        break;
      case DioErrorType.connectionError:
        // showCustomToast("Connection timeout with API server");
        break;
      case DioErrorType.unknown:
        showCustomToast(
            "Please enable internet connection to use ${AppStrings.appName} App ");
        break;
      case DioErrorType.receiveTimeout:
        // showCustomToast("Receive timeout in connection with API server");
        break;
      case DioErrorType.badResponse:
        final errorMessage = jsonDecode(error.response?.data)["detail"];
        if (errorMessage != null) {
          if (errorMessage.toString().contains("Invalid token")) {
            // showCustomToast(errorMessage);
            locator<UserService>().logout();
          } else {
            if (isJson(errorMessage.toString())) {
              showCustomToast(jsonDecode(errorMessage["message"]));
            } else {
              showCustomToast(errorMessage.toString());
            }
            print(errorMessage);
          }
        } else {
          print("FINAL DATA=== ${jsonDecode(error.response?.data)["detail"]}");
          showCustomToast(jsonDecode(error.response?.data)["detail"]);
        }
        break;
      case DioErrorType.sendTimeout:
        // showCustomToast("Send timeout in connection with API server");
        break;
      default:
        showCustomToast("Something went wrong");
        break;
    }
  } else {
    var json = jsonDecode(errorString);
    var nameJson = json['message'];
    showCustomToast(nameJson);
    return;
  }
}
