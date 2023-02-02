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
  late final bool _loading = true;
  var googleProvider = GoogleAuthProvider();
  var kakaoProvider = kakao.TokenManagerProvider;

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
      });
    } catch (e) {
      print(e);
    }

    return true;
  }

  void signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    setState(() {
      widget.name = "";
      widget.provider = "";
    });

    print("Sign out");
  }

  Future<bool> signInWithKakao() async {
    final clientState = const Uuid().v4();

    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': "code",
      'client_id': '148faed447a0971199aff197f0c37b49',
      'redirect_uri': 'http://192.168.56.1:8080/kakao/sign_in',
      'state': clientState,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: 'webauthcallback');
    print(result);

    final params = Uri.parse(result).queryParameters;

    String customToken;
    widget.accessToken = params['accessToken']!;
    customToken = params['customToken']!;

    print(params);

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCustomToken(customToken);
    User? user = authResult.user;
    if (user == null) return false;

    setState(() {
      widget.name = user.displayName!;
      widget.provider = "kakao";
    });
    print(widget.name);

    return true;
  }

  void signOutwithKakao() async {
    final clientState = const Uuid().v4();

    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': '148faed447a0971199aff197f0c37b49',
      'redirect_uri': 'http://192.168.56.1:8080/kakao/sign_out',
      'state': clientState,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "webauthcallback");
    final params = Uri.parse(result).queryParameters;
    print(params['customToken']);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25 //150,
                ),
            const Image(
              height: 170,
              image: AssetImage(
                'images/pink_logo2.png',
              ),
            ),
            // Text(
            //   '인생\n네컷',
            //   style: TextStyle(
            //     fontSize: 80,
            //     color: Theme.of(context).backgroundColor,
            //     fontFamily: 'GmarketSans',
            //     fontWeight: FontWeight.w300,
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15, //200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: signOutwithKakao,
                  child: Text(
                    'SNS로그인으로 시작하기',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
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

            const SizedBox(
              height: 15,
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
          ],
        ),
      ),
    );
  }
}
