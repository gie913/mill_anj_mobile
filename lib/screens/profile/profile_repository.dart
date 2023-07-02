import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/model/profile_response.dart';

class ProfileRepository {

  String baseUrl;
  IOClient ioClient;

  ProfileRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doGetProfile(onSuccess, onError) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var url = baseUrl + APIEndpoint.PROFILE;
      var uri = Uri.parse(url);
      var response = await ioClient.get(
        uri,
        headers: APIConfiguration(baseUrl).getDefaultHeaderWithToken(token),
      );
      ProfileResponse apiResponse =
      ProfileResponse.fromJson(json.decode(response.body));
      if (apiResponse.success == true) {
        onSuccess(apiResponse.user);
      } else {
        onError(apiResponse.message);
      }
    } catch (exception) {
      onError(exception);
    }
  }
}