import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapchat_ui_clone/widgets/chat.dart';
import 'package:snapchat_ui_clone/widgets/top_bar.dart';
import '../data.dart';
import '../style.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> friends = Data.friends.map((friend) {
      return Column(
        children: [
          Chat(friend: friend),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: const Divider(
              color: Style.grayText,
              thickness: 0.1,
            ),
          ),
        ],
      );
    }).toList();
    friends.add(Column(
      children: [
        SizedBox(height: Platform.isIOS ? 80 : 50),
      ],
    ));

    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          const TopBar(isCameraPage: false, text: 'Chat'),
          Positioned(
              top: 100,
              height: MediaQuery.of(context).size.height - 100,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: friends,
                ),
              )),
        ],
      ),
    );
  }
}
