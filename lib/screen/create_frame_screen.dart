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
  /// ImageCard Widget
  Widget ImageCardWiget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ImageWidget(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  /// 실제 이미지 Widget
  Widget ImageWidget() {
    if (widget.croppedFile != null) {
      final path = widget.croppedFile.path;
      return WidgetMask(
        mask: Image.file(
          File(
            widget.croppedFile.path,
          ),
          fit: BoxFit.cover,
        ),
        blendMode: BlendMode.srcATop,
        childSaveLayer: true,
        child: Image.asset(
          'images/22frame.png',
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
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
              fontFamily: 'GmarketSans',
              fontSize: 23,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Container(
          child: ImageCardWiget(),
        ),
      ),
    );
  }
}
