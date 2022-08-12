import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../primary_screens//camera_screen.dart';
import '../primary_screens/chats_screen.dart';
import '../primary_screens/stories_screen.dart';
import '../primary_screens/temp_screen.dart';
import '../style.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage(
      {Key? key, required this.cameraController, required this.initCamera, required this.callback})
      : super(key: key);

  final CameraController? cameraController;
  final Future<void> Function({required bool frontCamera}) initCamera;
  final void Function(int) callback;

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  int _currentScreen = 2;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 2);

    final iconColors = [
      Style.greenNavbar,
      Style.blueNavbar,
      Style.yellowNavbar,
      Style.purpleNavbar,
      Style.redNavbar,
    ];

    return Scaffold(
      backgroundColor: Style.black,
      body: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int index) {
          widget.callback(index);
          setState(() {
            _currentScreen = index;
          });
        },
        children: <Widget>[
          TempScreen(color: iconColors[0]),
          const ChatsScreen(),
          CameraScreen(
              cameraController: widget.cameraController,
              initCamera: widget.initCamera),
          const StoriesScreen(),
          TempScreen(color: iconColors[4]),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: Platform.isIOS ? 90 : 60,
        child: BottomNavigationBar(
          currentIndex: _currentScreen,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: iconColors[_currentScreen],
          unselectedItemColor: Style.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Style.black,
          onTap: (int index) {
            _pageController.jumpToPage(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.location),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.camera),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.play),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
