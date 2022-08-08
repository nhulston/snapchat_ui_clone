import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapchat_ui_clone/screens/camera_screen.dart';
import 'package:snapchat_ui_clone/screens/chats_screen.dart';
import 'package:snapchat_ui_clone/screens/stories_screen.dart';
import 'package:snapchat_ui_clone/screens/temp_screen.dart';
import 'package:snapchat_ui_clone/style.dart';

late List<CameraDescription> _cameras;

List<CameraDescription> getCameras() {
  return _cameras;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentScreen = 2;
  final PageController _pageController = PageController(initialPage: 2);

  CameraController? _cameraController;

  Future<void> initCamera({required bool frontCamera}) async {
    _cameraController =
        CameraController(_cameras[frontCamera ? 1 : 0], ResolutionPreset.max);
    _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
    _cameraController!.lockCaptureOrientation();
  }

  @override
  void dispose() {
    if (_cameraController != null) {
      _cameraController!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (_cameras.isEmpty) {
      return;
    }
    initCamera(frontCamera: true);
  }

  @override
  Widget build(BuildContext context) {
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
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentScreen = index;
          });
        },
        children: <Widget>[
          TempScreen(color: iconColors[0]),
          const ChatsScreen(),
          CameraScreen(
              cameraController: _cameraController, initCamera: initCamera),
          const StoriesScreen(),
          TempScreen(color: iconColors[4]),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: Platform.isIOS ? 90 : 60,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: iconColors[_currentScreen],
          unselectedItemColor: Style.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Style.black,
          currentIndex: _currentScreen,
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
