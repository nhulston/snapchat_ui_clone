import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';
import 'custom_icon.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key, required this.isCameraPage, required this.text})
      : super(key: key);
  final bool isCameraPage;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color color =
        isCameraPage ? Style.cameraPageIconColor : Style.otherPageIconColor;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 40,
          left: 10,
          child: CustomIcon(
            child: Image.asset('assets/images/bitmojis/1.png'),
            isCameraPage: isCameraPage,
          ),
        ),
        Positioned(
          top: 40,
          left: 65,
          child: CustomIcon(
            child: Icon(Icons.search, color: color, size: 30),
            isCameraPage: isCameraPage,
          ),
        ),
        Positioned(
          top: 40,
          right: 67,
          child: CustomIcon(
            child: Icon(Icons.person_add, color: color, size: 28),
            isCameraPage: isCameraPage,
          ),
        ),
        Positioned(
          top: 40,
          right: 12,
          child: isCameraPage
              ? Container(
                  width: 47,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Style.cameraPageBackground,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Icon(Icons.flip_camera_android, color: color, size: 28),
                      const SizedBox(height: 15),
                      Icon(Icons.flash_off, color: color, size: 28),
                      const SizedBox(height: 15),
                      Icon(CupertinoIcons.moon, color: color, size: 28),
                      const SizedBox(height: 15),
                      Icon(CupertinoIcons.play_rectangle,
                          color: color, size: 28),
                      const SizedBox(height: 15),
                      Icon(CupertinoIcons.music_note_2, color: color, size: 28),
                      const SizedBox(height: 11),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white.withOpacity(0.4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.add, color: color),
                        ),
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                )
              : CustomIcon(
                  child: Icon(Icons.more_horiz, color: color, size: 28),
                  isCameraPage: isCameraPage,
                ),
        ),
        if (text.isNotEmpty)
          Positioned(
            top: 50,
            child: Style.screenTitle(text),
          )
      ],
    );
  }
}
