import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.grey,
            size: 25,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).backgroundColor,
          title: const Text(
            "설정",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: const Text(
                      '일반',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(child: const Text('공지사항')),
                  Container(child: const Text('알림')),
                  Container(child: const Text('버전정보')),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    '고객센터',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text('FAQ'),
                  Text('카카오톡으로 문의하기'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const [
                  Text(
                    '기타',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text('서비스 이용약관'),
                  Text('개인정보 처리방침'),
                  Text('오픈소스 라이센스'),
                  Text('회원탈퇴'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
