import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/model/response.dart';

class LoginRepository {
  String baseUrl;
  IOClient ioClient;

  LoginRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doPostLogin(BuildContext context, String username, String password,
      onSuccess, onError) async {
    try {
      var url = APIEndpoint.BASE_URL + APIEndpoint.LOGIN_ENDPOINT;
      var uri = Uri.parse(url);
      var map = new Map<String, dynamic>();
      map["username"] = username;
      map["password"] = password;
      var response = await ioClient.post(
        uri,
        body: json.encode(map),
        headers: APIConfiguration(baseUrl).getDefaultHeader(),
      );
      print(uri);
      print(map.toString());
      print(response.body);
      log('cek login : ${json.decode(response.body)}');
      Response apiResponse = Response.fromJson(json.decode(response.body));
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
