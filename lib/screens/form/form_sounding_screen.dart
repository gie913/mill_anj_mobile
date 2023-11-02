import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/sounding_function.dart';
import 'package:sounding_storage/base/time_utils.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_sounding.dart';
import 'package:sounding_storage/database/database_sounding_cpo.dart';
import 'package:sounding_storage/model/sounding.dart';
import 'package:sounding_storage/model/sounding_cpo.dart';
import 'package:sounding_storage/model/storage_tank.dart';
import 'package:sounding_storage/screens/form/form_sounding_notifier.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_sounding_notifier.dart';

class FormSoundingScreen extends StatefulWidget {
  final Sounding sounding;

  FormSoundingScreen(this.sounding);

  @override
  _FormSoundingScreenState createState() => _FormSoundingScreenState();
}

class _FormSoundingScreenState extends State<FormSoundingScreen> {
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

  String dateTime, soundingId, companyName = "", companyAlias = "";
  bool _validate = false;
  String dropDownValueHint = 'STORAGE TANK 1';
  double density1, density2, density3, density4, density5;
  bool usingDataYesterday = false;
  String storageTankCode1,
      storageTankCode2,
      storageTankCode3,
      storageTankCode4,
      storageTankCode5;
  String storageTankID1,
      storageTankID2,
      storageTankID3,
      storageTankID4,
      storageTankID5;
  double size1, size2, size3, size4, size5;
  bool isChecked1 = false,
      isChecked2 = false,
      isChecked3 = false,
      isChecked4 = false,
      isChecked5 = false;

  @override
  void initState() {
    setCompanyTitle();
    if (widget.sounding != null) {
      thisEdit(widget.sounding);
    } else {
      thisNew();
    }
    super.initState();
  }

  getListSoundingCpoYesterday() async {
    String companyAliasTemp = await StorageUtils.readData('company_alias');
    setState(() {
      companyAlias = companyAliasTemp;
    });

    if (companyAlias == 'PMP') {
      getListSoundingCpoYesterdayPMP();
    } else {
      getListSoundingCpoYesterdayDefault();
    }
  }

  getListSoundingCpoYesterdayDefault() async {
    List<SoundingCpo> list =
        await DatabaseSoundingCpo().selectSoundingYesterday();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        log('cek code : ${list[i].mStorageTankCode}');
        if (list[i].mStorageTankCode == "ATK1") {
          sounding1tank1.text = list[i].sounding1.toString();
          sounding2tank1.text = list[i].sounding2.toString();
          sounding3tank1.text = list[i].sounding3.toString();
          averageTank1.text = list[i].avgSounding.toString();
          temperatureTank1.text = list[i].temperature.toString();
          ukuranTank1.text = list[i].size.toStringAsFixed(3);
          isChecked1 = list[i].isManual;
          storageTankCode1 = list[i].mStorageTankCode;
          storageTankID1 = list[i].mStorageTankId;
          size1 = list[i].size;
          density1 = list[i].density;
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
          storageTankCode2 = list[i].mStorageTankCode;
          storageTankID2 = list[i].mStorageTankId;
          size2 = list[i].size;
          density2 = list[i].density;
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
          storageTankCode3 = list[i].mStorageTankCode;
          storageTankID3 = list[i].mStorageTankId;
          size3 = list[i].size;
          density3 = list[i].density;
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
          storageTankCode4 = list[i].mStorageTankCode;
          storageTankID4 = list[i].mStorageTankId;
          size4 = list[i].size;
          density4 = list[i].density;
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
          storageTankCode5 = list[i].mStorageTankCode;
          storageTankID5 = list[i].mStorageTankId;
          size5 = list[i].size;
          density5 = list[i].density;
          roundingTonaseTank5.text = list[i].roundingTonnage.toString();
        }
      }
    } else {
      setState(() {
        usingDataYesterday = false;
      });
      Fluttertoast.showToast(
        msg: "Data Sounding Kemarin Tidak ada",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  getListSoundingCpoYesterdayPMP() async {
    List<SoundingCpo> list =
        await DatabaseSoundingCpo().selectSoundingYesterday();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        log('cek code : ${list[i].mStorageTankCode}');
        if (list[i].mStorageTankCode == "ATK1") {
          sounding1tank1.text = list[i].sounding1.toString();
          sounding2tank1.text = list[i].sounding2.toString();
          sounding3tank1.text = list[i].sounding3.toString();
          averageTank1.text = list[i].avgSounding.toString();
          temperatureTank1.text = list[i].temperature.toString();
          ukuranTank1.text = list[i].size.toStringAsFixed(3);
          isChecked1 = list[i].isManual;
          storageTankCode1 = list[i].mStorageTankCode;
          storageTankID1 = list[i].mStorageTankId;
          size1 = list[i].size;
          density1 = list[i].density;
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
          storageTankCode2 = list[i].mStorageTankCode;
          storageTankID2 = list[i].mStorageTankId;
          size2 = list[i].size;
          density2 = list[i].density;
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
          storageTankCode3 = list[i].mStorageTankCode;
          storageTankID3 = list[i].mStorageTankId;
          size3 = list[i].size;
          density3 = list[i].density;
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
          storageTankCode4 = list[i].mStorageTankCode;
          storageTankID4 = list[i].mStorageTankId;
          size4 = list[i].size;
          density4 = list[i].density;
          roundingTonaseTank4.text = list[i].roundingTonnage.toString();
        }
      }
    } else {
      setState(() {
        usingDataYesterday = false;
      });
      Fluttertoast.showToast(
        msg: "Data Sounding Kemarin Tidak ada",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  clearListSoundingCpoYesterday() async {
    sounding1tank1.clear();
    sounding2tank1.clear();
    sounding3tank1.clear();
    averageTank1.clear();
    temperatureTank1.clear();
    ukuranTank1.clear();
    isChecked1 = false;
    size1 = 0;
    density1 = 0;
    roundingTonaseTank1.clear();
    sounding1tank2.clear();
    sounding2tank2.clear();
    sounding3tank2.clear();
    averageTank2.clear();
    temperatureTank2.clear();
    ukuranTank2.clear();
    isChecked2 = false;
    size2 = 0;
    density2 = 0;
    roundingTonaseTank2.clear();
    sounding1tank3.clear();
    sounding2tank3.clear();
    sounding3tank3.clear();
    averageTank3.clear();
    temperatureTank3.clear();
    ukuranTank3.clear();
    isChecked3 = false;
    size3 = 0;
    density3 = 0;
    roundingTonaseTank3.clear();
    sounding1tank4.clear();
    sounding2tank4.clear();
    sounding3tank4.clear();
    averageTank4.clear();
    temperatureTank4.clear();
    ukuranTank4.clear();
    isChecked4 = false;
    size4 = 0;
    density4 = 0;
    roundingTonaseTank4.clear();
    sounding1tank5.clear();
    sounding2tank5.clear();
    sounding3tank5.clear();
    averageTank5.clear();
    temperatureTank5.clear();
    ukuranTank5.clear();
    isChecked5 = false;
    size5 = 0;
    density5 = 0;
    roundingTonaseTank5.clear();
    Fluttertoast.showToast(
      msg: "Data Sounding Kemarin Dihapus dari Form",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  thisNew() {
    setState(() {
      dateTime = TimeUtils.getTime(DateTime.now());
      context.read<FormSoundingNotifier>().items.clear();
      context.read<FormSoundingNotifier>().doGetStorageTank(context);
      productionController.text = "CPO";
    });
  }

  setCompanyTitle() async {
    String companyNameTemp = await StorageUtils.readData('company_name');
    String companyAliasTemp = await StorageUtils.readData('company_alias');
    log('companyName : $companyNameTemp');
    log('companyAlias : $companyAliasTemp');
    setState(() {
      companyName = companyNameTemp;
      companyAlias = companyAliasTemp;
      if (widget.sounding == null) {
        soundingId = companyAlias.toLowerCase() +
            "s" +
            TimeUtils.getIDOnTime(DateTime.now());
      }
    });
  }

  thisEdit(Sounding sounding) {
    setState(() {
      dateTime = sounding.trTime;
      soundingId = sounding.number;
      context.read<FormSoundingNotifier>().items.clear();
      context.read<FormSoundingNotifier>().doGetStorageTank(context);
      getSoundingCPO(sounding);
      productionController.text = sounding.production;
      noteController.text = sounding.note;
      if (sounding.clarifierPureOil != null) {
        clarifierPureOil.text = sounding.clarifierPureOil.toString();
      }
      if (sounding.clarifier1 != null) {
        clarifier1.text = sounding.clarifier1.toString();
      }
      if (sounding.clarifier2 != null) {
        clarifier2.text = sounding.clarifier2.toString();
      }
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
    for (int i = 0; i < list.length; i++) {
      if (list[i].mStorageTankCode == "ATK1") {
        sounding1tank1.text = list[i].sounding1.toString();
        sounding2tank1.text = list[i].sounding2.toString();
        sounding3tank1.text = list[i].sounding3.toString();
        averageTank1.text = list[i].avgSounding.toString();
        temperatureTank1.text = list[i].temperature.toString();
        ukuranTank1.text = list[i].size.toStringAsFixed(3);
        isChecked1 = list[i].isManual;
        storageTankCode1 = list[i].mStorageTankCode;
        storageTankID1 = list[i].mStorageTankId;
        size1 = list[i].size;
        density1 = list[i].density;
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
        storageTankCode2 = list[i].mStorageTankCode;
        storageTankID2 = list[i].mStorageTankId;
        size2 = list[i].size;
        density2 = list[i].density;
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
        storageTankCode3 = list[i].mStorageTankCode;
        storageTankID3 = list[i].mStorageTankId;
        size3 = list[i].size;
        density3 = list[i].density;
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
        storageTankCode4 = list[i].mStorageTankCode;
        storageTankID4 = list[i].mStorageTankId;
        size4 = list[i].size;
        density4 = list[i].density;
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
        storageTankCode5 = list[i].mStorageTankCode;
        storageTankID5 = list[i].mStorageTankId;
        size5 = list[i].size;
        density5 = list[i].density;
        roundingTonaseTank5.text = list[i].roundingTonnage.toString();
      }
    }
  }

  getSoundingCPOPMP(Sounding sounding) async {
    List<SoundingCpo> list =
        await DatabaseSoundingCpo().selectSoundingCpo(sounding);
    for (int i = 0; i < list.length; i++) {
      if (list[i].mStorageTankCode == "ATK1") {
        sounding1tank1.text = list[i].sounding1.toString();
        sounding2tank1.text = list[i].sounding2.toString();
        sounding3tank1.text = list[i].sounding3.toString();
        averageTank1.text = list[i].avgSounding.toString();
        temperatureTank1.text = list[i].temperature.toString();
        ukuranTank1.text = list[i].size.toStringAsFixed(3);
        isChecked1 = list[i].isManual;
        storageTankCode1 = list[i].mStorageTankCode;
        storageTankID1 = list[i].mStorageTankId;
        size1 = list[i].size;
        density1 = list[i].density;
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
        storageTankCode2 = list[i].mStorageTankCode;
        storageTankID2 = list[i].mStorageTankId;
        size2 = list[i].size;
        density2 = list[i].density;
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
        storageTankCode3 = list[i].mStorageTankCode;
        storageTankID3 = list[i].mStorageTankId;
        size3 = list[i].size;
        density3 = list[i].density;
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
        storageTankCode4 = list[i].mStorageTankCode;
        storageTankID4 = list[i].mStorageTankId;
        size4 = list[i].size;
        density4 = list[i].density;
        roundingTonaseTank4.text = list[i].roundingTonnage.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Form Sounding")),
      ),
      body: Container(
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
                  Divider(color: Colors.orange, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Diukur Tanggal", style: text14Bold),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            initialValue: dateTime,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Tanggal',
                            timeLabelText: "Waktu",
                            onChanged: (val) {
                              setState(() {
                                dateTime = val +
                                    ":" +
                                    DateTime.now().second.toString();
                              });
                            },
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                dateTime = val;
                              });
                            },
                          ),
                        ),
                      ),
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
                              controller: productionController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  enabled: false,
                                  border: InputBorder.none,
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
                          onChanged: (bool value) {
                            setState(() {
                              usingDataYesterday = value;
                              if (usingDataYesterday) {
                                showDataYesterdayDialog(context);
                              } else {
                                showClearDataYesterdayDialog(context);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Sounding Storage",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
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
                                          print(
                                              'cek dropDownValueHint : $dropDownValueHint');
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
                  SizedBox(height: 10),
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
                              controller: noteController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(width: 1),
                                  ),
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(width: 1),
                                  ),
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(width: 1),
                                  ),
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(width: 1),
                                  ),
                                  errorText: _validate ? 'Belum Terisi' : null,
                                  counterText: ""),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      showSaveDialog(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(14),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Simpan",
                        textAlign: TextAlign.center,
                        style: text16Bold,
                      ),
                    ),
                  ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage(storageTank);
                      },
                      controller: sounding1tank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage(storageTank);
                      },
                      controller: sounding2tank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage(storageTank);
                      },
                      controller: sounding3tank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage(storageTank);
                      },
                      controller: temperatureTank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
              Text("Tinggi Meja Ukur (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                  onChanged: (bool value) {
                    setState(() {
                      isChecked1 = value;
                      sounding1tank1.text = "0";
                      sounding2tank1.text = "0";
                      sounding3tank1.text = "0";
                      averageTank1.text = "0";
                      temperatureTank1.text = "0";
                      ukuranTank1.text = "0";
                      onChangeAverage(storageTank);
                    });
                  },
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(',')),
                            ],
                            controller: roundingTonaseTank1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1),
                                ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage2(storageTank);
                      },
                      controller: sounding1tank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage2(storageTank);
                      },
                      controller: sounding2tank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage2(storageTank);
                      },
                      controller: sounding3tank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage2(storageTank);
                      },
                      controller: temperatureTank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
              Text("Tinggi Meja Ukur (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                  onChanged: (bool value) {
                    setState(() {
                      isChecked2 = value;
                      sounding1tank2.text = "0";
                      sounding2tank2.text = "0";
                      sounding3tank2.text = "0";
                      averageTank2.text = "0";
                      temperatureTank2.text = "0";
                      ukuranTank2.text = "0";
                      onChangeAverage2(storageTank);
                    });
                  },
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(',')),
                            ],
                            controller: roundingTonaseTank2,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1),
                                ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage3(storageTank);
                      },
                      controller: sounding1tank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage3(storageTank);
                      },
                      controller: sounding2tank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage3(storageTank);
                      },
                      controller: sounding3tank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage3(storageTank);
                      },
                      controller: temperatureTank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
              Text("Tinggi Meja Ukur (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank3,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                  onChanged: (bool value) {
                    setState(() {
                      isChecked3 = value;
                      sounding1tank3.text = "0";
                      sounding2tank3.text = "0";
                      sounding3tank3.text = "0";
                      averageTank3.text = "0";
                      temperatureTank3.text = "0";
                      ukuranTank3.text = "0";
                      onChangeAverage3(storageTank);
                    });
                  },
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(',')),
                            ],
                            controller: roundingTonaseTank3,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1),
                                ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage4(storageTank);
                      },
                      controller: sounding1tank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage4(storageTank);
                      },
                      controller: sounding2tank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage4(storageTank);
                      },
                      controller: sounding3tank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage4(storageTank);
                      },
                      controller: temperatureTank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
              Text("Tinggi Meja Ukur (cm) ", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank4,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                  onChanged: (bool value) {
                    setState(() {
                      isChecked4 = value;
                      sounding1tank4.text = "0";
                      sounding2tank4.text = "0";
                      sounding3tank4.text = "0";
                      averageTank4.text = "0";
                      temperatureTank4.text = "0";
                      ukuranTank4.text = "0";
                      onChangeAverage4(storageTank);
                    });
                  },
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(',')),
                            ],
                            controller: roundingTonaseTank4,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1),
                                ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage5(storageTank);
                      },
                      controller: sounding1tank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage5(storageTank);
                      },
                      controller: sounding2tank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage5(storageTank);
                      },
                      controller: sounding3tank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(',')),
                      ],
                      onChanged: (value) {
                        onChangeAverage5(storageTank);
                      },
                      controller: temperatureTank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1),
                          ),
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
              Text("Tinggi Meja Ukur (cm)", style: text14Bold),
              Flexible(
                child: Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: highTableTank5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
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
                  onChanged: (bool value) {
                    setState(() {
                      isChecked5 = value;
                      sounding1tank5.text = "0";
                      sounding2tank5.text = "0";
                      sounding3tank5.text = "0";
                      averageTank5.text = "0";
                      temperatureTank5.text = "0";
                      ukuranTank5.text = "0";
                      onChangeAverage5(storageTank);
                    });
                  },
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
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(',')),
                            ],
                            controller: roundingTonaseTank5,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1),
                                ),
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

  onChangeAverage(StorageTank storageTank) {
    try {
      density1 = storageTank.density;
      SoundingFunction soundingFunction = SoundingFunction();
      double sounding1 = double.parse(sounding1tank1.text);
      double sounding2 = double.parse(sounding2tank1.text);
      double sounding3 = double.parse(sounding3tank1.text);
      double average =
          soundingFunction.averageSounding(sounding1, sounding2, sounding3);
      if (average != null) {
        double ukuran =
            soundingFunction.measureSounding(average, storageTank.surfacePlate);
        size1 = ukuran;
        storageTankCode1 = storageTank.code;
        storageTankID1 = storageTank.id;
        ukuranTank1.text = ukuran.toStringAsFixed(3);
        averageTank1.text = average.toStringAsFixed(3);
      } else {
        averageTank1.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  onChangeAverage2(StorageTank storageTank) {
    try {
      density2 = storageTank.density;
      SoundingFunction soundingFunction = SoundingFunction();
      double sounding1 = double.parse(sounding1tank2.text);
      double sounding2 = double.parse(sounding2tank2.text);
      double sounding3 = double.parse(sounding3tank2.text);
      double average =
          soundingFunction.averageSounding(sounding1, sounding2, sounding3);
      if (average != null) {
        double ukuran =
            soundingFunction.measureSounding(average, storageTank.surfacePlate);
        size2 = ukuran;
        storageTankCode2 = storageTank.code;
        storageTankID2 = storageTank.id;
        ukuranTank2.text = ukuran.toStringAsFixed(3);
        averageTank2.text = average.toStringAsFixed(3);
      } else {
        averageTank2.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  onChangeAverage3(StorageTank storageTank) {
    try {
      density3 = storageTank.density;
      SoundingFunction soundingFunction = SoundingFunction();
      double sounding1 = double.parse(sounding1tank3.text);
      double sounding2 = double.parse(sounding2tank3.text);
      double sounding3 = double.parse(sounding3tank3.text);
      double average =
          soundingFunction.averageSounding(sounding1, sounding2, sounding3);
      if (average != null) {
        double ukuran =
            soundingFunction.measureSounding(average, storageTank.surfacePlate);
        size3 = ukuran;
        storageTankCode3 = storageTank.code;
        storageTankID3 = storageTank.id;
        ukuranTank3.text = ukuran.toStringAsFixed(3);
        averageTank3.text = average.toStringAsFixed(3);
      } else {
        averageTank3.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  onChangeAverage4(StorageTank storageTank) {
    try {
      density4 = storageTank.density;
      SoundingFunction soundingFunction = SoundingFunction();
      double sounding1 = double.parse(sounding1tank4.text);
      double sounding2 = double.parse(sounding2tank4.text);
      double sounding3 = double.parse(sounding3tank4.text);
      double average =
          soundingFunction.averageSounding(sounding1, sounding2, sounding3);
      if (average != null) {
        double ukuran =
            soundingFunction.measureSounding(average, storageTank.surfacePlate);
        size4 = ukuran;
        storageTankCode4 = storageTank.code;
        storageTankID4 = storageTank.id;
        ukuranTank4.text = ukuran.toStringAsFixed(3);
        averageTank4.text = average.toStringAsFixed(3);
      } else {
        averageTank4.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  onChangeAverage5(StorageTank storageTank) {
    try {
      density5 = storageTank.density;
      SoundingFunction soundingFunction = SoundingFunction();
      double sounding1 = double.parse(sounding1tank5.text);
      double sounding2 = double.parse(sounding2tank5.text);
      double sounding3 = double.parse(sounding3tank5.text);
      double average =
          soundingFunction.averageSounding(sounding1, sounding2, sounding3);
      if (average != null) {
        double ukuran =
            soundingFunction.measureSounding(average, storageTank.surfacePlate);
        size5 = ukuran;
        storageTankCode5 = storageTank.code;
        storageTankID5 = storageTank.id;
        ukuranTank5.text = ukuran.toStringAsFixed(3);
        averageTank5.text = average.toStringAsFixed(3);
      } else {
        averageTank5.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  doSaveToDatabase() async {
    if (averageTank1.text.isNotEmpty && temperatureTank1.text.isNotEmpty ||
        averageTank2.text.isNotEmpty && temperatureTank2.text.isNotEmpty ||
        averageTank3.text.isNotEmpty && temperatureTank3.text.isNotEmpty ||
        averageTank4.text.isNotEmpty && temperatureTank4.text.isNotEmpty ||
        averageTank5.text.isNotEmpty && temperatureTank5.text.isNotEmpty) {
      String username = await StorageUtils.readData('username');
      int maxSounding = await StorageUtils.readData('max_sounding');
      Sounding sounding = Sounding();
      sounding.number = soundingId;
      sounding.trTime = dateTime;
      sounding.production = productionController.text;
      sounding.note = noteController.text.toString();
      sounding.createdBy = username;
      sounding.sent = "false";
      sounding.additional = 0;
      sounding.totalStock = 0;
      if (clarifierPureOil.text.isNotEmpty) {
        sounding.clarifierPureOil =
            double.parse(clarifierPureOil.text.toString());
      }
      if (clarifier1.text.isNotEmpty) {
        sounding.clarifier1 = double.parse(clarifier1.text.toString());
      }
      if (clarifier2.text.isNotEmpty) {
        sounding.clarifier2 = double.parse(clarifier2.text.toString());
      }
      if (widget.sounding != null) {
        int soundingCount = await DatabaseSounding().updateSounding(sounding);
        if (soundingCount > 0) {
          if (averageTank1.text.isNotEmpty &&
              temperatureTank1.text.isNotEmpty) {
            SoundingCpo soundingCpo1 = SoundingCpo();
            soundingCpo1.number = soundingId + "1";
            soundingCpo1.trTime = dateTime;
            soundingCpo1.density = density1;
            soundingCpo1.sounding1 = double.parse(sounding1tank1.text);
            soundingCpo1.sounding2 = double.parse(sounding2tank1.text);
            soundingCpo1.sounding3 = double.parse(sounding3tank1.text);
            soundingCpo1.temperature = double.parse(temperatureTank1.text);
            soundingCpo1.avgSounding = double.parse(averageTank1.text);
            soundingCpo1.mStorageTankCode = storageTankCode1;
            soundingCpo1.mStorageTankId = storageTankID1;
            soundingCpo1.size = size1;
            soundingCpo1.sounding4 = double.parse("0.0");
            soundingCpo1.sounding5 = double.parse("0.0");
            soundingCpo1.maxSounding = maxSounding;
            soundingCpo1.soundingId = soundingId;
            soundingCpo1.isManual = isChecked1;
            soundingCpo1.createdBy = username;
            soundingCpo1.usingCopyData = usingDataYesterday;
            if (isChecked1) {
              soundingCpo1.roundingTonnage =
                  double.parse(roundingTonaseTank1.text);
            } else {
              soundingCpo1.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo1);
            if (exist > 0) {
              int soundingCountCpo1 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo1);
              print("edited sounding cpo 1 $soundingCountCpo1");
            } else {
              int soundingCountCpo1 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo1);
              print("insert sounding cpo 1 $soundingCountCpo1");
            }
          }
          if (averageTank2.text.isNotEmpty &&
              temperatureTank2.text.isNotEmpty) {
            SoundingCpo soundingCpo2 = SoundingCpo();
            soundingCpo2.number = soundingId + "2";
            soundingCpo2.trTime = dateTime;
            soundingCpo2.density = density2;
            soundingCpo2.sounding1 = double.parse(sounding1tank2.text);
            soundingCpo2.sounding2 = double.parse(sounding2tank2.text);
            soundingCpo2.sounding3 = double.parse(sounding3tank2.text);
            soundingCpo2.sounding4 = double.parse("0.0");
            soundingCpo2.sounding5 = double.parse("0.0");
            soundingCpo2.temperature = double.parse(temperatureTank2.text);
            soundingCpo2.avgSounding = double.parse(averageTank2.text);
            soundingCpo2.mStorageTankCode = storageTankCode2;
            soundingCpo2.mStorageTankId = storageTankID2;
            soundingCpo2.size = size2;
            soundingCpo2.maxSounding = maxSounding;
            soundingCpo2.soundingId = soundingId;
            soundingCpo2.isManual = isChecked2;
            soundingCpo2.createdBy = username;
            soundingCpo2.usingCopyData = usingDataYesterday;
            if (isChecked2) {
              soundingCpo2.roundingTonnage =
                  double.parse(roundingTonaseTank2.text);
            } else {
              soundingCpo2.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo2);
            if (exist > 0) {
              int soundingCountCpo2 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo2);
              print("edited sounding cpo 2 $soundingCountCpo2");
            } else {
              int soundingCountCpo2 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo2);
              print("insert sounding cpo 2 $soundingCountCpo2");
            }
          }
          if (averageTank3.text.isNotEmpty &&
              temperatureTank3.text.isNotEmpty) {
            SoundingCpo soundingCpo3 = SoundingCpo();
            soundingCpo3.number = soundingId + "3";
            soundingCpo3.trTime = dateTime;
            soundingCpo3.density = density3;
            soundingCpo3.sounding1 = double.parse(sounding1tank3.text);
            soundingCpo3.sounding2 = double.parse(sounding2tank3.text);
            soundingCpo3.sounding3 = double.parse(sounding3tank3.text);
            soundingCpo3.sounding4 = double.parse("0.0");
            soundingCpo3.sounding5 = double.parse("0.0");
            soundingCpo3.temperature = double.parse(temperatureTank3.text);
            soundingCpo3.avgSounding = double.parse(averageTank3.text);
            soundingCpo3.mStorageTankCode = storageTankCode3;
            soundingCpo3.mStorageTankId = storageTankID3;
            soundingCpo3.size = size3;
            soundingCpo3.maxSounding = maxSounding;
            soundingCpo3.soundingId = soundingId;
            soundingCpo3.isManual = isChecked3;
            soundingCpo3.createdBy = username;
            soundingCpo3.usingCopyData = usingDataYesterday;
            if (isChecked3) {
              soundingCpo3.roundingTonnage =
                  double.parse(roundingTonaseTank3.text);
            } else {
              soundingCpo3.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo3);
            if (exist > 0) {
              int soundingCountCpo3 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo3);
              print("edited sounding cpo 3 $soundingCountCpo3");
            } else {
              int soundingCountCpo3 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo3);
              print("insert sounding cpo 3 $soundingCountCpo3");
            }
          }
          if (averageTank4.text.isNotEmpty &&
              temperatureTank4.text.isNotEmpty) {
            SoundingCpo soundingCpo4 = SoundingCpo();
            soundingCpo4.number = soundingId + "4";
            soundingCpo4.trTime = dateTime;
            soundingCpo4.density = density4;
            soundingCpo4.sounding1 = double.parse(sounding1tank4.text);
            soundingCpo4.sounding2 = double.parse(sounding2tank4.text);
            soundingCpo4.sounding3 = double.parse(sounding3tank4.text);
            soundingCpo4.sounding4 = double.parse("0.0");
            soundingCpo4.sounding5 = double.parse("0.0");
            soundingCpo4.temperature = double.parse(temperatureTank4.text);
            soundingCpo4.avgSounding = double.parse(averageTank4.text);
            soundingCpo4.mStorageTankCode = storageTankCode4;
            soundingCpo4.mStorageTankId = storageTankID4;
            soundingCpo4.size = size4;
            soundingCpo4.maxSounding = maxSounding;
            soundingCpo4.soundingId = soundingId;
            soundingCpo4.isManual = isChecked4;
            soundingCpo4.createdBy = username;
            soundingCpo4.usingCopyData = usingDataYesterday;
            if (isChecked4) {
              soundingCpo4.roundingTonnage =
                  double.parse(roundingTonaseTank4.text);
            } else {
              soundingCpo4.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo4);
            if (exist > 0) {
              int soundingCountCpo4 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo4);
              print("edited sounding cpo 4 $soundingCountCpo4");
            } else {
              int soundingCountCpo4 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo4);
              print("insert sounding cpo 4 $soundingCountCpo4");
            }
          }
          if (averageTank5.text.isNotEmpty &&
              temperatureTank5.text.isNotEmpty) {
            SoundingCpo soundingCpo5 = SoundingCpo();
            soundingCpo5.number = soundingId + "5";
            soundingCpo5.trTime = dateTime;
            soundingCpo5.density = density5;
            soundingCpo5.sounding1 = double.parse(sounding1tank5.text);
            soundingCpo5.sounding2 = double.parse(sounding2tank5.text);
            soundingCpo5.sounding3 = double.parse(sounding3tank5.text);
            soundingCpo5.sounding4 = double.parse("0.0");
            soundingCpo5.sounding5 = double.parse("0.0");
            soundingCpo5.temperature = double.parse(temperatureTank5.text);
            soundingCpo5.avgSounding = double.parse(averageTank5.text);
            soundingCpo5.mStorageTankCode = storageTankCode5;
            soundingCpo5.mStorageTankId = storageTankID5;
            soundingCpo5.soundingId = soundingId;
            soundingCpo5.size = size5;
            soundingCpo5.maxSounding = maxSounding;
            soundingCpo5.isManual = isChecked5;
            soundingCpo5.createdBy = username;
            soundingCpo5.usingCopyData = usingDataYesterday;
            if (isChecked5) {
              soundingCpo5.roundingTonnage =
                  double.parse(roundingTonaseTank5.text);
            } else {
              soundingCpo5.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo5);
            if (exist > 0) {
              int soundingCountCpo5 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo5);
              print("edited sounding cpo 5 $soundingCountCpo5");
            } else {
              int soundingCountCpo5 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo5);
              print("insert sounding cpo 5 $soundingCountCpo5");
            }
          }
          context.read<ListSoundingNotifier>().updateListView();
          Navigator.pop(context, sounding);
        }
      } else {
        if (averageTank1.text.isNotEmpty && temperatureTank1.text.isNotEmpty) {
          SoundingCpo soundingCpo1 = SoundingCpo();
          soundingCpo1.number = soundingId + "1";
          soundingCpo1.trTime = dateTime;
          soundingCpo1.density = density1;
          soundingCpo1.sounding1 = double.parse(sounding1tank1.text);
          soundingCpo1.sounding2 = double.parse(sounding2tank1.text);
          soundingCpo1.sounding3 = double.parse(sounding3tank1.text);
          soundingCpo1.temperature = double.parse(temperatureTank1.text);
          soundingCpo1.avgSounding = double.parse(averageTank1.text);
          soundingCpo1.mStorageTankCode = storageTankCode1;
          soundingCpo1.mStorageTankId = storageTankID1;
          soundingCpo1.size = size1;
          soundingCpo1.sounding4 = double.parse("0.0");
          soundingCpo1.sounding5 = double.parse("0.0");
          soundingCpo1.maxSounding = maxSounding;
          soundingCpo1.soundingId = soundingId;
          soundingCpo1.isManual = isChecked1;
          soundingCpo1.createdBy = username;
          soundingCpo1.usingCopyData = usingDataYesterday;
          if (isChecked1) {
            soundingCpo1.roundingTonnage =
                double.parse(roundingTonaseTank1.text);
          } else {
            soundingCpo1.roundingTonnage = 0;
          }
          int soundingCountCpo1 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo1);
          print("masuk sounding cpo 1 $soundingCountCpo1");
        }
        if (averageTank2.text.isNotEmpty && temperatureTank2.text.isNotEmpty) {
          SoundingCpo soundingCpo2 = SoundingCpo();
          soundingCpo2.number = soundingId + "2";
          soundingCpo2.trTime = dateTime;
          soundingCpo2.density = density2;
          soundingCpo2.sounding1 = double.parse(sounding1tank2.text);
          soundingCpo2.sounding2 = double.parse(sounding2tank2.text);
          soundingCpo2.sounding3 = double.parse(sounding3tank2.text);
          soundingCpo2.sounding4 = double.parse("0.0");
          soundingCpo2.sounding5 = double.parse("0.0");
          soundingCpo2.temperature = double.parse(temperatureTank2.text);
          soundingCpo2.avgSounding = double.parse(averageTank2.text);
          soundingCpo2.mStorageTankCode = storageTankCode2;
          soundingCpo2.mStorageTankId = storageTankID2;
          soundingCpo2.size = size2;
          soundingCpo2.maxSounding = maxSounding;
          soundingCpo2.soundingId = soundingId;
          soundingCpo2.isManual = isChecked2;
          soundingCpo2.createdBy = username;
          soundingCpo2.usingCopyData = usingDataYesterday;
          if (isChecked2) {
            soundingCpo2.roundingTonnage =
                double.parse(roundingTonaseTank2.text);
          } else {
            soundingCpo2.roundingTonnage = 0;
          }
          int soundingCountCpo2 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo2);
          print("masuk sounding cpo 2 $soundingCountCpo2");
        }
        if (averageTank3.text.isNotEmpty && temperatureTank3.text.isNotEmpty) {
          SoundingCpo soundingCpo3 = SoundingCpo();
          soundingCpo3.number = soundingId + "3";
          soundingCpo3.trTime = dateTime;
          soundingCpo3.density = density3;
          soundingCpo3.sounding1 = double.parse(sounding1tank3.text);
          soundingCpo3.sounding2 = double.parse(sounding2tank3.text);
          soundingCpo3.sounding3 = double.parse(sounding3tank3.text);
          soundingCpo3.sounding4 = double.parse("0.0");
          soundingCpo3.sounding5 = double.parse("0.0");
          soundingCpo3.temperature = double.parse(temperatureTank3.text);
          soundingCpo3.avgSounding = double.parse(averageTank3.text);
          soundingCpo3.mStorageTankCode = storageTankCode3;
          soundingCpo3.mStorageTankId = storageTankID3;
          soundingCpo3.size = size3;
          soundingCpo3.maxSounding = maxSounding;
          soundingCpo3.soundingId = soundingId;
          soundingCpo3.isManual = isChecked3;
          soundingCpo3.createdBy = username;
          soundingCpo3.usingCopyData = usingDataYesterday;
          if (isChecked3) {
            soundingCpo3.roundingTonnage =
                double.parse(roundingTonaseTank3.text);
          } else {
            soundingCpo3.roundingTonnage = 0;
          }
          int soundingCountCpo3 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo3);
          print("masuk sounding cpo 3 $soundingCountCpo3");
        }
        if (averageTank4.text.isNotEmpty && temperatureTank4.text.isNotEmpty) {
          SoundingCpo soundingCpo4 = SoundingCpo();
          soundingCpo4.number = soundingId + "4";
          soundingCpo4.trTime = dateTime;
          soundingCpo4.density = density4;
          soundingCpo4.sounding1 = double.parse(sounding1tank4.text);
          soundingCpo4.sounding2 = double.parse(sounding2tank4.text);
          soundingCpo4.sounding3 = double.parse(sounding3tank4.text);
          soundingCpo4.sounding4 = double.parse("0.0");
          soundingCpo4.sounding5 = double.parse("0.0");
          soundingCpo4.temperature = double.parse(temperatureTank4.text);
          soundingCpo4.avgSounding = double.parse(averageTank4.text);
          soundingCpo4.mStorageTankCode = storageTankCode4;
          soundingCpo4.mStorageTankId = storageTankID4;
          soundingCpo4.size = size4;
          soundingCpo4.maxSounding = maxSounding;
          soundingCpo4.soundingId = soundingId;
          soundingCpo4.isManual = isChecked4;
          soundingCpo4.createdBy = username;
          soundingCpo4.usingCopyData = usingDataYesterday;
          if (isChecked4) {
            soundingCpo4.roundingTonnage =
                double.parse(roundingTonaseTank4.text);
          } else {
            soundingCpo4.roundingTonnage = 0;
          }
          int soundingCountCpo4 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo4);
          print("masuk sounding cpo 4 $soundingCountCpo4");
        }
        if (averageTank5.text.isNotEmpty && temperatureTank5.text.isNotEmpty) {
          SoundingCpo soundingCpo5 = SoundingCpo();
          soundingCpo5.number = soundingId + "5";
          soundingCpo5.trTime = dateTime;
          soundingCpo5.density = density5;
          soundingCpo5.sounding1 = double.parse(sounding1tank5.text);
          soundingCpo5.sounding2 = double.parse(sounding2tank5.text);
          soundingCpo5.sounding3 = double.parse(sounding3tank5.text);
          soundingCpo5.sounding4 = double.parse("0.0");
          soundingCpo5.sounding5 = double.parse("0.0");
          soundingCpo5.temperature = double.parse(temperatureTank5.text);
          soundingCpo5.avgSounding = double.parse(averageTank5.text);
          soundingCpo5.mStorageTankCode = storageTankCode5;
          soundingCpo5.mStorageTankId = storageTankID5;
          soundingCpo5.soundingId = soundingId;
          soundingCpo5.size = size5;
          soundingCpo5.maxSounding = maxSounding;
          soundingCpo5.isManual = isChecked5;
          soundingCpo5.createdBy = username;
          soundingCpo5.usingCopyData = usingDataYesterday;
          if (isChecked5) {
            soundingCpo5.roundingTonnage =
                double.parse(roundingTonaseTank5.text);
          } else {
            soundingCpo5.roundingTonnage = 0;
          }
          int soundingCountCpo5 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo5);
          print("masuk sounding cpo 4 $soundingCountCpo5");
        }
        List<SoundingCpo> count =
            await DatabaseSoundingCpo().selectSoundingCpo(sounding);
        if (count.length > 0) {
          await DatabaseSounding().insertSounding(sounding);
        }
        context.read<ListSoundingNotifier>().updateListView();
        context.read<HomeNotifier>().doGetSoundingUnsent();
        Navigator.pop(context);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Tolong Cek Data Sounding",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

  doSaveToDatabasePMP() async {
    if (averageTank1.text.isNotEmpty && temperatureTank1.text.isNotEmpty ||
        averageTank2.text.isNotEmpty && temperatureTank2.text.isNotEmpty ||
        averageTank3.text.isNotEmpty && temperatureTank3.text.isNotEmpty ||
        averageTank4.text.isNotEmpty && temperatureTank4.text.isNotEmpty) {
      String username = await StorageUtils.readData('username');
      int maxSounding = await StorageUtils.readData('max_sounding');
      Sounding sounding = Sounding();
      sounding.number = soundingId;
      sounding.trTime = dateTime;
      sounding.production = productionController.text;
      sounding.note = noteController.text.toString();
      sounding.createdBy = username;
      sounding.sent = "false";
      sounding.additional = 0;
      sounding.totalStock = 0;
      if (clarifierPureOil.text.isNotEmpty) {
        sounding.clarifierPureOil =
            double.parse(clarifierPureOil.text.toString());
      }
      if (clarifier1.text.isNotEmpty) {
        sounding.clarifier1 = double.parse(clarifier1.text.toString());
      }
      if (clarifier2.text.isNotEmpty) {
        sounding.clarifier2 = double.parse(clarifier2.text.toString());
      }
      if (widget.sounding != null) {
        int soundingCount = await DatabaseSounding().updateSounding(sounding);
        if (soundingCount > 0) {
          if (averageTank1.text.isNotEmpty &&
              temperatureTank1.text.isNotEmpty) {
            SoundingCpo soundingCpo1 = SoundingCpo();
            soundingCpo1.number = soundingId + "1";
            soundingCpo1.trTime = dateTime;
            soundingCpo1.density = density1;
            soundingCpo1.sounding1 = double.parse(sounding1tank1.text);
            soundingCpo1.sounding2 = double.parse(sounding2tank1.text);
            soundingCpo1.sounding3 = double.parse(sounding3tank1.text);
            soundingCpo1.temperature = double.parse(temperatureTank1.text);
            soundingCpo1.avgSounding = double.parse(averageTank1.text);
            soundingCpo1.mStorageTankCode = storageTankCode1;
            soundingCpo1.mStorageTankId = storageTankID1;
            soundingCpo1.size = size1;
            soundingCpo1.sounding4 = double.parse("0.0");
            soundingCpo1.maxSounding = maxSounding;
            soundingCpo1.soundingId = soundingId;
            soundingCpo1.isManual = isChecked1;
            soundingCpo1.createdBy = username;
            soundingCpo1.usingCopyData = usingDataYesterday;
            if (isChecked1) {
              soundingCpo1.roundingTonnage =
                  double.parse(roundingTonaseTank1.text);
            } else {
              soundingCpo1.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo1);
            if (exist > 0) {
              int soundingCountCpo1 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo1);
              print("edited sounding cpo 1 $soundingCountCpo1");
            } else {
              int soundingCountCpo1 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo1);
              print("insert sounding cpo 1 $soundingCountCpo1");
            }
          }
          if (averageTank2.text.isNotEmpty &&
              temperatureTank2.text.isNotEmpty) {
            SoundingCpo soundingCpo2 = SoundingCpo();
            soundingCpo2.number = soundingId + "2";
            soundingCpo2.trTime = dateTime;
            soundingCpo2.density = density2;
            soundingCpo2.sounding1 = double.parse(sounding1tank2.text);
            soundingCpo2.sounding2 = double.parse(sounding2tank2.text);
            soundingCpo2.sounding3 = double.parse(sounding3tank2.text);
            soundingCpo2.sounding4 = double.parse("0.0");
            soundingCpo2.temperature = double.parse(temperatureTank2.text);
            soundingCpo2.avgSounding = double.parse(averageTank2.text);
            soundingCpo2.mStorageTankCode = storageTankCode2;
            soundingCpo2.mStorageTankId = storageTankID2;
            soundingCpo2.size = size2;
            soundingCpo2.maxSounding = maxSounding;
            soundingCpo2.soundingId = soundingId;
            soundingCpo2.isManual = isChecked2;
            soundingCpo2.createdBy = username;
            soundingCpo2.usingCopyData = usingDataYesterday;
            if (isChecked2) {
              soundingCpo2.roundingTonnage =
                  double.parse(roundingTonaseTank2.text);
            } else {
              soundingCpo2.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo2);
            if (exist > 0) {
              int soundingCountCpo2 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo2);
              print("edited sounding cpo 2 $soundingCountCpo2");
            } else {
              int soundingCountCpo2 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo2);
              print("insert sounding cpo 2 $soundingCountCpo2");
            }
          }
          if (averageTank3.text.isNotEmpty &&
              temperatureTank3.text.isNotEmpty) {
            SoundingCpo soundingCpo3 = SoundingCpo();
            soundingCpo3.number = soundingId + "3";
            soundingCpo3.trTime = dateTime;
            soundingCpo3.density = density3;
            soundingCpo3.sounding1 = double.parse(sounding1tank3.text);
            soundingCpo3.sounding2 = double.parse(sounding2tank3.text);
            soundingCpo3.sounding3 = double.parse(sounding3tank3.text);
            soundingCpo3.sounding4 = double.parse("0.0");
            soundingCpo3.temperature = double.parse(temperatureTank3.text);
            soundingCpo3.avgSounding = double.parse(averageTank3.text);
            soundingCpo3.mStorageTankCode = storageTankCode3;
            soundingCpo3.mStorageTankId = storageTankID3;
            soundingCpo3.size = size3;
            soundingCpo3.maxSounding = maxSounding;
            soundingCpo3.soundingId = soundingId;
            soundingCpo3.isManual = isChecked3;
            soundingCpo3.createdBy = username;
            soundingCpo3.usingCopyData = usingDataYesterday;
            if (isChecked3) {
              soundingCpo3.roundingTonnage =
                  double.parse(roundingTonaseTank3.text);
            } else {
              soundingCpo3.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo3);
            if (exist > 0) {
              int soundingCountCpo3 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo3);
              print("edited sounding cpo 3 $soundingCountCpo3");
            } else {
              int soundingCountCpo3 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo3);
              print("insert sounding cpo 3 $soundingCountCpo3");
            }
          }
          if (averageTank4.text.isNotEmpty &&
              temperatureTank4.text.isNotEmpty) {
            SoundingCpo soundingCpo4 = SoundingCpo();
            soundingCpo4.number = soundingId + "4";
            soundingCpo4.trTime = dateTime;
            soundingCpo4.density = density4;
            soundingCpo4.sounding1 = double.parse(sounding1tank4.text);
            soundingCpo4.sounding2 = double.parse(sounding2tank4.text);
            soundingCpo4.sounding3 = double.parse(sounding3tank4.text);
            soundingCpo4.sounding4 = double.parse("0.0");
            soundingCpo4.temperature = double.parse(temperatureTank4.text);
            soundingCpo4.avgSounding = double.parse(averageTank4.text);
            soundingCpo4.mStorageTankCode = storageTankCode4;
            soundingCpo4.mStorageTankId = storageTankID4;
            soundingCpo4.size = size4;
            soundingCpo4.maxSounding = maxSounding;
            soundingCpo4.soundingId = soundingId;
            soundingCpo4.isManual = isChecked4;
            soundingCpo4.createdBy = username;
            soundingCpo4.usingCopyData = usingDataYesterday;
            if (isChecked4) {
              soundingCpo4.roundingTonnage =
                  double.parse(roundingTonaseTank4.text);
            } else {
              soundingCpo4.roundingTonnage = 0;
            }
            int exist = await DatabaseSoundingCpo()
                .selectSoundingCpoByIDCpo(soundingCpo4);
            if (exist > 0) {
              int soundingCountCpo4 =
                  await DatabaseSoundingCpo().updateSoundingCpo(soundingCpo4);
              print("edited sounding cpo 4 $soundingCountCpo4");
            } else {
              int soundingCountCpo4 =
                  await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo4);
              print("insert sounding cpo 4 $soundingCountCpo4");
            }
          }
          context.read<ListSoundingNotifier>().updateListView();
          Navigator.pop(context, sounding);
        }
      } else {
        if (averageTank1.text.isNotEmpty && temperatureTank1.text.isNotEmpty) {
          SoundingCpo soundingCpo1 = SoundingCpo();
          soundingCpo1.number = soundingId + "1";
          soundingCpo1.trTime = dateTime;
          soundingCpo1.density = density1;
          soundingCpo1.sounding1 = double.parse(sounding1tank1.text);
          soundingCpo1.sounding2 = double.parse(sounding2tank1.text);
          soundingCpo1.sounding3 = double.parse(sounding3tank1.text);
          soundingCpo1.temperature = double.parse(temperatureTank1.text);
          soundingCpo1.avgSounding = double.parse(averageTank1.text);
          soundingCpo1.mStorageTankCode = storageTankCode1;
          soundingCpo1.mStorageTankId = storageTankID1;
          soundingCpo1.size = size1;
          soundingCpo1.sounding4 = double.parse("0.0");
          soundingCpo1.maxSounding = maxSounding;
          soundingCpo1.soundingId = soundingId;
          soundingCpo1.isManual = isChecked1;
          soundingCpo1.createdBy = username;
          soundingCpo1.usingCopyData = usingDataYesterday;
          if (isChecked1) {
            soundingCpo1.roundingTonnage =
                double.parse(roundingTonaseTank1.text);
          } else {
            soundingCpo1.roundingTonnage = 0;
          }
          int soundingCountCpo1 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo1);
          print("masuk sounding cpo 1 $soundingCountCpo1");
        }
        if (averageTank2.text.isNotEmpty && temperatureTank2.text.isNotEmpty) {
          SoundingCpo soundingCpo2 = SoundingCpo();
          soundingCpo2.number = soundingId + "2";
          soundingCpo2.trTime = dateTime;
          soundingCpo2.density = density2;
          soundingCpo2.sounding1 = double.parse(sounding1tank2.text);
          soundingCpo2.sounding2 = double.parse(sounding2tank2.text);
          soundingCpo2.sounding3 = double.parse(sounding3tank2.text);
          soundingCpo2.sounding4 = double.parse("0.0");
          soundingCpo2.temperature = double.parse(temperatureTank2.text);
          soundingCpo2.avgSounding = double.parse(averageTank2.text);
          soundingCpo2.mStorageTankCode = storageTankCode2;
          soundingCpo2.mStorageTankId = storageTankID2;
          soundingCpo2.size = size2;
          soundingCpo2.maxSounding = maxSounding;
          soundingCpo2.soundingId = soundingId;
          soundingCpo2.isManual = isChecked2;
          soundingCpo2.createdBy = username;
          soundingCpo2.usingCopyData = usingDataYesterday;
          if (isChecked2) {
            soundingCpo2.roundingTonnage =
                double.parse(roundingTonaseTank2.text);
          } else {
            soundingCpo2.roundingTonnage = 0;
          }
          int soundingCountCpo2 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo2);
          print("masuk sounding cpo 2 $soundingCountCpo2");
        }
        if (averageTank3.text.isNotEmpty && temperatureTank3.text.isNotEmpty) {
          SoundingCpo soundingCpo3 = SoundingCpo();
          soundingCpo3.number = soundingId + "3";
          soundingCpo3.trTime = dateTime;
          soundingCpo3.density = density3;
          soundingCpo3.sounding1 = double.parse(sounding1tank3.text);
          soundingCpo3.sounding2 = double.parse(sounding2tank3.text);
          soundingCpo3.sounding3 = double.parse(sounding3tank3.text);
          soundingCpo3.sounding4 = double.parse("0.0");
          soundingCpo3.temperature = double.parse(temperatureTank3.text);
          soundingCpo3.avgSounding = double.parse(averageTank3.text);
          soundingCpo3.mStorageTankCode = storageTankCode3;
          soundingCpo3.mStorageTankId = storageTankID3;
          soundingCpo3.size = size3;
          soundingCpo3.maxSounding = maxSounding;
          soundingCpo3.soundingId = soundingId;
          soundingCpo3.isManual = isChecked3;
          soundingCpo3.createdBy = username;
          soundingCpo3.usingCopyData = usingDataYesterday;
          if (isChecked3) {
            soundingCpo3.roundingTonnage =
                double.parse(roundingTonaseTank3.text);
          } else {
            soundingCpo3.roundingTonnage = 0;
          }
          int soundingCountCpo3 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo3);
          print("masuk sounding cpo 3 $soundingCountCpo3");
        }
        if (averageTank4.text.isNotEmpty && temperatureTank4.text.isNotEmpty) {
          SoundingCpo soundingCpo4 = SoundingCpo();
          soundingCpo4.number = soundingId + "4";
          soundingCpo4.trTime = dateTime;
          soundingCpo4.density = density4;
          soundingCpo4.sounding1 = double.parse(sounding1tank4.text);
          soundingCpo4.sounding2 = double.parse(sounding2tank4.text);
          soundingCpo4.sounding3 = double.parse(sounding3tank4.text);
          soundingCpo4.sounding4 = double.parse("0.0");
          soundingCpo4.temperature = double.parse(temperatureTank4.text);
          soundingCpo4.avgSounding = double.parse(averageTank4.text);
          soundingCpo4.mStorageTankCode = storageTankCode4;
          soundingCpo4.mStorageTankId = storageTankID4;
          soundingCpo4.size = size4;
          soundingCpo4.maxSounding = maxSounding;
          soundingCpo4.soundingId = soundingId;
          soundingCpo4.isManual = isChecked4;
          soundingCpo4.createdBy = username;
          soundingCpo4.usingCopyData = usingDataYesterday;
          if (isChecked4) {
            soundingCpo4.roundingTonnage =
                double.parse(roundingTonaseTank4.text);
          } else {
            soundingCpo4.roundingTonnage = 0;
          }
          int soundingCountCpo4 =
              await DatabaseSoundingCpo().insertSoundingCpo(soundingCpo4);
          print("masuk sounding cpo 4 $soundingCountCpo4");
        }
        List<SoundingCpo> count =
            await DatabaseSoundingCpo().selectSoundingCpo(sounding);
        if (count.length > 0) {
          await DatabaseSounding().insertSounding(sounding);
        }
        context.read<ListSoundingNotifier>().updateListView();
        context.read<HomeNotifier>().doGetSoundingUnsent();
        Navigator.pop(context);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Tolong Cek Data Sounding",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

  showDataYesterdayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tidak Mengolah"),
          content: Text(
              "jika tidak mengolah, anda menggunakan data kemarin maka dinyatakan tidak dilakukan sounding"),
          actions: [
            TextButton(
              child: Text(Strings.YES,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                getListSoundingCpoYesterday();
              },
            ),
            TextButton(
              child: Text(Strings.NO,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
              onPressed: () {
                setState(() {
                  usingDataYesterday = false;
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  showSaveDialog(BuildContext context) {
    List<StorageTank> list = context.read<FormSoundingNotifier>().storageTank;
    print(list);
    String message = "";
    if (companyAlias == 'PMP') {
      if (list.length == 1) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        }
      } else if (list.length == 2) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        } else if (averageTank2.text.isEmpty && temperatureTank2.text.isEmpty) {
          message = "Data Tank 2 belum lengkap,";
        }
      } else if (list.length == 3) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        } else if (averageTank2.text.isEmpty && temperatureTank2.text.isEmpty) {
          message = "Data Tank 2 belum lengkap,";
        } else if (averageTank3.text.isEmpty && temperatureTank3.text.isEmpty) {
          message = "Data Tank 3 belum lengkap,";
        }
      } else if (list.length == 4) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        } else if (averageTank2.text.isEmpty && temperatureTank2.text.isEmpty) {
          message = "Data Tank 2 belum lengkap,";
        } else if (averageTank3.text.isEmpty && temperatureTank3.text.isEmpty) {
          message = "Data Tank 3 belum lengkap,";
        } else if (averageTank4.text.isEmpty && temperatureTank4.text.isEmpty) {
          message = "Data Tank 4 belum lengkap,";
        }
      }
    } else {
      if (list.length == 1) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        }
      } else if (list.length == 2) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        } else if (averageTank2.text.isEmpty && temperatureTank2.text.isEmpty) {
          message = "Data Tank 2 belum lengkap,";
        }
      } else if (list.length == 3) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        } else if (averageTank2.text.isEmpty && temperatureTank2.text.isEmpty) {
          message = "Data Tank 2 belum lengkap,";
        } else if (averageTank3.text.isEmpty && temperatureTank3.text.isEmpty) {
          message = "Data Tank 3 belum lengkap,";
        }
      } else if (list.length == 4) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        } else if (averageTank2.text.isEmpty && temperatureTank2.text.isEmpty) {
          message = "Data Tank 2 belum lengkap,";
        } else if (averageTank3.text.isEmpty && temperatureTank3.text.isEmpty) {
          message = "Data Tank 3 belum lengkap,";
        } else if (averageTank4.text.isEmpty && temperatureTank4.text.isEmpty) {
          message = "Data Tank 4 belum lengkap,";
        }
      } else if (list.length == 5) {
        if (averageTank1.text.isEmpty && temperatureTank1.text.isEmpty) {
          message = "Data Tank 1 belum lengkap,";
        } else if (averageTank2.text.isEmpty && temperatureTank2.text.isEmpty) {
          message = "Data Tank 2 belum lengkap,";
        } else if (averageTank3.text.isEmpty && temperatureTank3.text.isEmpty) {
          message = "Data Tank 3 belum lengkap,";
        } else if (averageTank4.text.isEmpty && temperatureTank4.text.isEmpty) {
          message = "Data Tank 4 belum lengkap,";
        } else if (averageTank5.text.isEmpty && temperatureTank5.text.isEmpty) {
          message = "Data Tank 5 belum lengkap,";
        }
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Simpan Data"),
          content: Text("$message Apakah yakin akan simpan?"),
          actions: [
            TextButton(
              child: Text(Strings.YES,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                doSaveToDatabase();
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

  showClearDataYesterdayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hapus Data Kemarin"),
          content: Text("Anda akan menghapus data kemarin dari form"),
          actions: [
            TextButton(
              child: Text(Strings.YES,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                clearListSoundingCpoYesterday();
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
}
