import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/constants/paths.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/time_utils.dart';
import "package:sounding_storage/base/utils/capitalize.dart";
import 'package:sounding_storage/base/utils/navigator_utils.dart';
import 'package:sounding_storage/database/delete_data.dart';
import 'package:sounding_storage/screens/home/home_notifier.dart';
import 'package:sounding_storage/screens/list/list_quality_screen.dart';
import 'package:sounding_storage/screens/list/list_sounding_screen.dart';
import 'package:sounding_storage/screens/profile/profile_screen.dart';
import 'package:sounding_storage/screens/setting/setting_screen.dart';
import 'package:sounding_storage/widget/dialog/back_button_dialog.dart';
import 'package:sounding_storage/widget/dialog/log_out_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    deleteData();
    context.read<HomeNotifier>().doGetUser(context);
    context.read<HomeNotifier>().doGetSoundingUnsent();
    context.read<HomeNotifier>().doGetQualityUnsent();
    super.initState();
    cronStart();
  }

  cronStart() async {
    final cron = Cron()
      ..schedule(Schedule.parse('*/10 * * * *'), () {
        deleteData();
        print(DateTime.now());
      });
    await Future.delayed(Duration(hours: 8));
    await cron.close();
  }

  deleteData() {
    deleteDataQuality();
    deleteDataSounding();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(
      builder: (context, state, child) {
        return WillPopScope(
          onWillPop: () async {
            if (scaffoldKey.currentState.isDrawerOpen) {
              Navigator.of(context).pop();
              return false;
            } else {
              onWillPop(context);
            }
            return false;
          },
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Center(child: Text(Strings.APP_NAME)),
              automaticallyImplyLeading: false,
              leading: InkWell(
                child: Icon(Icons.menu),
                onTap: () {
                  if (scaffoldKey.currentState.isDrawerOpen) {
                    scaffoldKey.currentState.openEndDrawer();
                  } else {
                    scaffoldKey.currentState.openDrawer();
                  }
                },
              ),
            ),
            drawer: Consumer<HomeNotifier>(builder: (context, home, child) {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Icon(
                              Icons.account_box,
                              size: 60,
                              color: Colors.orange,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              home.user.name + "\n\n" + home.user.companyName,
                              style: text14Bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle_rounded, color: Colors.orange),
                      title: Text(Strings.PROFILE),
                      onTap: () {
                        NavigatorUtils.navigateTo(context, ProfileScreen());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings, color: Colors.orange),
                      title: Text(Strings.SETTING),
                      onTap: () {
                        NavigatorUtils.navigateTo(context, SettingScreen());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.orange),
                      title: Text(Strings.LOG_OUT),
                      onTap: () {
                        showLogOutDialog(context);
                      },
                    ),
                  ],
                ),
              );
            }),
            body: Center(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Image.asset(Paths.IMAGE_APP,
                                        height: 40),
                                  ),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${TimeUtils.getTimeGreetings()}${state.user.name?.capitalize()}",
                                        style: text16Bold,
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 4),
                                    Text(
                                        TimeUtils.dateFormatter(DateTime.now()),
                                        style: text14,
                                        overflow: TextOverflow.ellipsis),
                                  ]),
                            ]),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 8.0, right: 8.0),
                    child: Divider(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Laporan Belum Terkirim:", style: text16Bold),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(FontAwesome.doc_text_inv, size: 20),
                            Text(
                              "  Laporan Sounding ${state.soundingUnsent}",
                              style: TextStyle(
                                  color: state.soundingUnsent != 0
                                      ? Colors.red
                                      : Colors.blue),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(FontAwesome.doc_text_inv, size: 20),
                            Text(
                                "  Laporan Kulitas Produksi ${state.qualityUnsent}",
                                style: TextStyle(
                                    color: state.qualityUnsent != 0
                                        ? Colors.red
                                        : Colors.blue)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          NavigatorUtils.navigateTo(
                              context, ListSoundingScreen());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(FontAwesome.doc_text_inv,
                                    size: 50, color: Colors.orange),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(Strings.SOUNDING_CPO,
                                      style: text18Bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          NavigatorUtils.navigateTo(
                              context, ListQualityScreen());
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(FontAwesome.doc_text_inv,
                                    size: 50, color: Colors.green),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text("Kualitas Produksi",
                                      style: text18Bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              )),
            ),
          ),
        );
      },
    );
  }
}
