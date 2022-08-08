import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class Friend {
  Friend(this.image, this.name, this.status, this.time, this.streak);

  final String image;
  final String name;
  final int status; // 0 = new image, 1 = new video, 2 = new message,
  // 3 = received image, 4 = received video, 5 = received message,
  // 6 = sent unopened image, 7 = sent unopened video, 8 = sent unopened message
  // 9 = sent opened image, 10 = sent opened video, 11 = sent opened message
  // 12 = call ended, 13 = call started, 14 = call missed
  final String time;
  final int streak;

  static final Map<int, String> statusTextMap = {
    0: 'New Snap',
    1: 'New Snap',
    2: 'New Chat',
    3: 'Received',
    4: 'Received',
    5: 'Received',
    6: 'Delivered',
    7: 'Delivered',
    8: 'Delivered',
    9: 'Opened',
    10: 'Opened',
    11: 'Opened',
    12: 'Call Ended',
    13: 'Calling',
    14: 'Call Missed',
  };

  static final Map<int, Icon> statusIconMap = {
    0: const Icon(CupertinoIcons.square_fill, color: Style.imageColor, size: 15),
    1: const Icon(CupertinoIcons.square_fill, color: Style.videoColor, size: 15),
    2: const Icon(Icons.chat_bubble, color: Style.chatColor, size: 15),
    3: const Icon(CupertinoIcons.square, color: Style.imageColor, size: 15),
    4: const Icon(CupertinoIcons.square, color: Style.videoColor, size: 15),
    5: const Icon(Icons.chat_bubble_outline, color: Style.chatColor, size: 15),
    6: const Icon(Icons.send_rounded, color: Style.imageColor, size: 15),
    7: const Icon(Icons.send_rounded, color: Style.videoColor, size: 15),
    8: const Icon(Icons.send_rounded, color: Style.chatColor, size: 15),
    9: const Icon(Icons.send_outlined, color: Style.imageColor, size: 15),
    10: const Icon(Icons.send_outlined, color: Style.videoColor, size: 15),
    11: const Icon(Icons.send_outlined, color: Style.chatColor, size: 15),
    12: const Icon(Icons.call_end_rounded, color: Style.chatColor, size: 15),
    13: const Icon(Icons.call, color: Style.chatColor, size: 15),
    14: const Icon(Icons.call_missed, color: Style.chatColor, size: 15),
  };
}