import 'package:flutter/cupertino.dart';
import 'package:snapchat_ui_clone/widgets/story.dart';

import '../data.dart';
import '../models/friend.dart';
import '../style.dart';

class Stories extends StatelessWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Row(
            children: Data.friends.asMap().entries.map((entry) {
              final int index = entry.key;
              final Friend friend = entry.value;
              return Column(
                children: [
                  Story(index: index),
                  Style.friendName(friend.name),
                ],
              );
            }).toList(),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
