import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifefourcuts_clone/screen/search_screen.dart';
import 'package:lifefourcuts_clone/screen/story_screen.dart';
import 'package:lifefourcuts_clone/widget/floating_action_button.dart';

import '../model/frame_model.dart';
import '../widget/bottom_bar.dart';
import 'info_screen.dart';

class HomeScreen extends StatefulWidget {
  String name;
  HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isOpened;
  late FirebaseFirestore firestore;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    isOpened = false;
    firestore = FirebaseFirestore.instance;
    streamData = firestore.collection('frame').snapshots();
    super.initState();
  }

  Widget _fetchData(BuildContext context) {
    List<Frame> frames = [];
    return StreamBuilder(
      stream: streamData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).backgroundColor,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        }
        frames = snapshot.data!.docs.map((e) => Frame.fromSnapshot(e)).toList();
        return _buildList(frames);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Home(),
              const StoryScreen(),
              const SizedBox(),
              const Search(),
              Info(
                name: widget.name,
              ),
            ],
          ),
          bottomNavigationBar: const Bottom(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          // floatingActionButton: Container(
          //   padding: const EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       width: 3,
          //       color: const Color(0xffff8ea2),
          //     ),
          //     color: Colors.white,
          //     shape: BoxShape.circle,
          //   ),
          //   child: FloatingActionButton(
          //     elevation: 1,
          //     onPressed: (() {}),
          //     child: const Icon(
          //       Icons.add,
          //       size: 30,
          //     ),
          //   ),
          // ),
          floatingActionButton: const FAB(),
        ),
      ),
    );
  }

  Widget _buildList(List<Frame> frames) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: frames.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  frames[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.042,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Text(
                                  frames[index].hashtag,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.21,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.015,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: const Text(
                            '더보기',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //리스트뷰..
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Image(
                  width: MediaQuery.of(context).size.width * 0.28,
                  image: AssetImage(
                    frames[index].image,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget Home() {
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
        body: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        width: 1,
                      ),
                    ),
                    child: const Image(
                      image: AssetImage('images/banner.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            _fetchData(context),
          ]),
        ),
      ),
    );
  }
}
