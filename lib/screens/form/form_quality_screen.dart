import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/time_utils.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_entity.dart';
import 'package:sounding_storage/database/database_helper.dart';
import 'package:sounding_storage/database/database_quality_check.dart';
import 'package:sounding_storage/database/database_quality_doc.dart';
import 'package:sounding_storage/model/quality.dart';
import 'package:sounding_storage/model/quality_check.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_quality_notifier.dart';
import 'package:sqflite/sqflite.dart';

class FormQualityScreen extends StatefulWidget {
  final Quality quality;

  FormQualityScreen(this.quality);

  @override
  _FormQualityScreenState createState() => _FormQualityScreenState();
}

class _FormQualityScreenState extends State<FormQualityScreen> {
  TextEditingController ffaCPO = TextEditingController();
  TextEditingController moistCPO = TextEditingController();
  TextEditingController dirtCPO = TextEditingController();
  TextEditingController dobiCPO = TextEditingController();
  TextEditingController ffaKernel = TextEditingController();
  TextEditingController moistKernel = TextEditingController();
  TextEditingController dirtKernel = TextEditingController();
  TextEditingController dobiKernel = TextEditingController();
  String idQuality, dateQuality, companyName = "", companyAlias = "";
  String mProductIDCPO, mProductCodeCPO;
  String mProductIDKernel, mProductCodeKernel;
  bool _validate = false;
  List<QualityCheck> qualityCheckDetail;
  QualityCheck qualityDetailCPO, qualityDetailKernel;

  @override
  void initState() {
    setCompanyTitle();
    if (widget.quality != null) {
      thisEdit(widget.quality);
    } else {
      thisNew();
    }
    super.initState();
  }

  thisNew() {
    setState(() {
      dateQuality = TimeUtils.getTime(DateTime.now());
    });
  }

  setCompanyTitle() async {
    String companyNameTemp = await StorageUtils.readData('company_name');
    String companyAliasTemp = await StorageUtils.readData('company_alias');
    setState(() {
      companyName = companyNameTemp;
      companyAlias = companyAliasTemp;
      if (widget.quality == null) {
        idQuality = companyAlias.toLowerCase() +
            "q" +
            TimeUtils.getIDOnTime(DateTime.now());
      }
    });
  }

  thisEdit(Quality quality) {
    dateQuality = quality.trTime;
    idQuality = quality.number;
    getQualityCheck(quality);
  }

  getQualityCheck(Quality quality) async {
    List<QualityCheck> qualityCheck =
        await DatabaseQualityCheck().selectQualityCheck(quality);
    setState(() {
      qualityCheckDetail = qualityCheck;
    });
    for (int i = 0; i < qualityCheck.length; i++) {
      if (qualityCheck[i].mProductCode == 'CPO') {
        setState(() {
          qualityDetailCPO = qualityCheck[i];
          ffaCPO.text = qualityDetailCPO.ffa.toString();
          moistCPO.text = qualityDetailCPO.moist.toString();
          dirtCPO.text = qualityDetailCPO.dirt.toString();
          dobiCPO.text = qualityDetailCPO.dobi.toString();
        });
      } else {
        setState(() {
          qualityDetailKernel = qualityCheck[i];
          ffaKernel.text = qualityDetailKernel.ffa.toString();
          moistKernel.text = qualityDetailKernel.moist.toString();
          dirtKernel.text = qualityDetailKernel.dirt.toString();
          dobiKernel.text = qualityDetailKernel.brokenPk.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Form Kualitas")),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    companyName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("LAPORAN KUALITAS PRODUKSI"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanggal             ", style: text14Bold),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DateTimePicker(
                            type: DateTimePickerType.dateTimeSeparate,
                            dateMask: 'd MMM, yyyy',
                            initialValue: dateQuality,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Tanggal',
                            timeLabelText: "Waktu",
                            onChanged: (val) {
                              setState(() {
                                dateQuality = val +
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
                                dateQuality = val;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  Text(
                    "Kualitas Produksi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "CPO",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("FFA", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: ffaCPO,
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
                      Text("MOIST ( % )", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: moistCPO,
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
                      Text("DIRT ( % )", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: dirtCPO,
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
                      Text("DOBI", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: dobiCPO,
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
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Kernel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orange),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("FFA", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: ffaKernel,
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
                      Text("MOIST ( % )", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: moistKernel,
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
                      Text("DIRT ( % )", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: dirtKernel,
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
                      Text("B. KERNEL ( % )", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(',')),
                                LengthLimitingTextInputFormatter(7),
                              ],
                              controller: dobiKernel,
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

  saveToDatabase() async {
    if (ffaCPO.text.isNotEmpty &&
        ffaKernel.text.isNotEmpty &&
        moistCPO.text.isNotEmpty &&
        moistKernel.text.isNotEmpty &&
        dirtCPO.text.isNotEmpty &&
        dirtKernel.text.isNotEmpty &&
        dobiCPO.text.isNotEmpty &&
        dobiKernel.text.isNotEmpty) {
      checkMoreThan100();
    } else {
      checkEmpty();
    }
  }

  showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Simpan Data"),
          content: Text("Apakah yakin data sudah lengkap?"),
          actions: [
            TextButton(
              child: Text(Strings.YES,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                saveToDatabase();
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

  checkEmpty() {
    if (ffaCPO.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "FFA CPO belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (moistCPO.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Moist CPO belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (dirtCPO.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Dirt CPO belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (dobiCPO.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "DOBI CPO belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (ffaKernel.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "FFA Kernel belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (moistKernel.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Moist Kernel belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (dirtKernel.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Dirt Kernel belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (dobiKernel.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "B. Kernel belum terisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  checkMoreThan100() async {
    if (double.parse(ffaCPO.text) > 100) {
      Fluttertoast.showToast(
          msg: "FFA CPO tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (double.parse(moistCPO.text) > 100) {
      Fluttertoast.showToast(
          msg: "Moist CPO tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (double.parse(dirtCPO.text) > 100) {
      Fluttertoast.showToast(
          msg: "Dirt CPO tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (double.parse(dobiCPO.text) > 100) {
      Fluttertoast.showToast(
          msg: "DOBI CPO tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (double.parse(ffaKernel.text) > 100) {
      Fluttertoast.showToast(
          msg: "FFA Kernel tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (double.parse(moistKernel.text) > 100) {
      Fluttertoast.showToast(
          msg: "Moist Kernel tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (double.parse(dirtKernel.text) > 100) {
      Fluttertoast.showToast(
          msg: "Dirt Kernel tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (double.parse(dobiKernel.text) > 100) {
      Fluttertoast.showToast(
          msg: "B. Kernel tidak bisa lebih dari 100",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (widget.quality != null) {
        String productId = await StorageUtils.readData('productId');
        String username = await StorageUtils.readData('username');
        Quality quality = Quality();
        quality.number = idQuality;
        quality.sent = "false";
        quality.trTime = dateQuality;
        quality.createdBy = username;
        int qualityDocCount = await DatabaseQuality().updateQualityDoc(quality);
        if (qualityDocCount > 0) {
          QualityCheck qualityCheckCPO = QualityCheck();
          qualityCheckCPO.trTime = dateQuality;
          qualityCheckCPO.number = idQuality + "cpo";
          qualityCheckCPO.mProductCode = "CPO";
          qualityCheckCPO.mProductId = productId;
          qualityCheckCPO.idQualityDocCheck = idQuality;
          qualityCheckCPO.createdBy = username;
          qualityCheckCPO.ffa = double.parse(ffaCPO.text);
          qualityCheckCPO.moist = double.parse(moistCPO.text);
          qualityCheckCPO.dirt = double.parse(dirtCPO.text);
          qualityCheckCPO.dobi = double.parse(dobiCPO.text);
          int qualityCheckCpo =
              await DatabaseQualityCheck().updateQualityCheck(qualityCheckCPO);
          if (qualityCheckCpo > 0) {
            QualityCheck qualityCheckKernel = QualityCheck();
            qualityCheckKernel.trTime = dateQuality;
            qualityCheckKernel.idQualityDocCheck = idQuality;
            qualityCheckKernel.number = idQuality + "kernel";
            qualityCheckKernel.mProductId = productId;
            qualityCheckKernel.mProductCode = "Kernel";
            qualityCheckKernel.createdBy = username;
            qualityCheckKernel.ffa = double.parse(ffaKernel.text);
            qualityCheckKernel.moist = double.parse(moistKernel.text);
            qualityCheckKernel.dirt = double.parse(dirtKernel.text);
            qualityCheckKernel.brokenPk = double.parse(dobiKernel.text);
            int countKernel = await DatabaseQualityCheck()
                .updateQualityCheck(qualityCheckKernel);
            if (countKernel > 0) {
              context.read<ListQualityNotifier>().updateListView();
              context.read<HomeNotifier>().doGetSoundingUnsent();
              Navigator.pop(context, quality);
            }
          }
        }
      } else {
        Database db = await DatabaseHelper().database;
        String productId = await StorageUtils.readData('productId');
        String username = await StorageUtils.readData('username');
        Quality quality = Quality();
        quality.number = idQuality;
        quality.trTime = dateQuality;
        quality.sent = "false";
        quality.createdBy = username;
        int qualityDocCount =
            await db.insert(TABLE_QUALITY_DOC, quality.toJson());
        if (qualityDocCount > 0) {
          QualityCheck qualityCheckCPO = QualityCheck();
          qualityCheckCPO.trTime = dateQuality;
          qualityCheckCPO.number = idQuality + "cpo";
          qualityCheckCPO.mProductCode = "CPO";
          qualityCheckCPO.mProductId = productId;
          qualityCheckCPO.idQualityDocCheck = idQuality;
          qualityCheckCPO.createdBy = username;
          qualityCheckCPO.ffa = double.parse(ffaCPO.text);
          qualityCheckCPO.moist = double.parse(moistCPO.text);
          qualityCheckCPO.dirt = double.parse(dirtCPO.text);
          qualityCheckCPO.dobi = double.parse(dobiCPO.text);
          int qualityCheckCpo =
              await db.insert(TABLE_QUALITY, qualityCheckCPO.toJson());
          if (qualityCheckCpo > 0) {
            QualityCheck qualityCheckKernel = QualityCheck();
            qualityCheckKernel.trTime = dateQuality;
            qualityCheckKernel.idQualityDocCheck = idQuality;
            qualityCheckKernel.number = idQuality + "kernel";
            qualityCheckKernel.mProductId = productId;
            qualityCheckKernel.mProductCode = "Kernel";
            qualityCheckKernel.createdBy = username;
            qualityCheckKernel.ffa = double.parse(ffaKernel.text);
            qualityCheckKernel.moist = double.parse(moistKernel.text);
            qualityCheckKernel.dirt = double.parse(dirtKernel.text);
            qualityCheckKernel.brokenPk = double.parse(dobiKernel.text);
            int countKernel =
                await db.insert(TABLE_QUALITY, qualityCheckKernel.toJson());
            if (countKernel > 0) {
              context.read<ListQualityNotifier>().updateListView();
              context.read<HomeNotifier>().doGetQualityUnsent();
              Navigator.pop(context);
            }
          }
        }
      }
    }
  }
}
