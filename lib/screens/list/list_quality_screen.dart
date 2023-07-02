import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/utils/navigator_utils.dart';
import 'package:sounding_storage/model/quality.dart';
import 'package:sounding_storage/screens/detail/detail_quality_screen.dart';
import 'package:sounding_storage/screens/form/form_quality_screen.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_quality_notifier.dart';
import 'package:sounding_storage/widget/loading/loading_progress.dart';

class ListQualityScreen extends StatefulWidget {
  @override
  ListQualityScreenState createState() => ListQualityScreenState();
}

class ListQualityScreenState extends State<ListQualityScreen> {
  TextEditingController typeSoundingController = TextEditingController();

  @override
  void initState() {
    context.read<ListQualityNotifier>().updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListQualityNotifier>(
      builder: (context, qualityNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Kualitas Storage"),
            actions: [
              InkWell(
                onTap: () {
                  NavigatorUtils.navigateTo(context, FormQualityScreen(null));
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(Typicons.doc_add)),
              ),
            ],
          ),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: typeSoundingController,
                      decoration: InputDecoration(
                          hintText: "Pencarian", border: InputBorder.none),
                      onChanged: (value) {
                        onSearchType(value);
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        typeSoundingController.clear();
                        onSearchType('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            Text(
                "Jumlah Laporan Kualitas: ${qualityNotifier.qualityList.length}"),
            Divider(),
            qualityNotifier.isLoading
                ? Flexible(child: Center(child: LoadingProgress()))
                : qualityNotifier.qualityList.length != 0
                    ? Flexible(
                        child: qualityNotifier.qualityListSearch.length != 0 ||
                                typeSoundingController.text.isNotEmpty
                            ? createListViewSearch(
                                qualityNotifier.qualityListSearch)
                            : createListView(qualityNotifier.qualityList))
                    : Flexible(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesome.doc_text_inv, size: 70, color: Colors.green),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text("Belum ada Laporan Kualitas",
                                    style: text14),
                              ),
                            ],
                          ),
                        ),
                      )
          ]),
        );
      },
    );
  }

  ListView createListView(List<Quality> listQuality) {
    return ListView.builder(
      itemCount: listQuality.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading:
                  Icon(FontAwesome.doc_text_inv, size: 40, color: Colors.green),
                  trailing: listQuality[index].sent == "false" ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDeleteDialog(context, listQuality[index]);
                        },
                        child: Column(children: [
                          Icon(Linecons.trash),
                        ]),
                      ),
                    ],
                  ) : Text("Terkirim"),
                  title: Text(listQuality[index].number, style: text16Bold),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tanggal: " + listQuality[index].trTime),
                      ],
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => DetailQualityScreen(listQuality[index])));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListView createListViewSearch(List<Quality> qualityListSearch) {
    return ListView.builder(
      itemCount: qualityListSearch.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading:
                  Icon(FontAwesome.doc_text_inv, size: 40, color: Colors.green),
                  trailing: qualityListSearch[index].sent == "false" ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDeleteDialog(context, qualityListSearch[index]);
                        },
                        child: Column(children: [
                          Icon(Linecons.trash),
                        ]),
                      ),
                    ],
                  ) : Text("Terkirim"),
                  title: Text(
                    qualityListSearch[index].number,
                    style: text16Bold,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tanggal: " + qualityListSearch[index].trTime),
                      ],
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => DetailQualityScreen(qualityListSearch[index])));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showDeleteDialog(BuildContext context, Quality quality) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Anda ingin menghapus data?", style: text16),
          actions: [
            TextButton(
              child: Text("Iya", style: TextStyle(color: Colors.red)),
              onPressed: () {
                context
                    .read<ListQualityNotifier>()
                    .deleteHarvestTicket(quality);
                context.read<HomeNotifier>().doGetQualityUnsent();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Tidak", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  onSearchType(String text) {
    context.read<ListQualityNotifier>().onSearchTextChanged(text);
  }
}
