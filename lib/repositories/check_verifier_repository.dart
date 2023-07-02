import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/io_client.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/model/check_verifier_response.dart';

class CheckVerifierRepository {

  String baseUrl;
  IOClient ioClient;

  CheckVerifierRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doPostVerifier(BuildContext context, String userID, String password,
      onSuccess, onError) async {
    String token = await StorageUtils.readData('token');
    try {
      var url = APIEndpoint.BASE_URL + APIEndpoint.CHECK_VERIFIER;
      var uri = Uri.parse(url);
      var map = new Map<String, dynamic>();
      map["m_user_id"] = userID;
      map["password"] = password;
      var response = await ioClient.post(
        uri,
        body: json.encode(map),
        headers: APIConfiguration(baseUrl).getDefaultHeaderWithTokens(token),
      );
      print(uri);
      print(map.toString());
      print(response.body);
      CheckVerifierResponse apiResponse = CheckVerifierResponse.fromJson(json.decode(response.body));
      if (apiResponse.success == true) {
        onSuccess(context, apiResponse);
      } else {
        onError(context, apiResponse);
      }
    } catch (exception) {
      onError(context, exception.toString());
    }
  }
}