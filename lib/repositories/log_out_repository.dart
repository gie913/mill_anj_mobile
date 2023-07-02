import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/model/log_out_response.dart';

class LogOutRepository {

  String baseUrl;
  IOClient ioClient;

  LogOutRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doGetLogOut(BuildContext context, String token, onSuccess, onError) async {
    try {
      var url = baseUrl + APIEndpoint.LOGOUT_ENDPOINT;
      var uri = Uri.parse(url);
      var response = await ioClient.get(
        uri,
        headers: APIConfiguration(baseUrl).getDefaultHeaderWithToken(token),
      );
      LogOutResponse apiResponse =
      LogOutResponse.fromJson(json.decode(response.body));
      print(response.body);
      if (apiResponse.success == true) {
        onSuccess(context, apiResponse);
      } else {
        onError(context, apiResponse.message);
      }
    } catch (exception) {
      onError(context, exception.toString());
    }
  }
}
