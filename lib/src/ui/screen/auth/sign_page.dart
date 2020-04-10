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

  String _email, _password;

  bool isLoginForm = true;

  bool firstCheck = true;

  void changePage() {
    setState(() {
      isLoginForm = !isLoginForm;
    });
  }

  Future<void> _formSubmit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

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
                    changePage();
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
    if (false) {
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
}
