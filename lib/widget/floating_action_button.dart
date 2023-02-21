import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

import '../screen/image_picker.dart';

class FAB extends StatefulWidget {
  const FAB({super.key});

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  late bool camPermissionGranted;
  late bool storagePermissionGranted;

  bool ischk = false;

  void permissionRequest() async {
    await [
      Permission.camera,
      Permission.storage,
    ].request();
    setState(() {
      ischk = true;
    });
    permissionChk();
  }

  void permissionChk() async {
    camPermissionGranted = await Permission.camera.status.isGranted;
    storagePermissionGranted = await Permission.storage.status.isGranted;
  }

  @override
  void initState() {
    permissionChk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).backgroundColor,
          border: Border.all(
            width: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border.all(
              width: 4,
              color: Colors.white,
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 30,
                color: Color.fromARGB(255, 255, 216, 223),
              ),
              onPressed: () {
                print(camPermissionGranted);

                if (!ischk) {
                  permissionRequest();
                }

                if (camPermissionGranted && storagePermissionGranted) {
                  _showMenu(context);
                } else if (ischk) {
                  showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: const Text(
                              "카메라 및 저장소에\n 대한 권한이 필요합니다.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                openAppSettings();
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: const Text('환경 설정')),
                            )
                          ],
                        )),
                  );
                }
                permissionChk();
              }),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.bottomCenter,
        insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              300,
            ),
          ),
        ),
        content: SizedBox(
          width: 280,
          height: 280,
          child: Center(
            child: _menulist(context),
          ),
        ),
      ),
    );
  }
}

Widget _menulist(BuildContext context) {
  List<Widget> items = [
    Positioned.fill(
      child: Transform.translate(
        offset: Offset.fromDirection(21 * math.pi / 18, 90),
        child: InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const Picker()))),
          child: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Beta',
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 24,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Icon(
                  Icons.photo_camera_back_outlined,
                  size: 30,
                  color: Theme.of(context).backgroundColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '프레임 만들기',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    Positioned.fill(
      child: Transform.translate(
        offset: Offset.fromDirection(33 * math.pi / 18, 90),
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Beta',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'DancingScript',
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Icon(
                Icons.photo_size_select_large_outlined,
                size: 30,
                color: Theme.of(context).backgroundColor,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '포토 프린터',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Positioned.fill(
      child: Transform.translate(
        offset: Offset.fromDirection(17 * math.pi / 8, 90),
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 2 * math.pi / 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(70, 255, 216, 223),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 4,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Positioned.fill(
      child: Transform.translate(
        offset: Offset.fromDirection(7 * math.pi / 8, 90),
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 1 * math.pi / 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(70, 255, 216, 223),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 4,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Positioned.fill(
      child: Transform.translate(
        offset: Offset.fromDirection(3 * math.pi / 2, 90),
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(70, 255, 216, 223),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 4,
                height: 60,
              ),
            ],
          ),
        ),
      ),
    ),
    Positioned.fill(
      child: Transform.translate(
        offset: Offset.fromDirection(0, 0),
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).backgroundColor,
                  border: Border.all(
                    width: 2.5,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    border: Border.all(
                      width: 4,
                      color: Colors.white,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                      color: Color.fromARGB(255, 255, 216, 223),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Positioned.fill(
      child: Transform.translate(
        offset: Offset.fromDirection(math.pi / 2, 90),
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.filter,
                size: 30,
                color: Theme.of(context).backgroundColor,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '프레임 선택',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  return Stack(
    children: items,
  );
}
