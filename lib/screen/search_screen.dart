import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/frame_model.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late FirebaseFirestore firestore;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    firestore = FirebaseFirestore.instance;
    streamData = firestore.collection('frame').snapshots();
    super.initState();
  }

  Widget _fetchData(BuildContext context) {
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
        return _buildBody(context, snapshot.data!.docs);
      },
    );
  }

  List<String> images = [
    "images/frame_butterfly.png",
    "images/frame_feather.png",
    "images/frame_merry.png",
    "images/frame_newyear.png",
    "images/frame_purple.png",
    "images/frame_snow.png",
  ];

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Frame> frames = snapshot.map((e) => Frame.fromSnapshot(e)).toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).backgroundColor,
          title: const Text(
            "검색",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 240, 236, 229),
                            hintText: '검색',
                            prefixIcon: const Icon(
                              Icons.search_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        '추천 해시태그',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 5,
                    runSpacing: 10,
                    children: _buildTags(frames),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: const [
                      Text(
                        '추천 프레임',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: SizedBox(
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: _buildFrame(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFrame(BuildContext context) {
    List<Widget> frames = [];
    for (var i in images) {
      frames.add(
        Container(
          padding: const EdgeInsets.all(
            10,
          ),
          child: InkWell(
            onTap: () {},
            child: Image.asset(i),
          ),
        ),
      );
    }
    return frames;
  }

  List<Widget> _buildTags(List<Frame> frames) {
    List<String> tags = [];
    List<Widget> hashtags = [];
    for (var f in frames) {
      List<String> tmp = f.hashtag.split(' ');
      for (var t in tmp) {
        if (tags.contains(t)) continue;
        tags.add(t);
        hashtags.add(
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(t),
          ),
        );
      }
    }
    return hashtags;
  }
}
