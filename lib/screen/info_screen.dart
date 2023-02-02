import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifefourcuts_clone/screen/coupon_screen.dart';
import 'package:lifefourcuts_clone/screen/setting_screen.dart';
import 'package:http/http.dart' as http;

import '../widget/story_widget.dart';
import 'frame_choice_screen.dart';
import 'login_screen.dart';

class Info extends StatefulWidget {
  String name, provider, accessToken;
  Info(
      {super.key,
      required this.name,
      required this.provider,
      required this.accessToken});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  void signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    setState(() {
      widget.name = "";
      widget.provider = "";
    });

    print("Sign out");
  }

  Future<bool> signOutwithKakao() async {
    // final clientState = const Uuid().v4();

    // final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
    //   'response_type': 'code',
    //   'client_id': '148faed447a0971199aff197f0c37b49',
    //   'redirect_uri': 'http://192.168.56.1:8080/kakao/sign_out',
    //   'state': clientState,
    // });
    final url = Uri.parse("http://192.168.56.1:8080/kakao/sign_out");
    final result = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'accessToken': widget.accessToken,
      },
    );
    // final result = await FlutterWebAuth.authenticate(
    //     url: url.toString(), callbackUrlScheme: "webauthcallback");
    if (result == widget.accessToken) {
      return true;
    } else {
      return false;
    }
  }

  void _showLogOutDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    child: Text(
                      "안내",
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade700),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    child: Text(
                      "로그아웃을 하시겠습니까?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xffc19e85),
                              ),
                              right: BorderSide(
                                color: Color(0xffc19e85),
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (widget.provider == "google") {
                                signOutWithGoogle();
                                print("googlesignout");
                              } else if (widget.provider == "kakao") {
                                signOutwithKakao();
                                print("kakaosignout");
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => Login(
                                        name: widget.name,
                                        provider: "",
                                        accessToken: "",
                                      )),
                                ),
                              );
                            },
                            child: Text(
                              '예',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xffc19e85),
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              '아니오',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

          /**SizedBox(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Column(
                children: [
                  Text(
                    "안내",
                    style: TextStyle(fontSize: 17, color: Colors.grey.shade700),
                  ),
                ],
              ),
              content: Text(
                "로그아웃을 하시겠습니까?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          '예',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          '아니오',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        **/
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).backgroundColor,
          title: const Text(
            "인생네컷",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'GmarketSans',
              fontSize: 23,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.grey,
                size: 25,
              ),
              onPressed: _showLogOutDialog,
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const Setting()),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 150),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 70,
                            color: Colors.grey.shade400,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                          ),
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Coupon())));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'My쿠폰',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Signal',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xffc19e85),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '[ + ] 버튼을 눌러 촬영 QR을 만들어보세요!',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xfff3ad50),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              '즐겨찾기',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: const Color(0xffc19e85),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        color: const Color(0xffdececa),
                        icon: const Icon(
                          Icons.add_rounded,
                          size: 50,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const FrameChoice()),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'STORY',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 18,
                  ),
                ),
                const Story(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
