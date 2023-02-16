import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:last_sign_in/view_models/sign_in_view_model.dart';
import 'package:last_sign_in/view_models/sign_in_with_Google_view_model.dart';
import 'package:last_sign_in/view_models/sign_in_with_facebook_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  // GoogleSignInAccount? _currentUser;
  // @override
  // void initState() {
  //   super.initState();
  //   // _googleSignIn.onCurrentUserChanged.listen((account) {
  //   //   setState(() {
  //   //     _currentUser = account;
  //   //   });
  //   // });
  //   // _googleSignIn.signInSilently();

  // }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Sign_in_with_Google_view_model>(context, listen: false)
          .userIsSignedIn();
      if (Provider.of<Sign_in_with_Google_view_model>(context, listen: false)
              .currentUser !=
          null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/details', (route) => false, arguments: {
          'name':
              '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).currentUser?.displayName}',
          'accessToken':
              '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).accessToken}',
          'email':
              '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).currentUser!.email}',
          'imageURL':
              '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).currentUser!.photoUrl}',
          'SignInType': 'Google'
        });
      }
      Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false)
          .checkIfIsLogged();
      if (Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false)
              .userData !=
          null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/details', (route) => false, arguments: {
          'name':
              '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).userData!["name"]}',
          'accessToken':
              '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).accessToken!.toJson()}',
          'email':
              '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).userData!["email"]}',
          'imageURL':
              '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).userData!["picture"]["data"]["url"]}',
          'SignInType': 'Facebook'
        });
      }
    });
  }

  String accessToken = '';
  @override
  Widget build(BuildContext context) {
    // GoogleSignInAccount? user =
    //     Provider.of<Sign_in_with_Google_view_model>(context, listen: false)
    //         .currentUser;
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final screenSize = (mq.size.height + mq.size.width) / 2;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 75,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(120),
              ),
              gradient: LinearGradient(
                colors: [Colors.cyan[900]!, Colors.cyan[100]!],
              ),
            ),
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  // Provider.of<Sign_in_with_Google_view_model>(context)
                  //             .currentUser ==
                  //         null
                  //     ?
                  'Sign in'
                  // : 'Welcome! ${Provider.of<Sign_in_with_Google_view_model>(context).currentUser?.displayName}'
                  ,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              // if (Provider.of<Sign_in_with_Google_view_model>(context)
              //         .currentUser ==
              //     null)
              Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    'assets/images/logo.png',
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'This simple app was built by ',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Fadi Asfour',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = Provider.of<Sign_in_view_model>(context,
                                listen: false)
                            .GoToURL,
                    ),
                    TextSpan(
                      text:
                          ' to help developers to get access token when try to sign in with Google or Facebook account',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Container(
            child: _buildWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildWidget() {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final screenSize = (mq.size.height + mq.size.width) / 2;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You are not signed in',
                style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 0,
                width: 0,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<Sign_in_view_model>(context, listen: false)
                        .changeIsRobotState();
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     '/details', (route) => false,
                    //     arguments: {
                    //       'name': 'n',
                    //       'accessToken':
                    //           'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                    //       'email': 'f',
                    //       'imageURL':
                    //           'https://static.javatpoint.com/computer/images/what-is-the-url.png',
                    //       'SignInType': 'Google'
                    //     });
                  },
                  child: null,
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).pushNamedAndRemoveUntil(
              //           '/details', (route) => false,
              //           arguments: {
              //             'name': 'n',
              //             'accessToken':
              //                 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
              //             'email': 'f',
              //             'imageURL':
              //                 'https://static.javatpoint.com/computer/images/what-is-the-url.png',
              //             'SignInType': 'Google'
              //           });
              //     },
              //     child: Text('navigate')),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: (250 + mq.size.width * 0.15 > 300
                      ? 300
                      : 250 + mq.size.width * 0.15),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (Provider.of<Sign_in_view_model>(context,
                                      listen: false)
                                  .isRobot ==
                              false) {
                            await Provider.of<Sign_in_with_Google_view_model>(
                                    context,
                                    listen: false)
                                .signIn();
                            print(Provider.of<Sign_in_with_Google_view_model>(
                                    context,
                                    listen: false)
                                .currentUser);
                            if (Provider.of<Sign_in_with_Google_view_model>(
                                        context,
                                        listen: false)
                                    .currentUser !=
                                null) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/details', (route) => false,
                                  arguments: {
                                    'name':
                                        '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).currentUser?.displayName}',
                                    'accessToken':
                                        '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).accessToken}',
                                    'email':
                                        '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).currentUser!.email}',
                                    'imageURL':
                                        '${Provider.of<Sign_in_with_Google_view_model>(context, listen: false).currentUser!.photoUrl}',
                                    'SignInType': 'Google'
                                  });
                            }
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign in with Google ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: (14 + screenSize * 0.001),
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              height: 40,
                              width: 25,
                              child: Image.asset('assets/images/google.png')),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: (250 + mq.size.width * 0.15 > 300
                      ? 300
                      : 250 + mq.size.width * 0.15),
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (Provider.of<Sign_in_view_model>(context,
                                      listen: false)
                                  .isRobot ==
                              false) {
                            await Provider.of<Sign_in_with_Facebook_view_model>(
                                    context,
                                    listen: false)
                                .login();
                            if (Provider.of<Sign_in_with_Facebook_view_model>(
                                        context,
                                        listen: false)
                                    .userData !=
                                null) {
                              print(
                                  Provider.of<Sign_in_with_Facebook_view_model>(
                                          context,
                                          listen: false)
                                      .userData!["name"]);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/details', (route) => false,
                                  arguments: {
                                    'name':
                                        '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).userData!["name"]}',
                                    'accessToken':
                                        '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).accessToken!.toJson()['token']}',
                                    'email':
                                        '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).userData!["email"]}',
                                    'imageURL':
                                        '${Provider.of<Sign_in_with_Facebook_view_model>(context, listen: false).userData!["picture"]["data"]["url"]}',
                                    'SignInType': 'Facebook'
                                  });
                            }
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign in with Facebook ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: (14 + screenSize * 0.001),
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              height: 40,
                              width: 25,
                              child: Image.asset('assets/images/facebook.png')),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
