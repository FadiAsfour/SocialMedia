import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sign_in_view_model with ChangeNotifier {
  bool isSigned = false;
  bool isRobot = false;
  changeIsSignedState() {
    isSigned = !isSigned;
    notifyListeners();
  }
  changeIsRobotState() {
    isRobot = true;
    notifyListeners();
  }

  Future<void> GoToURL() async {
    try {
      if (!await launchUrl(
          Uri.parse('https://www.linkedin.com/in/fadi-asfour/'))) {
        throw 'Could not launch https://www.linkedin.com/in/fadi-asfour/';
      }
    } catch (e) {
      print(e);
    }
  }
}
