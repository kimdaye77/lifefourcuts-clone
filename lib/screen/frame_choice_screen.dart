import 'package:flutter/material.dart';

import '../widget/category_widget.dart';

class FrameChoice extends StatefulWidget {
  const FrameChoice({super.key});

  @override
  State<FrameChoice> createState() => _FrameChoiceState();
}

class _FrameChoiceState extends State<FrameChoice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
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
                "프레임 선택",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 25,
                  ),
                  onPressed: () {},
                ),
              ],
              bottom: TabBar(
                indicatorColor: Theme.of(context).backgroundColor,
                unselectedLabelColor: Colors.black,
                labelColor: Theme.of(context).backgroundColor,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(
                    text: '인생네컷',
                  ),
                  Tab(
                    text: '브랜드관',
                  ),
                  Tab(
                    text: '작가관',
                  ),
                  Tab(
                    text: '엔터관',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(),
                const Category(
                  category: 'brand',
                ),
                Container(),
                Container(),
              ],
            )),
      ),
    );
  }
}
