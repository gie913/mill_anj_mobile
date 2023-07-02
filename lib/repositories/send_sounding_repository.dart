import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:sounding_storage/base/api/api_configuration.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/model/log_out_response.dart';
import 'package:sounding_storage/model/send_sounding_body.dart';
import 'package:sounding_storage/model/sounding.dart';
import 'package:sounding_storage/model/sounding_cpo.dart';

class SendSoundingRepository {
  String baseUrl;
  IOClient ioClient;

  SendSoundingRepository(String baseUrl) {
    this.baseUrl = baseUrl;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    this.ioClient = new IOClient(httpClient);
  }

  void doSendSoundingRepository(Sounding sounding,
      List<SoundingCpo> soundingCpo, List<String> verifier, onSuccess, onError) async {
    String token = await StorageUtils.readData('token');
    List<SoundingCpo> listSoundingCpoTemp = [];
    for(int i=0; i<soundingCpo.length;i++) {
      if(soundingCpo[i].isManual == true) {
        soundingCpo[i].roundingTonnage = soundingCpo[i].roundingTonnage * 1000;
      }
      listSoundingCpoTemp.add(soundingCpo[i]);
    }
    sounding.soundingCpo = listSoundingCpoTemp;
    Map<String, dynamic> soundingMap = json.decode(json.encode(sounding));
    soundingMap['verificators'] = verifier;
    SendSoundingBody sendSoundingBody = SendSoundingBody.fromJson(soundingMap);
    var url = this.baseUrl + APIEndpoint.SEND_SOUNDING;
    var uri = Uri.parse(url);
    final map = jsonEncode(sendSoundingBody);
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
