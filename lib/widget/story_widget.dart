import 'package:flutter/material.dart';

class Story extends StatefulWidget {
  const Story({
    Key? key,
  }) : super(key: key);

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //story 없을 때
        Container(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Image.asset(
            'images/mimi-removebg-preview.png',
            width: 150,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          '인생네컷과 함께한 추억이 아직 없네요 ㅠㅠ',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '여러분의 추억을 위해 우리가 더 노력할게요!',
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        //story 있으면 widget
      ],
    );
  }
}
