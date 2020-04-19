import 'package:eventapp/src/config/constant.dart';
import 'package:eventapp/src/model/user.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

//TODO FIX THIS SHIT PAGE

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

  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
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
                Center(child: Image.asset("assets/img/logo.png", height: 200)),
                Text(
                  "Email",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: appTransparentColor,
                    elevation: 1,
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
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {},
                      cursorColor: appYellow,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white70),
                          hintText: "Email",
                          hintStyle:
                              TextStyle(color: Colors.white70, fontSize: 14),
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
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: appTransparentColor,
                    elevation: 1,
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
                      style: TextStyle(color: Colors.white),
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
                              color: Colors.white,
                            ),
                          ),
                          errorStyle: TextStyle(color: Colors.white70),
                          hintText: "Şifrenizi giriniz",
                          hintStyle:
                              TextStyle(color: Colors.white70, fontSize: 14),
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
                        style: TextStyle(color: Colors.white),
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
                              style: TextStyle(color: Colors.white),
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
      return Center(child: CircularProgressIndicator());
    } else {
      return MaterialButton(
          padding: const EdgeInsets.all(.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            isLoginForm ? "Giriş Yap" : "Kayıt Ol",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          color: Colors.yellow.shade700,
          height: 40,
          minWidth: double.infinity,
          onPressed: () {
            _formSubmit();
          });
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
            title:
                Text("Reset Password", style: TextStyle(color: Colors.white)),
            content: Form(
              key: _resetPassFormKey,
              child: Material(
                color: appTransparentColor,
                elevation: 1,
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
                  style: TextStyle(color: Colors.white),
                  cursorColor: appYellow,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white70),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    "Gönder",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () async {
                    if (_resetPassFormKey.currentState.validate()) {
                      await _userViewModel.resetPassword(resetPassEmail.trim());
                    }
                  }),
            ],
          );
        });
  }
}
