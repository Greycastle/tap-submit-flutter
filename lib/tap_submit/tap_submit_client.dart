import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tap_submit/tap_submit/tap_submit_response.dart';

class TapSubmitClient {
  final String apiKey;
  final bool verbose;

  TapSubmitClient({required this.apiKey, this.verbose = false});

  Future<TapSubmitResponse> submit(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('https://tap-submit.greycastle.se/messages'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'data': data,
      }),
    );

    if (response.statusCode != 200) {
      try {
        final errorResponse = jsonDecode(response.body);
        final message = errorResponse['error'];
        final code = _parseErrorCode(response.statusCode, message);

        return TapSubmitResponse(
          success: false,
          errorMessage: message,
          errorCode: code,
        );
      } catch (e, st) {
        _log("$e\n$st");
        return TapSubmitResponse(
          success: false,
          errorMessage: response.body,
          errorCode: TapSubmitErrorCode.serverError,
        );
      }
    }

    return TapSubmitResponse(success: true);
  }

  TapSubmitErrorCode _parseErrorCode(int statusCode, String message) {
    if (message.contains('403')) {
      return TapSubmitErrorCode.invalidApiKey;
    }

    return TapSubmitErrorCode.serverError;
  }

  void _log(String message) {
    if (verbose) {
      debugPrint(message);
    }
  }
}
