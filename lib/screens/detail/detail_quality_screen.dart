import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/utils/storage_utils.dart';
import 'package:sounding_storage/database/database_quality_check.dart';
import 'package:sounding_storage/database/database_quality_doc.dart';
import 'package:sounding_storage/database/database_verifier.dart';
import 'package:sounding_storage/model/check_verifier_response.dart';
import 'package:sounding_storage/model/data_verifier.dart';
import 'package:sounding_storage/model/log_out_response.dart';
import 'package:sounding_storage/model/quality.dart';
import 'package:sounding_storage/model/quality_check.dart';
import 'package:sounding_storage/model/verifier.dart';
import 'package:sounding_storage/model/verifiers_response.dart';
import 'package:sounding_storage/repositories/check_verifier_repository.dart';
import 'package:sounding_storage/repositories/list_verificator_repository.dart';
import 'package:sounding_storage/repositories/send_quality_repository.dart';
import 'package:sounding_storage/screens/form/form_quality_screen.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_quality_notifier.dart';
import 'package:sounding_storage/widget/dialog/loading_dialog.dart';
import 'package:sounding_storage/widget/dialog/warning_dialog.dart';

class DetailQualityScreen extends StatefulWidget {
  final Quality quality;

  DetailQualityScreen(this.quality);

  @override
  _DetailQualityScreenState createState() => _DetailQualityScreenState();
}

class _DetailQualityScreenState extends State<DetailQualityScreen> {
  QualityCheck qualityDetailCPO, qualityDetailKernel;
  TextEditingController ffaCPO = TextEditingController();
  TextEditingController moistCPO = TextEditingController();
  TextEditingController dirtCPO = TextEditingController();
  TextEditingController dobiCPO = TextEditingController();
  TextEditingController ffaKernel = TextEditingController();
  TextEditingController moistKernel = TextEditingController();
  TextEditingController dirtKernel = TextEditingController();
  TextEditingController dobiKernel = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String idQuality, dateQuality, companyName = "";
  String mProductIDCPO, mProductCodeCPO;
  String mProductIDKernel, mProductCodeKernel;
  bool _validate = false;
  List<QualityCheck> qualityCheckDetail;
  Quality qualityDetail;
  String dropDownValueVerifierHint;
  String verifierID;
  List<DataVerifier> listVerifier = [];

  @override
  void initState() {
    setCompanyTitle();
    getVerifier();
    qualityDetail = widget.quality;
    dateQuality = qualityDetail.trTime;
    idQuality = qualityDetail.number;
    getQualityCheck(widget.quality);
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
        await DatabaseVerifier().selectVerifier(widget.quality.number);
    setState(() {
      this.listVerifier = listVerifier;
    });
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
        title: Center(child: Text("Detail Kualitas")),
        actions: [
          widget.quality.sent == "true"
              ? Container()
              : InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                        onTap: () async {
                          Quality qualityTemp = await Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return FormQualityScreen(widget.quality);
                          }));
                          if (qualityTemp != null) {
                            getQualityCheck(qualityTemp);
                            qualityDetail = qualityTemp;
                          }
                        },
                        child: Icon(Typicons.edit)),
                  ),
                )
        ],
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    companyName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("LAPORAN KUALITAS PRODUKSI TBS"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanggal             ", style: text14Bold),
                      Text(qualityDetail.trTime)
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  qualityDetailCPO != null
                      ? Container(
                          child: Column(
                            children: [
                              Text(
                                "Kualitas Produksi",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Divider(),
                              Text(
                                "CPO",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("FFA", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: ffaCPO,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("MOIST ( % )", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: moistCPO,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("DIRT ( % )", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: dirtCPO,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("DOBI", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: dobiCPO,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                            ],
                          ),
                        )
                      : Container(),
                  qualityDetailKernel != null
                      ? Container(
                          child: Column(
                            children: [
                              Text(
                                "Kernel",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.orange),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("FFA", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: ffaKernel,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("MOIST ( % )", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: moistKernel,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("DIRT ( % )", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: dirtKernel,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("B. KERNEL ( % )", style: text14Bold),
                                  Flexible(
                                    child: Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: TextField(
                                          enabled: false,
                                          controller: dobiKernel,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              errorText: _validate
                                                  ? 'Belum Terisi'
                                                  : null,
                                              counterText: ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
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
                  widget.quality.sent == "true"
                      ? Container()
                      : OutlinedButton(
                          onPressed: () {
                            showSoundingSendDialog(
                                context, widget.quality, qualityCheckDetail);
                          },
                          child: Container(
                            padding: EdgeInsets.all(14),
                            width: MediaQuery.of(context).size.width,
                            child: Text("Kirim",
                                textAlign: TextAlign.center, style: text16Bold),
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

  showSoundingSendDialog(BuildContext context, Quality quality,
      List<QualityCheck> listQualityCheck) {
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
                doSendQuality(quality, listQualityCheck);
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
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
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
    passwordController.clear();
    if (listVerifier.isNotEmpty) {
      DataVerifier verifierTemp = DataVerifier();
      verifierTemp.mUserId = response.data.mUserId;
      verifierTemp.name = response.data.name;
      verifierTemp.levelLabel = response.data.levelLabel;
      verifierTemp.idForm = widget.quality.number;
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
      verifierTemp.idForm = widget.quality.number;
      listVerifier.add(verifierTemp);
      DatabaseVerifier().insertVerifier(verifierTemp);
      setState(() {});
    }
  }

  onErrorCheckVerifier(BuildContext context, response) {
    warningDialog(context, "Koneksi Gagal", response.message);
  }

  doSendQuality(Quality quality, List<QualityCheck> qualityCheck) {
    if (listVerifier.length >= 2) {
      List<String> verifier = [];
      for (int i = 0; i < listVerifier.length; i++) {
        verifier.add(listVerifier[i].mUserId);
      }
      loadingDialog(context);
      SendQualityRepository(APIEndpoint.BASE_URL).doSendQualityRepository(
          quality, qualityCheck, verifier, onSuccess, onError);
    } else {
      doSetVerifier();
    }
  }

  onSuccess(LogOutResponse response) {
    Navigator.pop(context);
    DatabaseQuality().updateQualityTransferred(widget.quality);
    warningDialog(context, "Pengiriman Berhasil", response.message);
    context.read<ListQualityNotifier>().updateListView();
    context.read<HomeNotifier>().doGetQualityUnsent();
  }

  onError(response) {
    warningDialog(context, "Pengiriman Gagal", response.toString());
  }
}
