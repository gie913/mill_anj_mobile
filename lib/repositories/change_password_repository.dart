import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/model/log_out_response.dart';

class ChangePasswordRepository {
  String baseUrl;
  IOClient ioClient;

  ChangePasswordRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doChangePassword(String oldPassword, String newPassword,
      String confirmPassword, onSuccess, onLoading, onError) async {
    onLoading();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var map = new Map<String, dynamic>();
      map["new_password"] = newPassword;
      map["confirm_password"] = confirmPassword;
      map["old_password"] = oldPassword;
      var url = baseUrl + APIEndpoint.CHANGE_PASSWORD;
      var uri = Uri.parse(url);
      var response = await ioClient.post(
        uri,
        body: json.encode(map),
        headers: APIConfiguration(baseUrl).getDefaultHeaderWithTokens(token),
      );
      LogOutResponse apiResponse =
      LogOutResponse.fromJson(json.decode(response.body));
      if (apiResponse.success == true) {
        onSuccess(apiResponse.message);
      } else {
        onError(apiResponse.message);
      }
    } catch (exception) {
      onError(exception);
    }
  }
}
