import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign_in_with_Google_view_model with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? _currentUser;
  String _accessToken = '';

  String c_name = '';

  userIsSignedIn() {
    // to make user signedin if the user signein before
    // maybe don't need it
    _googleSignIn.onCurrentUserChanged.listen((account) {
      _currentUser = account;
    });
    _googleSignIn.signInSilently();
    notifyListeners();
  }

  signOut() {
    try {
      final response = _googleSignIn.disconnect();
      print(response);
    } catch (e) {
      print(e);
    }
    print('signed out from Google ');
    _currentUser = null;
    notifyListeners();
    return true;
  }

  // Future<void> signIn() async {
  //   try {
  //     final access = await _googleSignIn.signIn();
  //     final accessValue = await access?.authentication;
  //     // if(accessValue)
  //     accessToken = accessValue!.accessToken.toString();
  //   } catch (e) {
  //     print('Google Sign in Errooor: $e');
  //   }
  //   // return '';
  // }
  Future<String?> signIn() async {
    try {
      final access = await _googleSignIn.signIn();
      final accessValue = await access?.authentication;
      // if(accessValue)
      _accessToken = accessValue!.accessToken.toString();
      print(accessToken);
      notifyListeners();
      return accessValue.accessToken.toString();
    } catch (e) {
      print('Google Sign in Errooor: $e');
    }
    return '';
  }
  // Future<void> signIn() async {
  //   _googleSignIn.signIn().then((result) {
  //     result?.authentication.then((googleKey) {
  //       accessToken = googleKey.accessToken.toString();
  //       notifyListeners();
  //       print("ACCESS TOKEN:${googleKey.accessToken}");
  //       //   print(googleKey.idToken);
  //       //  print(_googleSignIn.currentUser?.displayName);
  //       return accessToken;
  //     }).catchError((err) {
  //       print('inner error');
  //       print(err);
  //     });
  //   }).catchError((err) {
  //     print('error occured');
  //     print(err);
  //   });
  // }

  String get accessToken => _accessToken;
  GoogleSignInAccount? get currentUser => _currentUser;
}
