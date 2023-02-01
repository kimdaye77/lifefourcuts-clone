import 'package:flutter/material.dart';

import '../widget/story_widget.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryState();
}

class _StoryState extends State<StoryScreen> {
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
            "인생네컷",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'GmarketSans',
              fontSize: 23,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body:

            //데이터 없을 때
            SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: const Center(
              child: Story(),
            ),
          ),
        ),
      ),
    );
  }
}
