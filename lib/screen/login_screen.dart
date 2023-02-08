import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:lifefourcuts_clone/screen/home_screen.dart';
import 'package:uuid/uuid.dart';

class Login extends StatefulWidget {
  String name;
  String provider;
  String accessToken;

  Login(
      {super.key,
      required this.name,
      required this.provider,
      required this.accessToken});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool _loading;
  var googleProvider = GoogleAuthProvider();
  var kakaoProvider = kakao.TokenManagerProvider;

  @override
  void initState() {
    _loading = true;
    super.initState();
  }

  Future<bool> signInWithKakao() async {
    if (_loading) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).backgroundColor,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ),
      );
    }
    final clientState = const Uuid().v4();

    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': "code",
      'client_id': '148faed447a0971199aff197f0c37b49',
      'redirect_uri': 'http://192.168.56.1:8080/kakao/sign_in',
      'state': clientState,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: 'webauthcallback');
    final params = Uri.parse(result).queryParameters;

    String customToken;
    widget.accessToken = params['accessToken']!;
    customToken = params['customToken']!;

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCustomToken(customToken);
    User? user = authResult.user;
    if (user == null) return false;

    setState(() {
      widget.name = user.displayName!;
      widget.provider = "kakao";
      _loading = false;
    });

    return true;
  }

  Future<bool> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResult.user;
      if (user == null) return false;
      setState(() {
        widget.name = user.displayName!;
        widget.provider = "google";
        _loading = false;
      });
    } catch (e) {
      print(e);
    }

    return true;
  }

  signInWithFacebook() {}

  signInWithNaver() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
            ),
            const Image(
              height: 170,
              image: AssetImage(
                'images/pink_logo2.png',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(300, 50),
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () async {
                    if (await signInWithKakao()) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => HomeScreen(
                                name: widget.name,
                                provider: widget.provider,
                                accessToken: widget.accessToken,
                              )),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    '카카오톡으로 로그인하기',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color.fromRGBO(234, 067, 053, 1),
                  ),
                  onPressed: () async {
                    if (await signInWithGoogle()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => HomeScreen(
                                name: widget.name,
                                provider: widget.provider,
                                accessToken: widget.accessToken,
                              )),
                        ),
                      );
                    } else {
                      () => Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          );
                    }
                  },
                  child: const Text(
                    '구글로 로그인하기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color(0xFF3b5998),
                  ),
                  onPressed: () async {
                    if (await signInWithFacebook()) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => HomeScreen(
                                name: widget.name,
                                provider: widget.provider,
                                accessToken: widget.accessToken,
                              )),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    '페이스북으로 로그인하기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color(0xff2db400),
                  ),
                  onPressed: () async {
                    if (await signInWithNaver()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => HomeScreen(
                                name: widget.name,
                                provider: widget.provider,
                                accessToken: widget.accessToken,
                              )),
                        ),
                      );
                    } else {
                      () => Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          );
                    }
                  },
                  child: const Text(
                    '네이버로 로그인하기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
