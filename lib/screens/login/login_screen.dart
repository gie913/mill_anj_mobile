import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:sounding_storage/base/constants/paths.dart';
import 'package:sounding_storage/base/constants/strings.dart';
import 'package:sounding_storage/base/interface/style.dart';
import 'package:sounding_storage/screens/login/login_notifier.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocus, passwordFocus;
  bool _obscureText = true;
  bool autoVal = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: EdgeInsets.all(28),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(Paths.IMAGE_APP,
                            width: MediaQuery.of(context).size.width * 0.2),
                        SizedBox(width: 10),
                        Text(
                          Strings.ANJ_LOGO,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.12),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Strings.LOGIN_SUBTITLE),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: usernameController,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        focusNode: usernameFocus,
                        onTap: () {
                          setState(() {
                            autoVal = true;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: Strings.USERNAME,
                          filled: true,
                        ),
                        validator: (value) {
                            return _validator(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: passwordController,
                        autocorrect: false,
                        obscureText: _obscureText,
                        textInputAction: TextInputAction.done,
                        focusNode: passwordFocus,
                        onTap: () {
                          setState(() {
                            autoVal = true;
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          suffixIcon: InkWell(
                              onTap: _toggle,
                              child: _obscureText
                                  ? Icon(Elusive.eye)
                                  : Icon(Elusive.eye_off)),
                          hintText: Strings.PASSWORD,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return Strings.PASSWORD_EMPTY_ALERT;
                          }
                          return null;
                        },
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _uiInputValidation();
                      },
                      child: Container(
                        padding: EdgeInsets.all(14),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          Strings.LOGIN,
                          style: text16Bold,
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
      ),
    );
  }

  String _validator(String value) {
    if (value.isEmpty) {
      return Strings.USERNAME_EMPTY_ALERT;
    }
    return null;
  }

  _uiInputValidation() async {
    if (_formKey.currentState.validate()) {
      LoginNotifier()
          .doLogin(context, usernameController.text, passwordController.text);
    } else {
      setState(() {
        autoVal = true;
      });
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
