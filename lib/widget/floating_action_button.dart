import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

class FAB extends StatefulWidget {
  const FAB({super.key});

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  bool isOpened = false;
  bool camPermissionsGranted = false;

  Future<bool> CamPermissionIsGranted() async {
    if (await Permission.contacts.request().isGranted) {
      camPermissionsGranted = await Permission.camera.status.isGranted;
      setState(() {});
      return camPermissionsGranted;
    }
    print("Ds");

    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    print(statuses[Permission.storage]);
    openAppSettings();
    camPermissionsGranted = await Permission.camera.status.isGranted;
    setState(() {});
    return camPermissionsGranted;
  }

  @override
  void initState() {
    isOpened = false;
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
            onPressed: () => _showMenu(),
          ),
        ),
      ),
    );
  }

  void _showMenu() {
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
            child: _menulist(),
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return FabCircularMenu(
      fabElevation: 0,
      animationDuration: const Duration(
        milliseconds: 0,
      ),
      fabMargin: isOpened
          ? const EdgeInsets.only(
              bottom: 160,
            )
          : const EdgeInsets.only(
              bottom: 25,
            ),
      fabSize: 66,
      fabOpenIcon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: Colors.white,
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 216, 223),
          size: 30,
        ),
      ),
      fabCloseIcon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: Colors.white,
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          color: Color.fromARGB(255, 255, 216, 223),
          size: 30,
        ),
      ),
      onDisplayChange: (isClose) {
        // CamPermissionIsGranted();
        setState(() {
          isOpened = !isOpened;
        });
        if (isOpened) _showMenu();
      },
      fabCloseColor: const Color(0xffff8ea2),
      fabColor: const Color(0xffff8ea2),
      fabOpenColor: const Color(0xffff8ea2),
      ringDiameter: 300,
      ringWidth: 150,
      ringColor: Colors.white,
      alignment: Alignment.bottomCenter,
      children: [
        Container(),
      ],
    );
  }

  Widget _menulist() {
    List<Widget> items = [
      Center(
        child: Positioned.fill(
          child: Transform.translate(
            offset: Offset.fromDirection(9 * math.pi / 8, 80),
            child: SizedBox(
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.photo_camera_back_outlined,
                    size: 30,
                  ),
                  // Text('프레임 만들기'),
                ],
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Positioned.fill(
          child: Transform.translate(
            offset: Offset.fromDirection(15 * math.pi / 8, 80),
            child: SizedBox(
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.photo_size_select_large_outlined,
                    size: 30,
                  ),
                  // Text('포토 프린트'),
                ],
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Positioned.fill(
          child: Transform.translate(
            offset: Offset.fromDirection(math.pi / 2, 80),
            child: SizedBox(
              height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.filter,
                    size: 30,
                  ),
                  // Text('프레임 선택'),
                ],
              ),
            ),
          ),
        ),
      ),
    ];

    return Stack(
      alignment: Alignment.bottomCenter,
      children: items,
    );
  }
}
