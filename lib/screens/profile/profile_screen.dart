import 'package:flutter/material.dart';
import 'package:sounding_storage/base/api/api_endpoint.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/palette.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/database/database_user.dart';
import 'package:sounding_storage/model/user.dart';
import 'package:sounding_storage/screens/profile/profile_repository.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  User profile = User();
  bool loading = false;

  @override
  void initState() {
    doGetUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profil")),
      ),
      body: SingleChildScrollView(
        child: loading
            ? Center(
                child: SizedBox(
                  child: LinearProgressIndicator(value: null),
                ),
              )
            : profile != null
                ? Center(
                    child: Column(children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${profile.name.toUpperCase()}",
                                          style: text16Bold,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.email,
                                              size: 20,
                                              color: primaryColorLight),
                                          SizedBox(width: 8),
                                          Text("${profile.email ?? "-"}",
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.agriculture,
                                              size: 20,
                                              color: primaryColorLight),
                                          SizedBox(width: 8),
                                          Text("${profile.companyName}",
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone,
                                              size: 20,
                                              color: primaryColorLight),
                                          SizedBox(width: 8),
                                          Text("${profile.phoneNumber ?? "-"}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 6, right: 6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Versi App", style: text14Bold),
                                        Text(Strings.APP_VERSION),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  )
                : Container(
                    height: 100,
                    child: Center(
                        child: Text("Tidak Ada Koneksi", style: text16Bold)),
                  ),
      ),
    );
  }

  void doGetUserProfile() async {
    loading = true;
    ProfileRepository(APIEndpoint.BASE_URL)
        .doGetProfile(onSuccessProfileCallback, onErrorProfileCallback);
  }

  onSuccessProfileCallback(User profile) {
    setState(() {
      loading = false;
      this.profile = profile;
    });
  }

  onErrorProfileCallback(response) async {
    User user = await DatabaseUser().selectUser();
    setState(() {
      loading = false;
      this.profile = user;
    });
    Toast.show("Tidak Ada Koneksi Internet", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}
