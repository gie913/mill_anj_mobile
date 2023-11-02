import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_sounding.dart';
import 'package:sounding_storage/database/database_sounding_cpo.dart';
import 'package:sounding_storage/database/database_verifier.dart';
import 'package:sounding_storage/model/check_verifier_response.dart';
import 'package:sounding_storage/model/data_verifier.dart';
import 'package:sounding_storage/model/log_out_response.dart';
import 'package:sounding_storage/model/sounding.dart';
import 'package:sounding_storage/model/sounding_cpo.dart';
import 'package:sounding_storage/model/storage_tank.dart';
import 'package:sounding_storage/model/verifier.dart';
import 'package:sounding_storage/model/verifiers_response.dart';
import 'package:sounding_storage/repositories/check_verifier_repository.dart';
import 'package:sounding_storage/repositories/list_verificator_repository.dart';
import 'package:sounding_storage/repositories/send_sounding_repository.dart';
import 'package:sounding_storage/screens/form/form_sounding_notifier.dart';
import 'package:sounding_storage/screens/form/form_sounding_screen.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_sounding_notifier.dart';
import 'package:sounding_storage/widget/dialog/loading_dialog.dart';
import 'package:sounding_storage/widget/dialog/warning_dialog.dart';

class DetailSoundingScreen extends StatefulWidget {
  final Sounding sounding;

  DetailSoundingScreen(this.sounding);

  @override
  _DetailSoundingScreenState createState() => _DetailSoundingScreenState();
}

class _DetailSoundingScreenState extends State<DetailSoundingScreen> {
  TextEditingController productionController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController clarifierPureOil = TextEditingController();
  TextEditingController clarifier1 = TextEditingController();
  TextEditingController clarifier2 = TextEditingController();

  TextEditingController sounding1tank1 = TextEditingController();
  TextEditingController sounding2tank1 = TextEditingController();
  TextEditingController sounding3tank1 = TextEditingController();
  TextEditingController sounding4tank1 = TextEditingController();
  TextEditingController sounding5tank1 = TextEditingController();
  TextEditingController averageTank1 = TextEditingController();
  TextEditingController temperatureTank1 = TextEditingController();
  TextEditingController highTableTank1 = TextEditingController();
  TextEditingController ukuranTank1 = TextEditingController();
  TextEditingController roundingVolumeTank1 = TextEditingController();
  TextEditingController roundingTonaseTank1 = TextEditingController();

  TextEditingController sounding1tank2 = TextEditingController();
  TextEditingController sounding2tank2 = TextEditingController();
  TextEditingController sounding3tank2 = TextEditingController();
  TextEditingController sounding4tank2 = TextEditingController();
  TextEditingController sounding5tank2 = TextEditingController();
  TextEditingController averageTank2 = TextEditingController();
  TextEditingController temperatureTank2 = TextEditingController();
  TextEditingController highTableTank2 = TextEditingController();
  TextEditingController ukuranTank2 = TextEditingController();
  TextEditingController roundingVolumeTank2 = TextEditingController();
  TextEditingController roundingTonaseTank2 = TextEditingController();

  TextEditingController sounding1tank3 = TextEditingController();
  TextEditingController sounding2tank3 = TextEditingController();
  TextEditingController sounding3tank3 = TextEditingController();
  TextEditingController sounding4tank3 = TextEditingController();
  TextEditingController sounding5tank3 = TextEditingController();
  TextEditingController averageTank3 = TextEditingController();
  TextEditingController temperatureTank3 = TextEditingController();
  TextEditingController highTableTank3 = TextEditingController();
  TextEditingController ukuranTank3 = TextEditingController();
  TextEditingController roundingVolumeTank3 = TextEditingController();
  TextEditingController roundingTonaseTank3 = TextEditingController();

  TextEditingController sounding1tank4 = TextEditingController();
  TextEditingController sounding2tank4 = TextEditingController();
  TextEditingController sounding3tank4 = TextEditingController();
  TextEditingController sounding4tank4 = TextEditingController();
  TextEditingController sounding5tank4 = TextEditingController();
  TextEditingController averageTank4 = TextEditingController();
  TextEditingController temperatureTank4 = TextEditingController();
  TextEditingController highTableTank4 = TextEditingController();
  TextEditingController ukuranTank4 = TextEditingController();
  TextEditingController roundingVolumeTank4 = TextEditingController();
  TextEditingController roundingTonaseTank4 = TextEditingController();

  TextEditingController sounding1tank5 = TextEditingController();
  TextEditingController sounding2tank5 = TextEditingController();
  TextEditingController sounding3tank5 = TextEditingController();
  TextEditingController sounding4tank5 = TextEditingController();
  TextEditingController sounding5tank5 = TextEditingController();
  TextEditingController averageTank5 = TextEditingController();
  TextEditingController temperatureTank5 = TextEditingController();
  TextEditingController highTableTank5 = TextEditingController();
  TextEditingController ukuranTank5 = TextEditingController();
  TextEditingController roundingVolumeTank5 = TextEditingController();
  TextEditingController roundingTonaseTank5 = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isChecked1 = false,
      isChecked2 = false,
      isChecked3 = false,
      isChecked4 = false,
      isChecked5 = false;
  bool usingDataYesterday = false;
  String dateTime, companyName = "", companyAlias = '';
  bool _validate = false;
  String dropDownValueHint = 'STORAGE TANK 1';
  String dropDownValueVerifierHint;
  String verifierID;
  List<SoundingCpo> lisSoundingCpo = [];
  Sounding soundingDetail = Sounding();
  List<DataVerifier> listVerifier = [];

  @override
  void initState() {
    setCompanyTitle();
    getVerifier();
    soundingDetail = widget.sounding;
    dateTime = soundingDetail.trTime;
    productionController.text = soundingDetail.production;
    noteController.text = soundingDetail.note;
    if (soundingDetail.clarifierPureOil != null) {
      clarifierPureOil.text = soundingDetail.clarifierPureOil.toString();
    }
    if (soundingDetail.clarifier1 != null) {
      clarifier1.text = soundingDetail.clarifier1.toString();
    }
    if (soundingDetail.clarifier2 != null) {
      clarifier2.text = soundingDetail.clarifier2.toString();
    }
    noteController.text = soundingDetail.note;
    getSoundingCPO(widget.sounding);
    context.read<FormSoundingNotifier>().doGetStorageTank(context);
    super.initState();
  }

  setCompanyTitle() async {
    String companyNameTemp = await StorageUtils.readData('company_name');
    setState(() {
      companyName = companyNameTemp;
    });
  }

  getVerifier() async {
    List<DataVerifier> listVerifier =
        await DatabaseVerifier().selectVerifier(widget.sounding.number);
    setState(() {
      this.listVerifier = listVerifier;
    });
  }

  getSoundingCPO(Sounding sounding) async {
    String companyAliasTemp = await StorageUtils.readData('company_alias');
    setState(() {
      companyAlias = companyAliasTemp;
    });

    if (companyAlias == 'PMP') {
      getSoundingCPOPMP(sounding);
    } else {
      getSoundingCPODefault(sounding);
    }
  }

  getSoundingCPODefault(Sounding sounding) async {
    List<SoundingCpo> list =
        await DatabaseSoundingCpo().selectSoundingCpo(sounding);
    setState(() {
      lisSoundingCpo = list;
    });
    for (int i = 0; i < list.length; i++) {
      log("cek code : ${list[i].mStorageTankCode}");
      if (list[i].mStorageTankCode == "ATK1") {
        sounding1tank1.text = list[i].sounding1.toString();
        sounding2tank1.text = list[i].sounding2.toString();
        sounding3tank1.text = list[i].sounding3.toString();
        averageTank1.text = list[i].avgSounding.toString();
        temperatureTank1.text = list[i].temperature.toString();
        ukuranTank1.text = list[i].size.toStringAsFixed(3);
        isChecked1 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank1.text = list[i].roundingTonnage.toString();
      }
      if (list[i].mStorageTankCode == "ATK2") {
        sounding1tank2.text = list[i].sounding1.toString();
        sounding2tank2.text = list[i].sounding2.toString();
        sounding3tank2.text = list[i].sounding3.toString();
        averageTank2.text = list[i].avgSounding.toString();
        temperatureTank2.text = list[i].temperature.toString();
        ukuranTank2.text = list[i].size.toStringAsFixed(3);
        isChecked2 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank2.text = list[i].roundingTonnage.toString();
      }
      if (list[i].mStorageTankCode == "ATK3") {
        sounding1tank3.text = list[i].sounding1.toString();
        sounding2tank3.text = list[i].sounding2.toString();
        sounding3tank3.text = list[i].sounding3.toString();
        averageTank3.text = list[i].avgSounding.toString();
        temperatureTank3.text = list[i].temperature.toString();
        ukuranTank3.text = list[i].size.toStringAsFixed(3);
        isChecked3 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank3.text = list[i].roundingTonnage.toString();
      }
      if (list[i].mStorageTankCode == "ATK4") {
        sounding1tank4.text = list[i].sounding1.toString();
        sounding2tank4.text = list[i].sounding2.toString();
        sounding3tank4.text = list[i].sounding3.toString();
        averageTank4.text = list[i].avgSounding.toString();
        temperatureTank4.text = list[i].temperature.toString();
        ukuranTank4.text = list[i].size.toStringAsFixed(3);
        isChecked4 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank4.text = list[i].roundingTonnage.toString();
      }
      if (list[i].mStorageTankCode == "ATK5") {
        sounding1tank5.text = list[i].sounding1.toString();
        sounding2tank5.text = list[i].sounding2.toString();
        sounding3tank5.text = list[i].sounding3.toString();
        averageTank5.text = list[i].avgSounding.toString();
        temperatureTank5.text = list[i].temperature.toString();
        ukuranTank5.text = list[i].size.toStringAsFixed(3);
        isChecked5 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank5.text = list[i].roundingTonnage.toString();
      }
    }
  }

  getSoundingCPOPMP(Sounding sounding) async {
    List<SoundingCpo> list =
        await DatabaseSoundingCpo().selectSoundingCpo(sounding);
    setState(() {
      lisSoundingCpo = list;
    });
    for (int i = 0; i < list.length; i++) {
      log("cek code : ${list[i].mStorageTankCode}");
      if (list[i].mStorageTankCode == "ATK1") {
        sounding1tank1.text = list[i].sounding1.toString();
        sounding2tank1.text = list[i].sounding2.toString();
        sounding3tank1.text = list[i].sounding3.toString();
        averageTank1.text = list[i].avgSounding.toString();
        temperatureTank1.text = list[i].temperature.toString();
        ukuranTank1.text = list[i].size.toStringAsFixed(3);
        isChecked1 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank1.text = list[i].roundingTonnage.toString();
      }
      if (list[i].mStorageTankCode == "ATK2") {
        sounding1tank2.text = list[i].sounding1.toString();
        sounding2tank2.text = list[i].sounding2.toString();
        sounding3tank2.text = list[i].sounding3.toString();
        averageTank2.text = list[i].avgSounding.toString();
        temperatureTank2.text = list[i].temperature.toString();
        ukuranTank2.text = list[i].size.toStringAsFixed(3);
        isChecked2 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank2.text = list[i].roundingTonnage.toString();
      }
      if (list[i].mStorageTankCode == "ATK11") {
        sounding1tank3.text = list[i].sounding1.toString();
        sounding2tank3.text = list[i].sounding2.toString();
        sounding3tank3.text = list[i].sounding3.toString();
        averageTank3.text = list[i].avgSounding.toString();
        temperatureTank3.text = list[i].temperature.toString();
        ukuranTank3.text = list[i].size.toStringAsFixed(3);
        isChecked3 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank3.text = list[i].roundingTonnage.toString();
      }
      if (list[i].mStorageTankCode == "ATK12") {
        sounding1tank4.text = list[i].sounding1.toString();
        sounding2tank4.text = list[i].sounding2.toString();
        sounding3tank4.text = list[i].sounding3.toString();
        averageTank4.text = list[i].avgSounding.toString();
        temperatureTank4.text = list[i].temperature.toString();
        ukuranTank4.text = list[i].size.toStringAsFixed(3);
        isChecked4 = list[i].isManual;
        if (list[i].usingCopyData != null) {
          usingDataYesterday = list[i].usingCopyData;
        }
        roundingTonaseTank4.text = list[i].roundingTonnage.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Detail Sounding")),
        actions: [
          widget.sounding.sent == "true"
              ? Container()
              : InkWell(
                  onTap: () async {
                    Sounding soundingTemp = await Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return FormSoundingScreen(widget.sounding);
                    }));
                    if (soundingTemp != null) {
                      getSoundingCPO(soundingTemp);
                      soundingDetail = soundingTemp;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Typicons.edit),
                  ),
                ),
        ],
      ),
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    companyName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("BERITA ACARA SOUNDING"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Diukur Tanggal", style: text14Bold),
                      Text(soundingDetail.trTime)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Untuk Produksi", style: text14Bold),
                      Flexible(
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              enabled: false,
                              controller: productionController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  errorText: _validate ? 'Belum Terisi' : null,
                                  counterText: ""),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Tidak Mengolah", style: text14Bold),
                      Flexible(
                        child: Checkbox(
                            checkColor: Colors.white,
                            value: usingDataYesterday,
                            onChanged: null),
                      ),
                    ],
                  ),
                  Divider(),
                  Text(
                    "Sounding Storage",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Consumer<FormSoundingNotifier>(
                      builder: (context, formSounding, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Tanki", style: text14Bold),
                        Flexible(
                          child: Container(
                            child: Card(
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                      alignment: Alignment.centerRight,
                                      value: dropDownValueHint,
                                      items: formSounding.items
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                value: item.toString(),
                                                child: Text(item),
                                              ))
                                          .toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropDownValueHint = newValue;
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  if (companyAlias == 'PMP')
                    Consumer<FormSoundingNotifier>(
                      builder: (context, formSounding, child) {
                        return formSounding.storageTank.isNotEmpty
                            ? dropDownValueHint == 'STORAGE TANK 1'
                                ? containerTank1(formSounding.storageTank[0])
                                : dropDownValueHint == 'STORAGE TANK 2'
                                    ? containerTank2(
                                        formSounding.storageTank[1])
                                    : dropDownValueHint == 'STORAGE TANK 1 CPKO'
                                        ? containerTank3(
                                            formSounding.storageTank[2])
                                        : dropDownValueHint ==
                                                'STORAGE TANK 2 CPKO'
                                            ? containerTank4(
                                                formSounding.storageTank[3])
                                            : Container()
                            : Container();
                      },
                    )
                  else
                    Consumer<FormSoundingNotifier>(
                      builder: (context, formSounding, child) {
                        return formSounding.storageTank.isNotEmpty
                            ? dropDownValueHint == 'STORAGE TANK 1'
                                ? containerTank1(formSounding.storageTank[0])
                                : dropDownValueHint == 'STORAGE TANK 2'
                                    ? containerTank2(
                                        formSounding.storageTank[1])
                                    : dropDownValueHint == 'STORAGE TANK 3'
                                        ? containerTank3(
                                            formSounding.storageTank[2])
                                        : dropDownValueHint == 'STORAGE TANK 4'
                                            ? containerTank4(
                                                formSounding.storageTank[3])
                                            : dropDownValueHint ==
                                                    'STORAGE TANK 5'
                                                ? containerTank5(
                                                    formSounding.storageTank[4])
                                                : Container()
                            : Container();
                      },
                    ),
                  Divider(),
                  Text(
                    "Sounding Clarifikasi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Catatan", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              enabled: false,
                              controller: noteController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  errorText: _validate ? 'Belum Terisi' : null,
                                  counterText: ""),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Clarifier Pure Oil", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: clarifierPureOil,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  errorText: _validate ? 'Belum Terisi' : null,
                                  counterText: ""),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Clarifier Tank 1", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: clarifier1,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  errorText: _validate ? 'Belum Terisi' : null,
                                  counterText: ""),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Clarifier Tank 2", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: clarifier2,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  errorText: _validate ? 'Belum Terisi' : null,
                                  counterText: ""),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Disaksikan Oleh", style: text14Bold),
                      Container(
                        child: ElevatedButton(
                          onPressed: () async {
                            doSetVerifier();
                          },
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  listVerifier.isNotEmpty
                      ? Container(
                          height: 80 * listVerifier.length.toDouble(),
                          child: ListView.builder(
                              itemCount: listVerifier.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.account_circle,
                                        color: Colors.blue),
                                    title: Text('${listVerifier[index].name}'),
                                    subtitle: Text(
                                        '${listVerifier[index].levelLabel}'),
                                  ),
                                );
                              }),
                        )
                      : Container(),
                  SizedBox(height: 20),
                  widget.sounding.sent != "true"
                      ? OutlinedButton(
                          onPressed: () {
                            showSoundingSendDialog(
                                context, widget.sounding, lisSoundingCpo);
                          },
                          child: Container(
                            padding: EdgeInsets.all(14),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Kirim",
                              textAlign: TextAlign.center,
                              style: text16Bold,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget containerTank1(StorageTank storageTank) {
    highTableTank1.text = storageTank.surfacePlate.toString();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 1 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding1tank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 2 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding2tank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 3 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding3tank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rata-rata (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: averageTank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Temperatur (°C)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: temperatureTank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Tinggi Meja Ukur ", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Ukuran", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: ukuranTank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Manual Input", style: text14Bold),
              Flexible(
                child: Checkbox(
                  checkColor: Colors.white,
                  value: isChecked1,
                  onChanged: null,
                ),
              ),
            ],
          ),
          isChecked1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Rounding Tonase (ton)", style: text14Bold),
                    Flexible(
                      child: Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            controller: roundingTonaseTank1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                errorText: _validate ? 'Belum Terisi' : null,
                                counterText: ""),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget containerTank2(StorageTank storageTank) {
    highTableTank2.text = storageTank.surfacePlate.toString();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 1 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding1tank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 2 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding2tank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 3 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding3tank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rata-rata (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: averageTank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Temperatur (°C)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: temperatureTank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Tinggi Meja Ukur ", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Ukuran", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: ukuranTank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Manual Input", style: text14Bold),
              Flexible(
                child: Checkbox(
                  checkColor: Colors.white,
                  value: isChecked2,
                  onChanged: null,
                ),
              ),
            ],
          ),
          isChecked2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Rounding Tonase (ton)", style: text14Bold),
                    Flexible(
                      child: Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            controller: roundingTonaseTank2,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                errorText: _validate ? 'Belum Terisi' : null,
                                counterText: ""),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget containerTank3(StorageTank storageTank) {
    highTableTank3.text = storageTank.surfacePlate.toString();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 1 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding1tank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 2 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding2tank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 3 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding3tank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rata-rata (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: averageTank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Temperatur (°C)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: temperatureTank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Tinggi Meja Ukur ", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Ukuran", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: ukuranTank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Manual Input", style: text14Bold),
              Flexible(
                child: Checkbox(
                  checkColor: Colors.white,
                  value: isChecked3,
                  onChanged: null,
                ),
              ),
            ],
          ),
          isChecked3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Rounding Tonase (ton)", style: text14Bold),
                    Flexible(
                      child: Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            controller: roundingTonaseTank3,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                errorText: _validate ? 'Belum Terisi' : null,
                                counterText: ""),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget containerTank4(StorageTank storageTank) {
    highTableTank4.text = storageTank.surfacePlate.toString();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 1 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding1tank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 2 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding2tank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 3 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding3tank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rata-rata (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: averageTank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Temperatur (°C)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: temperatureTank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Tinggi Meja Ukur ", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Ukuran", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: ukuranTank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Manual Input", style: text14Bold),
              Flexible(
                child: Checkbox(
                  checkColor: Colors.white,
                  value: isChecked4,
                  onChanged: null,
                ),
              ),
            ],
          ),
          isChecked4
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Rounding Tonase (ton)", style: text14Bold),
                    Flexible(
                      child: Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            controller: roundingTonaseTank4,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                errorText: _validate ? 'Belum Terisi' : null,
                                counterText: ""),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget containerTank5(StorageTank storageTank) {
    highTableTank5.text = storageTank.surfacePlate.toString();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 1 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding1tank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 2 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding2tank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sounding 3 (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: sounding3tank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rata-rata (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: averageTank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Temperatur (°C)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: temperatureTank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Tinggi Meja Ukur ", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Ukuran", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: ukuranTank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Belum Terisi' : null,
                          counterText: ""),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Manual Input", style: text14Bold),
              Flexible(
                child: Checkbox(
                  checkColor: Colors.white,
                  value: isChecked5,
                  onChanged: null,
                ),
              ),
            ],
          ),
          isChecked5
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Rounding Tonase (ton)", style: text14Bold),
                    Flexible(
                      child: Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            controller: roundingTonaseTank5,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                errorText: _validate ? 'Belum Terisi' : null,
                                counterText: ""),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  showSoundingSendDialog(BuildContext context, Sounding sounding,
      List<SoundingCpo> listSoundingCpo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Kirim Data"),
          content: Text("Pastikan data Anda sudah terisi lengkap dan benar"),
          actions: [
            TextButton(
              child: Text(Strings.YES,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                doSendSounding(sounding, listSoundingCpo);
              },
            ),
            TextButton(
              child: Text(Strings.NO,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future _showDialog(context, VerifierResponse response) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Saksi", style: text14Bold),
                    Flexible(
                      child: Container(
                        width: 200,
                        child: Card(
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                  value: dropDownValueVerifierHint,
                                  items: response.verifier
                                      .map((Verifier item) =>
                                          DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(item.name),
                                          ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropDownValueVerifierHint = newValue;
                                      verifierID = newValue;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Password", style: text14Bold),
                    Flexible(
                      child: Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: TextField(
                            controller: passwordController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                                errorText: _validate ? 'Belum Terisi' : null,
                                counterText: ""),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        doCheckVerifier(verifierID, passwordController.text);
                      },
                      child: Container(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          "Verifikasi",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ]);
            },
          ),
        );
      },
    );
  }

  doSendSounding(Sounding sounding, List<SoundingCpo> soundingCpo) {
    if (listVerifier.length >= 2) {
      List<String> verifier = [];
      for (int i = 0; i < listVerifier.length; i++) {
        verifier.add(listVerifier[i].mUserId);
      }
      loadingDialog(context);
      SendSoundingRepository(APIEndpoint.BASE_URL).doSendSoundingRepository(
          sounding, soundingCpo, verifier, onSuccess, onError);
    } else {
      doSetVerifier();
    }
  }

  onSuccess(LogOutResponse response) {
    Navigator.pop(context);
    print(response.message);
    DatabaseSounding().updateSoundingTransferred(widget.sounding);
    warningDialog(context, "Pengiriman Berhasil", response.message);
    context.read<ListSoundingNotifier>().updateListView();
    context.read<HomeNotifier>().doGetSoundingUnsent();
  }

  onError(response) {
    warningDialog(context, "Pengiriman Gagal", response.message);
  }

  doSetVerifier() {
    loadingDialog(context);
    ListVerifierRepository(APIEndpoint.BASE_URL)
        .doGetListVerifier(onSuccessVerifier, onErrorVerifier);
  }

  onSuccessVerifier(VerifierResponse response) {
    Navigator.pop(context);
    _showDialog(context, response);
  }

  onErrorVerifier(response) {
    warningDialog(context, "Koneksi Gagal", response.message);
  }

  doCheckVerifier(String userID, String password) {
    loadingDialog(context);
    CheckVerifierRepository(APIEndpoint.BASE_URL).doPostVerifier(context,
        userID, password, onSuccessCheckVerifier, onErrorCheckVerifier);
  }

  onSuccessCheckVerifier(BuildContext context, CheckVerifierResponse response) {
    Navigator.pop(context);
    Navigator.pop(context);
    setState(() {
      passwordController.clear();
      dropDownValueVerifierHint = null;
    });
    if (listVerifier.isNotEmpty) {
      DataVerifier verifierTemp = DataVerifier();
      verifierTemp.mUserId = response.data.mUserId;
      verifierTemp.name = response.data.name;
      verifierTemp.levelLabel = response.data.levelLabel;
      verifierTemp.idForm = widget.sounding.number;
      var contain = listVerifier
          .where((element) => element.mUserId == verifierTemp.mUserId);
      if (contain.isEmpty) {
        listVerifier.add(verifierTemp);
        setState(() {});
        DatabaseVerifier().insertVerifier(verifierTemp);
      } else {
        Fluttertoast.showToast(
          msg: "Sudah masuk verifikasi",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      DataVerifier verifierTemp = DataVerifier();
      verifierTemp.mUserId = response.data.mUserId;
      verifierTemp.name = response.data.name;
      verifierTemp.levelLabel = response.data.levelLabel;
      verifierTemp.idForm = widget.sounding.number;
      listVerifier.add(verifierTemp);
      DatabaseVerifier().insertVerifier(verifierTemp);
      setState(() {});
    }
  }

  onErrorCheckVerifier(BuildContext context, response) {
    warningDialog(context, "Koneksi Gagal", response.message);
  }
}
