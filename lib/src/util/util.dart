import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Util {
  IconData switchIcon(String name) {
    IconData selectedIcon;
    switch (name) {
      case "Yazılım":
        selectedIcon = FontAwesomeIcons.terminal;
        break;
      case "Girişimcilik":
        selectedIcon = FontAwesomeIcons.building;
        break;
      case "Sağlık":
        selectedIcon = FontAwesomeIcons.heartbeat;
        break;
      default:
        selectedIcon = FontAwesomeIcons.stream;
    }
    return selectedIcon;
  }
}
