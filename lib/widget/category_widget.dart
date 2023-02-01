import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifefourcuts_clone/model/frame_model.dart';
import 'package:lifefourcuts_clone/screen/qrgenerator_screen.dart';

class Category extends StatefulWidget {
  final String category;

  const Category({
    super.key,
    required this.category,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool viewTwo = true;
  String selectedBrand = '카카오프렌즈';
  List<Frame> frame = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('frame').snapshots(),
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
        frame = snapshot.data!.docs.map((e) => Frame.fromSnapshot(e)).toList();
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildBrand(context),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                viewTwo = true;
                              });
                            },
                            child: Icon(
                              Icons.view_agenda_sharp,
                              color: viewTwo
                                  ? Theme.of(context).backgroundColor
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              viewTwo = false;
                            });
                          },
                          child: Icon(
                            Icons.view_column,
                            size: 31,
                            color: !viewTwo
                                ? Theme.of(context).backgroundColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            '최신순',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade600,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildFrame(context),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }

  Widget _buildBrand(BuildContext context) {
    List<String> brands = [];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: frame.length,
              itemBuilder: (context, index) {
                if (frame[index].brand != null &&
                    brands.contains(frame[index].brand!) == false) {
                  brands.add(frame[index].brand!);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedBrand = frame[index].brand!;
                      });
                    },
                    child: (selectedBrand == frame[index].brand!)
                        ? Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  frame[index].brand!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  frame[index].brand!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  );
                }
                return Container();
              }),
        ),
      ],
    );
  }

  Widget _buildFrame(BuildContext context) {
    List<Widget> frames = [];
    for (var i in frame) {
      if (i.brand == selectedBrand) {
        frames.add(
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRGenerator(frame: i),
              ),
            ),
            child: Image(
              image: AssetImage(i.image),
            ),
          ),
        );
      }
    }

    return Expanded(
      child: viewTwo
          ? GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 25,
              crossAxisSpacing: 0,
              crossAxisCount: 2,
              children: frames,
            )
          : GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 25,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children: frames,
            ),
    );
  }
}
