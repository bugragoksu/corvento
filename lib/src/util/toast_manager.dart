import 'package:eventapp/src/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastManager {
  localizedMessageFromFirebase(message) {
    var selectedMessage = "";
    switch (message) {
      case "ERROR_INVALID_EMAIL":
        selectedMessage = "Email adresi hatalı";
        break;
      case "ERROR_USER_NOT_FOUND":
        selectedMessage = "Böyle bir email adresi kayıtlı değildir";
        break;
      case "ERROR_WRONG_PASSWORD":
        selectedMessage = "Hatalı email veya şifre";
        break;

      default:
        selectedMessage =
            "Ups. Bir şeyler ters gitti. Daha sonra tekrar deneyiniz";
    }
    showMessage(selectedMessage);
  }

  showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: appTransparentColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
