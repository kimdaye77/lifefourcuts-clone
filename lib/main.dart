import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifefourcuts_clone/firebase_options.dart';
import 'package:lifefourcuts_clone/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // KakaoSdk.init(
  //   nativeAppKey: 'ae8fdf693c8d7c8d131dab4acf6af9aa',
  //   javaScriptAppKey: '949cbf74b763d4c442416b0ecf8e8072',
  // );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";
  String provider = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '인생네컷',
      theme: ThemeData(
        backgroundColor: const Color(0xffff8ea2),
        primaryColorLight: const Color.fromARGB(255, 255, 216, 223),
        primaryColorDark: const Color(0xff2c2c2c),
        focusColor: const Color(0xffc26470),
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xffff8ea2)),
      ),
      home: Login(
        name: name,
        provider: provider,
        accessToken: "",
      ),
    );
  }
}
