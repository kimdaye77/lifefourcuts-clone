import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:widget_mask/widget_mask.dart';

class CreateFrame extends StatefulWidget {
  final CroppedFile croppedFile;
  const CreateFrame({super.key, required this.croppedFile});

  @override
  State<CreateFrame> createState() => _CreateFrameState();
}

class _CreateFrameState extends State<CreateFrame> {
  int selectedNum = 0;
  late Widget frame = Image.file(
    File(
      widget.croppedFile.path,
    ),
  );

  Widget imageWiget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      child: frame,
    );
  }

  void addStyle(String path) {
    setState(() {
      frame = WidgetMask(
        mask: Image.file(
          File(
            widget.croppedFile.path,
          ),
          fit: BoxFit.cover,
        ),
        blendMode: BlendMode.srcATop,
        childSaveLayer: true,
        child: Image.asset(
          path,
        ),
      );
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
            "나만의 프레임 만들기",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                imageWiget(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Text(
                      '프레임 스타일',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: GridView.count(
                    mainAxisSpacing: 20,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          addStyle('images/22frame.png');
                          setState(() {
                            selectedNum = 1;
                          });
                        },
                        child: Image.asset(
                          'images/22frame.png',
                          color: selectedNum == 1
                              ? Theme.of(context).backgroundColor
                              : Colors.grey.shade400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addStyle('images/4frame.png');
                          setState(() {
                            selectedNum = 2;
                          });
                        },
                        child: Image.asset(
                          'images/4frame.png',
                          color: selectedNum == 2
                              ? Theme.of(context).backgroundColor
                              : Colors.grey.shade400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addStyle('images/22frame.png');
                          setState(() {
                            selectedNum = 3;
                          });
                        },
                        child: Image.asset(
                          'images/22frame.png',
                          color: selectedNum == 3
                              ? Theme.of(context).backgroundColor
                              : Colors.grey.shade400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addStyle('images/22frame.png');
                          setState(() {
                            selectedNum = 4;
                          });
                        },
                        child: Image.asset(
                          'images/22frame.png',
                          color: selectedNum == 4
                              ? Theme.of(context).backgroundColor
                              : Colors.grey.shade400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addStyle('images/22frame.png');
                          setState(() {
                            selectedNum = 5;
                          });
                        },
                        child: Image.asset(
                          'images/22frame.png',
                          color: selectedNum == 5
                              ? Theme.of(context).backgroundColor
                              : Colors.grey.shade400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addStyle('images/22frame.png');
                          setState(() {
                            selectedNum = 6;
                          });
                        },
                        child: Image.asset(
                          'images/22frame.png',
                          color: selectedNum == 6
                              ? Theme.of(context).backgroundColor
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
