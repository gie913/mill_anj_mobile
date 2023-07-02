import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:sounding_storage/base/interface/style.dart';

class FormKernelBulkSilo extends StatefulWidget {
  @override
  _FormKernelBulkSiloState createState() => _FormKernelBulkSiloState();
}

class _FormKernelBulkSiloState extends State<FormKernelBulkSilo> {
  TextEditingController productionController;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Kernel Bulk Silo")),
      ),
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                    "PT. SAHABAT MEWAH DAN MAKMUR",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("BERITA ACARA SOUNDING KERNEL BULK SILO"),
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
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Tanggal',
                            timeLabelText: "Waktu",
                            selectableDayPredicate: (date) {
                              // Disable weekend days to select from the calendar
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }
                              return true;
                            },
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Bulk Silo 1", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: productionController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "sounding(CM)",
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
                      Text("Bulk Silo 2", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: productionController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "sounding(CM)",
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
                      Text("Bulk Silo 3", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: productionController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "sounding(CM)",
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
                      Text("Bulk Silo 4", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: productionController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "sounding(CM)",
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
                      Text("Average", style: text14Bold),
                      Flexible(
                        child: Container(
                          width: 200,
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
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(14),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Simpan",
                        style: TextStyle(color: Colors.brown),
                        textAlign: TextAlign.center,
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
}
