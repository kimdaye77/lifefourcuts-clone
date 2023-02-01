import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class FAB extends StatefulWidget {
  const FAB({super.key});

  @override
  State<FAB> createState() => _FABState();
}

class _FABState extends State<FAB> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
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
        setState(() {
          isOpened = !isOpened;
        });
      },
      fabCloseColor: const Color(0xffff8ea2),
      fabColor: const Color(0xffff8ea2),
      fabOpenColor: const Color(0xffff8ea2),
      ringDiameter: 300,
      ringWidth: 150,
      ringColor: Colors.white,
      alignment: Alignment.bottomCenter,
      children: [
        Wrap(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text('Beta'),
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  ),
                  const Text('프레임 만들기'),
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text('Beta'),
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  ),
                  const Text('프레임 만들기'),
                ],
              ),
            ),
          ],
        ),
        Wrap(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text('Beta'),
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  ),
                  const Text('프레임 만들기'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
