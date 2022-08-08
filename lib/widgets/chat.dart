import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapchat_ui_clone/style.dart';

import '../models/friend.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key, required this.friend}) : super(key: key);
  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(width: 15),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(friend.image),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Style.friendName(friend.name),
              Row(
                children: [
                  Friend.statusIconMap[friend.status]!,
                  const SizedBox(width: 7),
                  Style.chatInfo("${Friend.statusTextMap[friend.status]!} • ${friend.time}"),
                ],
              ),
            ],
          ),
          const Spacer(),
          if (friend.streak > 1)
            Style.streakText("${friend.streak.toString()} 🔥"),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
