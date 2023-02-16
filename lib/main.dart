import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:last_sign_in/view_models/sign_in_view_model.dart';
import 'package:last_sign_in/view_models/sign_in_with_Google_view_model.dart';
import 'package:last_sign_in/view_models/sign_in_with_facebook_view_model.dart';
import 'package:last_sign_in/views/details_view.dart';
import 'package:last_sign_in/views/sign_in_view.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webInitialize(
      appId: "5957229224301292",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => Sign_in_with_Facebook_view_model()),
          ChangeNotifierProvider(
              create: (context) => Sign_in_with_Google_view_model()),
          ChangeNotifierProvider(create: (context) => Sign_in_view_model()),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/details': (context) => Details_view(),
            '/': (context) => Sign_in(),
          },
          title: 'Get Access Token',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.cyan,
          ),
          // home: FacebookSignin(),
        ));
  }
}




// <meta name="google-signin-client_id" content="YOUR_GOOGLE_SIGN_IN_OAUTH_CLIENT_ID.apps.googleusercontent.com">

//flutter run -d chrome --web-hostname localhost --web-port 5000
