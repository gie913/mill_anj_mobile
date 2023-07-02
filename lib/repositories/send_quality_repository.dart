import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/model/log_out_response.dart';
import 'package:sounding_storage/model/quality.dart';
import 'package:sounding_storage/model/quality_check.dart';
import 'package:sounding_storage/model/send_quality_body.dart';

class SendQualityRepository {
  String baseUrl;
  IOClient ioClient;

  SendQualityRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doSendQualityRepository(Quality quality,
      List<QualityCheck> qualityCheck, List<String> verifier, onSuccess, onError) async {
    String token = await StorageUtils.readData('token');
    quality.qualityCheck = qualityCheck;
    Map<String, dynamic> qualityMap = json.decode(json.encode(quality));
    qualityMap['verificators'] = verifier;
    SendQualityBody sendQualityBody = SendQualityBody.fromJson(qualityMap);
    var url = this.baseUrl + APIEndpoint.SEND_QUALITY;
    var uri = Uri.parse(url);
    final map = jsonEncode(sendQualityBody);
    try {
      var response = await ioClient.post(
        uri,
        body: map,
        headers: APIConfiguration(baseUrl).getDefaultHeaderWithTokens(token),
      );
      String responseBody = response.body;
      Map<String, dynamic> responseJson = json.decode(responseBody);
      LogOutResponse apiResponse =
      LogOutResponse.fromJson(responseJson);
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
