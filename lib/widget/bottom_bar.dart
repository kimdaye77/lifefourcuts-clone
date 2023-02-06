import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: TabBar(
        labelColor: Theme.of(context).focusColor,
        unselectedLabelColor: Theme.of(context).primaryColorLight,
        indicatorColor: Colors.transparent,
        tabs: const [
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.grid_view_rounded),
          ),
          SizedBox(),
          Tab(
            icon: Icon(Icons.search),
          ),
          Tab(
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
