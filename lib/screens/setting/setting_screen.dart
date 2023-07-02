import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/palette.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/base/interface/theme_notifier.dart';
import 'package:sounding_storage/base/utils/navigator_utils.dart';
import 'package:sounding_storage/screens/change_password/change_password_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text(Strings.SETTING)),
        ),
        body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Strings.DARK_MODE, style: text14Bold),
                      Flexible(
                        child: Switch(
                          activeColor: primaryColor,
                          value: theme.status ?? true,
                          onChanged: (value) {
                            if (value != null) {
                              value ? theme.setDarkMode() : theme.setLightMode();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  NavigatorUtils.navigateTo(context, ChangePasswordScreen());
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.CHANGE_PASSWORD, style: text14Bold),
                      ],
                    ),
                  ),
                ),
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
