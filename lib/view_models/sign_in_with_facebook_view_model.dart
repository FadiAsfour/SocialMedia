import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Sign_in_with_Facebook_view_model with ChangeNotifier {
  Map<String, dynamic>? userData;
  bool checking = true;
  AccessToken? accessToken;
  Future<void> checkIfIsLogged() async {
    final internalaccessToken = await FacebookAuth.instance.accessToken;
    checking = false;

    if (accessToken != null) {
      print("is Logged:::: ${(internalaccessToken?.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final internaluserData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      accessToken = internalaccessToken;

      userData = internaluserData;
    }
    notifyListeners();
  }

  Future<void> login() async {
    print('faceboooooook');
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public profile', 'user birthday', 'user friends', 'user gender', 'user link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;
      print(
        accessToken!.toJson(),
      );
      // get the user data
      // by default we get the userId, email,name and picture
      final internaluserData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      userData = internaluserData;
    } else {
      print(result.status);
      print(result.message);
    }
    checking = false;
    notifyListeners();
  }

  Future<void> logOut() async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    userData = null;
    notifyListeners();
  }
}
