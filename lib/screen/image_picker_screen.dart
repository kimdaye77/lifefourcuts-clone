import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  XFile? pickedFile;
  CroppedFile? _croppedFile;

  // 이미지 업로드 함수
  Future<void> fn_uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fn_cropImage(pickedFile);
    }
  }

  /// 수정된 이미지를 받아서 기존 변수 _croppedFile에 수정된 이미지로 덮어씌움.
  Future<void> fn_cropImage(XFile pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '사진 편집',
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
      });
    }
  }

  void fn_clear() {
    setState(() {
      pickedFile = null;
      _croppedFile = null;
    });
  }

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
          // MenuWidget(),
        ],
      ),
    );
  }

  /// 실제 이미지 Widget
  Widget ImageWidget() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void initState() {
    fn_uploadImage();
    super.initState();
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
            "사진 선택하기",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'GmarketSans',
              fontSize: 23,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Column(
          children: [
            (_croppedFile == null) ? Container() : ImageWidget(),
          ],
        ),
      ),
    );
  }
}
