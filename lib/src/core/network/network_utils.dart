import 'dart:convert';
import 'dart:io';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:http/http.dart' as http;

class Network {
  static Future<http.Response> getRequest({required String api, params}) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request Params: $params");

    var headers = {
      'Accept': 'application/json',
    };

    http.Response response = await http.get(
      Uri.parse(api).replace(queryParameters: params),
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> postRequest({
    required String api,
    body,
    bool addContentType = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
    };

    if (addContentType) {
      headers['Content-Type'] = 'application/json';
    }

    http.Response response = await http.post(
      Uri.parse(api),
      body: body,
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> putRequest({
    required String api,
    body,
    bool addContentType = false,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
    };

    if (addContentType) {
      headers['Content-Type'] = 'application/json';
    }

    http.Response response = await http.put(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> deleteRequest({
    required String api,
    body,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint('\nYou hit: $api');
    kPrint('Request Body: ${jsonEncode(body)}');

    var headers = {
      'Accept': 'application/json',
    };

    http.Response response = await http.delete(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static multipartAddRequest({
    required String api,
    required Map<String, String> body,
    required List<String> fileKeyNames,
    required List<String> filePaths,
  }) async {
    if (!await ConnectivityService.hasInternet) {
      throw Message.noInternet;
    }

    kPrint("\nYou hit: $api");
    kPrint("Request body: $body");

    var request = http.MultipartRequest('POST', Uri.parse(api))
      ..fields.addAll(body);

    for (var i = 0; i < fileKeyNames.length; i++) {
      if (filePaths[i].isNotEmpty) {
        kPrint("${fileKeyNames[i]} : ${filePaths[i]}");

        request.files.add(
          await http.MultipartFile.fromPath(fileKeyNames[i], filePaths[i]),
        );
      }
    }

    var streamedResponse = await request.send();
    Log.info(
        "files: ${request.files.map((file) => file.filename).toList().toString()}");
    Log.info("fields: ${request.fields}");

    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  static handleResponse(http.Response response) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        kPrint('SuccessCode: ${response.statusCode}');
        kPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {
        _logout();
        String msg = Message.error401;
        msg = findFirstError(response);
        throw msg;
      } else if (response.statusCode == 404) {
        String msg = Message.error404;
        msg = findFirstError(response);
        throw msg;
      } else if (response.statusCode == 500) {
        String msg = Message.error500;
        msg = findFirstError(response);
        throw msg;
      } else {
        kPrint('ErrorCode: ${response.statusCode}');
        kPrint('ErrorResponse: ${response.body}');

        String msg = Message.unknown;
        msg = findFirstError(response);
        throw msg;
      }
    } on SocketException catch (_) {
      throw Message.noInternet;
    } on FormatException catch (_) {
      throw Message.badResponse;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Function to dynamically find errors
  static String findFirstError(http.Response response) {
    Map<String, dynamic> errors = jsonDecode(response.body);

    /// Check for `data`
    if (errors['data'] is Map) {
      List<String> errorMessages = [];
      errors['data'].forEach((field, messages) {
        for (var message in messages) {
          errorMessages.add('$message');
        }
      });

      return errorMessages.first;
    }

    /// Check for `message`
    else if (errors['message'] is String) {
      return errors['message'];
    }

    /// Check for `errors`
    else if (errors['errors'] is Map) {
      List<String> errorMessages = [];
      errors['errors'].forEach((field, messages) {
        for (var message in messages) {
          errorMessages.add('$message');
        }
      });

      return errorMessages.first;
    } else if (errors['errors'] is String) {
      return errors['errors'];
    } else {
      return response.body;
    }
  }

  /// To convert raw data to form data
  /// Map<String, dynamic> to Map<String, String>
  static Map<String, String> flattenMap(Map<String, dynamic> data,
      [String parentKey = '']) {
    Map<String, String> result = {};

    data.forEach((key, value) {
      String newKey = parentKey.isEmpty ? key : '$parentKey[$key]';

      if (value is Map) {
        /// Recursively flatten the nested map
        result.addAll(flattenMap(value as Map<String, dynamic>, newKey));
      } else {
        /// Add the value as a String
        result[newKey] = value.toString();
      }
    });

    return result;
  }

  static void _logout() {}
}
