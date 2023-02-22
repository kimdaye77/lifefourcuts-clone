import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifefourcuts_clone/screen/create_frame_screen.dart';

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  XFile? pickedFile;
  CroppedFile? croppedFile;

  // 이미지 업로드 함수
  Future<void> fnUploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fnCropImage(pickedFile);
    }
  }

  /// 수정된 이미지를 받아서 기존 변수 _croppedFile에 수정된 이미지로 덮어씌움.
  Future<void> fnCropImage(XFile pickedFile) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '사진 편집',
          toolbarWidgetColor: Colors.black,
          activeControlsWidgetColor: Theme.of(context).backgroundColor,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );
    nextStep(croppedFile!);
  }

  Future<void> nextStep(CroppedFile croppedFile) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => CreateFrame(
              croppedFile: croppedFile,
            )),
      ),
    );
  }

  void fnClear() {
    setState(() {
      pickedFile = null;
      croppedFile = null;
    });
  }

  @override
  void initState() {
    fnUploadImage();
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
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
