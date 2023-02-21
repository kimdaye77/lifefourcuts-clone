import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  // 이미지 업로드 함수
  Future<void> fn_uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  /// 수정된 이미지를 받아서 기존 변수 _croppedFile에 수정된 이미지로 덮어씌움.
  Future<void> fn_cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  void fn_clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
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
        body: const TextButton(
          onPressed: null,
          child: Text('d'),
        ),
      ),
    );
  }
}
