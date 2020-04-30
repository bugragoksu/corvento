import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/user.dart';
import 'package:eventapp/src/util/toast_manager.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _formKey = GlobalKey<FormState>();
  UserViewModel _userViewModel;
  String _email, _password;
  bool _showPassword = false;
  bool isLoginForm = true;

  bool firstCheck = true;
  ToastManager _toast = ToastManager();
  final _resetPassFormKey = GlobalKey<FormState>();
  String resetPassEmail;

  void changePage() {
    setState(() {
      isLoginForm = !isLoginForm;
    });
  }

  Future<void> _formSubmit() async {
    setState(() {});
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (isLoginForm) {
        User _loginUser =
            await _userViewModel.signInWithEmailAndPassword(_email, _password);
        if (_loginUser != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/home', (Route<dynamic> route) => false);
        } else {}
      } else {
        User _registerUser = await _userViewModel
            .createUserWithEmailAndPassword(_email, _password);
        if (_registerUser != null) {
        } else {}
      }
    }
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _toast.showMessage(
          "Uygulamayı kullanabilmek için internet bağlantısı gereklidir");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();
    _userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: appColor,
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                Center(child: Image.asset("assets/img/logo.png", height: 150)),
                SizedBox(height: 50),
                Text(
                  "Email",
                  style: TextStyle(color: textColor, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: appColor,
                    elevation: 3,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _email = value.trim();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Lütfen Email adresinizi giriniz';
                        }
                        return null;
                      },
                      style: TextStyle(color: textColor),
                      onChanged: (value) {},
                      cursorColor: appYellow,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: textColor),
                          hintText: "Email",
                          hintStyle: TextStyle(color: textColor, fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Şifre",
                  style: TextStyle(color: textColor, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: appColor,
                    elevation: 3,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: TextFormField(
                      onSaved: (value) {
                        _password = value.trim();
                      },
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Şifreniz en az 6 karakter olmalıdır';
                        }
                        return null;
                      },
                      style: TextStyle(color: textColor),
                      onChanged: (value) {},
                      cursorColor: appYellow,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: iconColor,
                            ),
                          ),
                          errorStyle: TextStyle(color: textColor),
                          hintText: "Şifrenizi giriniz",
                          hintStyle: TextStyle(color: textColor, fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildButton(context),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        changePage();
                      },
                      child: Text(
                        isLoginForm
                            ? "Henüz yeni misin?"
                            : "Hesabın var mı? Giriş Yap",
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    Spacer(),
                    isLoginForm
                        ? GestureDetector(
                            onTap: () {
                              showResetPasswordDialog();
                            },
                            child: Text(
                              "Şifremi unuttum",
                              style: TextStyle(color: textColor),
                            ),
                          )
                        : Container()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(context) {
    if (_userViewModel.state == UserState.Busy) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(iconColor)));
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              isLoginForm ? "Giriş Yap" : "Kayıt Ol",
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
            color: appYellow,
            height: 40,
            minWidth: double.infinity,
            onPressed: () async {
              bool result = await checkInternet();
              if (result) {
                _formSubmit();
              }
            }),
      );
    }
  }

  void showResetPasswordDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: appColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text("Reset Password", style: TextStyle(color: textColor)),
            content: Form(
              key: _resetPassFormKey,
              child: Material(
                color: appColor,
                elevation: 3,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    resetPassEmail = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Lütfen Email adresinizi giriniz';
                    }
                    return null;
                  },
                  style: TextStyle(color: textColor),
                  cursorColor: appYellow,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: textColor),
                      hintText: "Email",
                      hintStyle: TextStyle(color: textColor, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: appYellow,
                  child: Text(
                    "Gönder",
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                  onPressed: () async {
                    bool result = await checkInternet();
                    if (result) {
                      if (_resetPassFormKey.currentState.validate()) {
                        await _userViewModel
                            .resetPassword(resetPassEmail.trim());
                      }
                    }
                  }),
            ],
          );
        });
  }
}
