import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/app/service/http_client.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final storage = GetStorage();

//--------------post api call------------//
  Future<ApiResponse<T>> postApi<T>(
    String endPoint, {
    Map<String, dynamic>? requestBody,
    bool? isTokenRequired,
    T Function(dynamic json)? responseType,
  }) async {
    try {
      // log("----- he request body is $requestBody");

      final response = await httpClient
          .post(Uri.parse(endPoint),
              headers: {
                'Content-Type':
                    'application/json', // Adjust content type if necessary
              },
              body: jsonEncode(requestBody))
          .timeout(Duration(minutes: 1));
      log('  this is teh status code ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        // log(" this is the json $json");

        final data = responseType != null ? responseType(json) : json as T;
        // log(" thi sis the data $data");

        return ApiResponse.completed(data);
      } else {
        log("API client: line 41 -- testing error");
        final jsonData = jsonDecode(response.body);
        final message = ApiMessage().getMessage(response.statusCode);
        if (endPoint == 'oauth/token' && response.statusCode == 400) {
          log(":::::::::::status code 400 error $message");

          return ApiResponse.error(message);
        }

        if (response.statusCode == 401 || response.statusCode == 404) {
          log(':::::::::::status code 401 error $message');
          return ApiResponse.error(jsonData['error']);
        }
        if (response.statusCode == 406 ||
            response.statusCode == 400 ||
            response.statusCode == 203 ||
            response.statusCode == 500) {
          return ApiResponse.error(jsonData['message']);
        }
        log(':::::::::::status code 500 error $message');

        return ApiResponse.error(message);
      }
    } on SocketException {
      return ApiResponse.error("Server Error");
    } catch (e) {
      log(' THIS IS THE CATCH ERRROR ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<T>> getApi<T>(
    String endPoint, {
    bool? isTokenRequired,
    T Function(dynamic json)? responseType,
  }) async {
    try {
      final response = await httpClient
          .get(Uri.parse(endPoint))
          .timeout(Duration(minutes: 1));
      log('this is the response ${response.statusCode}');

      return _processResponse<T>(response, responseType);
    } on SocketException {
      return ApiResponse.error("No Internet connection");
    } catch (e) {
      log('Exception in GET API call: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }

  ApiResponse<T> _processResponse<T>(
    http.Response response,
    T Function(dynamic json)? responseType,
  ) {
    try {
      final json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = responseType != null ? responseType(json) : json as T;
        // log('this is the data $data');
        return ApiResponse.completed(data);
      } else {
        final message = ApiMessage().getMessage(response.statusCode);

        if (response.statusCode == 400 &&
            json is Map &&
            json.containsKey('message')) {
          return ApiResponse.error(json['message']);
        } else if (response.statusCode == 401 || response.statusCode == 404) {
          return ApiResponse.error(json['error']);
        } else if (response.statusCode == 406 ||
            response.statusCode == 500 ||
            response.statusCode == 502) {
          return ApiResponse.error(json['message'] ?? message);
        }

        return ApiResponse.error(message);
      }
    } catch (e) {
      log('Exception in processing response: ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }
}

class ApiResponse<T> {
  final ApiStatus status;
  final T? response;
  final String? message;

  ApiResponse.initial([this.message])
      : status = ApiStatus.INITIAL,
        response = null;

  ApiResponse.loading([this.message])
      : status = ApiStatus.LOADING,
        response = null;

  ApiResponse.completed(this.response)
      : status = ApiStatus.SUCCESS,
        message = null;

  ApiResponse.error([this.message])
      : status = ApiStatus.ERROR,
        response = null;

  @override
  String toString() {
    return "Status: $status\nData: $response\nMessage: $message";
  }
}

class ApiMessage {
  String getMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid Credentials';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Server Error';
      case 502:
        return 'Bad Gateway';
      default:
        return 'Error getting data. Error Code: $statusCode';
    }
  }
}

enum ApiStatus { INITIAL, LOADING, SUCCESS, ERROR }
