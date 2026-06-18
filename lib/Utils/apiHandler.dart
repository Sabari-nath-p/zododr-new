import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zodo_dr/Utils/CustomAlerts.dart';
import 'package:zodo_dr/Utils/supportModels/responseModel.dart';

enum Api { GET, POST, PUT, PATCH, DELETE }

class ApiService {
  static const String baseUrl = "https://staging.zodoai.com/api/";

  ///----------------------------------------
  /// AUTH TOKEN
  ///----------------------------------------
  static Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("AUTHKEY");
  }

  ///----------------------------------------
  /// LOGGER
  ///----------------------------------------
  static void _log(String message) {
    if (kDebugMode) {
      log(message);
    }
  }

  static void _logRequest({
    required Api method,
    required Uri url,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) {
    if (!kDebugMode) return;

    _log("");
    _log("══════════════════════════════════════════════════════════");
    _log("🚀 API REQUEST");
    _log("══════════════════════════════════════════════════════════");
    _log("METHOD : ${method.name}");
    _log("URL    : $url");

    _log("HEADERS");
    headers.forEach((key, value) {
      _log("  $key : $value");
    });

    _log("BODY");
    if (body != null) {
      _log(const JsonEncoder.withIndent("  ").convert(body));
    } else {
      _log("No Body");
    }

    _log("══════════════════════════════════════════════════════════");
  }

  static void _logResponse({
    required Uri url,
    required http.Response response,
    required int time,
  }) {
    if (!kDebugMode) return;

    _log("");
    _log("══════════════════════════════════════════════════════════");
    _log("✅ API RESPONSE");
    _log("══════════════════════════════════════════════════════════");

    _log("URL         : $url");
    _log("STATUS CODE : ${response.statusCode}");
    _log("TIME TAKEN  : ${time} ms");

    _log("HEADERS");
    response.headers.forEach((key, value) {
      _log("  $key : $value");
    });

    _log("BODY");

    try {
      final decoded = json.decode(response.body);
      _log(const JsonEncoder.withIndent("  ").convert(decoded));
    } catch (_) {
      _log(response.body);
    }

    _log("══════════════════════════════════════════════════════════");
  }

  static void _logError(dynamic error) {
    if (!kDebugMode) return;

    _log("");
    _log("══════════════════════════════════════════════════════════");
    _log("❌ API ERROR");
    _log("══════════════════════════════════════════════════════════");
    _log(error.toString());
    _log("══════════════════════════════════════════════════════════");
  }

  ///----------------------------------------
  /// MAIN REQUEST
  ///----------------------------------------
  static Future<void> request({
    required String endpoint,
    Api method = Api.POST,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = true,
    Function(ResponseModel data)? onSuccess,
    Function()? onUnauthenticated,
    Function(int statusCode, String message)? onServerError,
    Function(String message)? onNetworkError,
    Function(dynamic error)? onError,
  }) async {
    try {
      final uri = Uri.parse(baseUrl + endpoint);

      final requestHeaders = <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json",
        ...?headers,
      };

      if (requiresAuth) {
        final token = await getAuthToken();

        if (token != null) {
          requestHeaders["Authorization"] = "Bearer $token";
        } else {
          onUnauthenticated?.call();
          return;
        }
      }

      _logRequest(
        method: method,
        url: uri,
        headers: requestHeaders,
        body: body,
      );

      final stopwatch = Stopwatch()..start();

      http.Response response;

      switch (method) {
        case Api.GET:
          response = await http.get(uri, headers: requestHeaders);
          break;

        case Api.POST:
          response = await http.post(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;

        case Api.PUT:
          response = await http.put(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;

        case Api.PATCH:
          response = await http.patch(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;

        case Api.DELETE:
          response = await http.delete(
            uri,
            headers: requestHeaders,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
      }

      stopwatch.stop();

      _logResponse(
        url: uri,
        response: response,
        time: stopwatch.elapsedMilliseconds,
      );

      final responseData = ResponseModel(
        statusCode: response.statusCode,
        data: response.body.isNotEmpty ? jsonDecode(response.body) : null,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess?.call(responseData);
      } else if (response.statusCode == 401) {
        if (onUnauthenticated != null) {
          onUnauthenticated();
        } else {
          Customalerts.errorAlert(
            title: "Session Expired",
            body:
                "You need to log in to continue. Please sign in and try again.",
          );
        }
      } else if (response.statusCode >= 500) {
        if (onServerError != null) {
          onServerError(response.statusCode, response.body);
        } else {
          Customalerts.errorAlert(
            title: "Server Error",
            body: "Something went wrong on our end. Please try again later.",
          );
        }
      } else {
        onSuccess?.call(responseData);
      }
    } on SocketException catch (e) {
      _logError(e);

      if (onNetworkError != null) {
        onNetworkError("Network Error : ${e.message}");
      } else {
        Customalerts.errorAlert(
          title: "No Internet",
          body: "Please check your internet connection.",
        );
      }
    } catch (e) {
      _logError(e);

      onError?.call(e);
    }
  }
}