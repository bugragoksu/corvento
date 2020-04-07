import 'package:eventapp/src/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

//TODO FIX THIS SHIT PAGE

class SignPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoginForm = true;
  bool firstCheck = true;

  UserViewModel _userViewModel;

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height / 5,
                ),
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
                      controller: _email,
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
                      controller: _password,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Şifreniz en az 6 karakter olmalıdır';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {},
                      cursorColor: appYellow,
                      decoration: InputDecoration(
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
                GestureDetector(
                  onTap: () {
                    // changePage();
                  },
                  child: Text(
                    isLoginForm
                        ? "Henüz hesabın yok mu? Kayıt ol"
                        : "Zaten kayıtlı mısın? Giriş Yap",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(context) {
    if (_userViewModel.state == UserState.UserLoadingState) {
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
          if (_formKey.currentState.validate()) {
            if (isLoginForm) {
              _userViewModel.signIn(_email.text.trim(), _password.text.trim());
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (Route<dynamic> route) => false);
              });
            } else {
              _userViewModel.signUp(_email.text.trim(), _password.text.trim());
            }
          }
        },
      );
    }
  }
}
