import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:last_sign_in/view_models/sign_in_view_model.dart';
import 'package:last_sign_in/view_models/sign_in_with_Google_view_model.dart';
import 'package:last_sign_in/view_models/sign_in_with_facebook_view_model.dart';
import 'package:provider/provider.dart';

class Details_view extends StatefulWidget {
  const Details_view({Key? key}) : super(key: key);
  // final name;
  // final email;
  // final imageURL;
  // final AccessToken;
  // final signInType;

  @override
  State<Details_view> createState() => _Details_viewState();
}

class _Details_viewState extends State<Details_view> {
  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final screenSize = mq.size.height + mq.size.width;
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
                bottomLeft: Radius.circular(120),
              ),
              gradient: LinearGradient(
                colors: [Colors.red[200]!, Colors.red[900]!, Colors.red[200]!],
              ),
            ),
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  // Provider.of<Sign_in_with_Google_view_model>(context)
                  //             .currentUser ==
                  //         null
                  //     ?
                  // 'Sign in'
                  // :
                  'Welcome! ${routeArg['name']}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              // if (Provider.of<Sign_in_with_Google_view_model>(context)
              //         .currentUser ==
              //     null)
              // Container(
              //     height: 30,
              //     width: 30,
              //     child: Image.asset(
              //       'assets/images/logo.png',
              //       color: Colors.white,
              //     )),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     'We are not responsible for any bad behavior when using this app.',
              //     style: TextStyle(
              //         color: Colors.grey,
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    routeArg['accessToken'] == '' ||
                            routeArg['accessToken'] == null
                        ? ''
                        : 'Signed in successfully',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading:
                        //  GoogleUserCircleAvatar(
                        //     identity: Provider.of<Sign_in_with_Google_view_model>(
                        //             context,
                        //             listen: false)
                        //         .currentUser!),
                        ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: routeArg['imageURL'],
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                      ),
                    ),
                    title: Text(
                      routeArg['name'],
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      routeArg['email'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     if (routeArg['accessToken'] != '' &&
                  //         routeArg['accessToken'] != null)
                  //       CupertinoButton(
                  //         onPressed: () {

                  //         },
                  //         child: Text(
                  //           'Copy this access token: ',
                  //           style: TextStyle(
                  //               color: Color(0xFF00BCD4),
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  /*  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.1,
                      // vertical: mq.size.height * 0.1
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.redAccent[100],
                      ),
                      child: routeArg['accessToken'] == '' ||
                              routeArg['accessToken'] == null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Please Sign out then Sign in to get new access token',
                                style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Access token: ',
                                        style: TextStyle(
                                            color: Colors.red[800],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: 'Copy access token',
                                      focusColor: Colors.white.withOpacity(0),
                                      hoverColor: Colors.white.withOpacity(0),
                                      highlightColor:
                                          Colors.white.withOpacity(0),
                                      disabledColor:
                                          Colors.white.withOpacity(0),
                                      splashColor: Colors.white.withOpacity(0),
                                      color: Colors.white.withOpacity(0),
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                                text: routeArg['accessToken']))
                                            .then(
                                          (value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Copied to Clipboard',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: kIsWeb
                                                      ? mq.size.width * 0.28
                                                      : 30),
                                            ));
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.copy_all_sharp,
                                        color: Colors.red[800],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, right: 8, left: 8),
                                  child: SelectableText(
                                    routeArg['accessToken'],
                                    toolbarOptions: ToolbarOptions(
                                        copy: true,
                                        selectAll: true,
                                        cut: true,
                                        paste: true),
                                    style: TextStyle(
                                        color: Colors.red[600],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 0,
                    width: 0,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<Sign_in_view_model>(context, listen: false)
                            .changeIsRobotState();
                      },
                      child: null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.2,
                      // vertical: mq.size.height * 0.3
                    ),
                    child: Container(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (Provider.of<Sign_in_view_model>(context,
                                        listen: false)
                                    .isRobot ==
                                false) {
                              if (routeArg['SignInType'] == 'Google') {
                                final response = await Provider.of<
                                            Sign_in_with_Google_view_model>(
                                        context,
                                        listen: false)
                                    .signOut();
                                if (Provider.of<Sign_in_with_Google_view_model>(
                                            context,
                                            listen: false)
                                        .currentUser ==
                                    null) {
                                  Navigator.of(context).popAndPushNamed('/');
                                }
                              }
                              if (routeArg['SignInType'] == 'Facebook') {
                                await Provider.of<
                                            Sign_in_with_Facebook_view_model>(
                                        context,
                                        listen: false)
                                    .logOut();
                                if (Provider.of<Sign_in_with_Facebook_view_model>(
                                            context,
                                            listen: false)
                                        .userData ==
                                    null) {
                                  Navigator.of(context).popAndPushNamed('/');
                                }
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign out',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                    height: 40,
                                    // width: 40,
                                    child: Icon(
                                      Icons.highlight_remove,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
