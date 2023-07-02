import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/model/verifiers_response.dart';

class ListVerifierRepository {

  String baseUrl;
  IOClient ioClient;

  ListVerifierRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doGetListVerifier(onSuccess, onError) async {
    String token = await StorageUtils.readData('token');
    try {
      var url = baseUrl + APIEndpoint.LIST_VERIFIER;
      var uri = Uri.parse(url);
      var response = await ioClient.get(
        uri,
        headers: APIConfiguration(baseUrl).getDefaultHeaderWithToken(token),
      );
      print(response.body);
      VerifierResponse apiResponse =
      VerifierResponse.fromJson(json.decode(response.body));
      if (apiResponse.success == true) {
        onSuccess(apiResponse);
      } else {
        onError(apiResponse);
      }
    } catch (exception) {
      onError(exception);
    }
  }
}