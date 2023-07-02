import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/model/sounding.dart';
import 'package:sounding_storage/screens/detail/detail_sounding_screen.dart';
import 'package:sounding_storage/screens/form/form_sounding_screen.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_sounding_notifier.dart';
import 'package:sounding_storage/widget/loading/loading_progress.dart';

class ListSoundingScreen extends StatefulWidget {
  @override
  ListSoundingScreenState createState() => ListSoundingScreenState();
}

class ListSoundingScreenState extends State<ListSoundingScreen> {
  TextEditingController typeSoundingController = TextEditingController();

  @override
  void initState() {
    context.read<ListSoundingNotifier>().updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListSoundingNotifier>(
      builder: (context, soundingNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sounding CPO"),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return FormSoundingScreen(null);
                  }));
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
                "Jumlah Laporan Sounding: ${soundingNotifier.soundingList.length}"),
            Divider(),
            soundingNotifier.isLoading
                ? Flexible(child: Center(child: LoadingProgress()))
                : soundingNotifier.soundingList.length != 0
                    ? Flexible(
                        child:
                            soundingNotifier.soundingListSearch.length != 0 ||
                                    typeSoundingController.text.isNotEmpty
                                ? createListViewSearch(
                                    soundingNotifier.soundingListSearch)
                                : createListView(soundingNotifier.soundingList))
                    : Flexible(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesome.doc_text_inv,
                                  size: 70, color: Colors.orange),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text("Belum ada Laporan Sounding",
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

  ListView createListView(List<Sounding> listSounding) {
    return ListView.builder(
      itemCount: listSounding.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FontAwesome.doc_text_inv,
                      size: 40, color: Colors.orange),
                  trailing: listSounding[index].sent == "false"
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDeleteDialog(context, listSounding[index]);
                              },
                              child: Column(children: [
                                Icon(Linecons.trash),
                              ]),
                            ),
                          ],
                        )
                      : Text("Terkirim"),
                  title: Text(listSounding[index].number, style: text16Bold),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tanggal: " + listSounding[index].trTime),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Produksi: " +
                              "${listSounding[index].production}"),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailSoundingScreen(listSounding[index])));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListView createListViewSearch(List<Sounding> soundingListSearch) {
    return ListView.builder(
      itemCount: soundingListSearch.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FontAwesome.doc_text_inv,
                      size: 40, color: Colors.orange),
                  trailing: soundingListSearch[index].sent == "false"
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDeleteDialog(
                                    context, soundingListSearch[index]);
                              },
                              child: Column(children: [
                                Icon(Linecons.trash),
                              ]),
                            ),
                          ],
                        )
                      : Text("Terkirim"),
                  title: Text(
                    soundingListSearch[index].number,
                    style: text16Bold,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tanggal: " + soundingListSearch[index].trTime),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Produksi: " +
                              "${soundingListSearch[index].production}"),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailSoundingScreen(
                                soundingListSearch[index])));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showDeleteDialog(BuildContext context, Sounding sounding) {
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
                    .read<ListSoundingNotifier>()
                    .deleteHarvestTicket(sounding);
                context.read<HomeNotifier>().doGetSoundingUnsent();
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
    context.read<ListSoundingNotifier>().onSearchTextChanged(text);
  }
}
