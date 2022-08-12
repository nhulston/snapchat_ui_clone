import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapchat_ui_clone/pages/memories_page.dart';
import 'package:snapchat_ui_clone/pages/primary_page.dart';
import 'package:snapchat_ui_clone/style.dart';
import 'package:snapchat_ui_clone/widgets/custom_scroll_behavior.dart';

late List<CameraDescription> _cameras;

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
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: child!,
        );
      },
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
  final PageController _pageController = PageController(initialPage: 1);
  CameraController? _cameraController;
  int _mainPageIndex = 2;

  void _onMainPageChanged(int index) {
    setState(() {
      _mainPageIndex = index;
    });
  }

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
    _fetchNewMedia();
  }

  final List<Widget> _mediaList = [];
  int currentPage = 0;
  int? lastPage;

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      // success
      //load the album list
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media = await albums[0]
          .getAssetListPaged(size: 60, page: currentPage); //preloading files
      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(const ThumbnailSize(400, 400)),
            //resolution of thumbnail
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (asset.type == AssetType.video)
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(formatDuration(asset.videoDuration),
                              style: const TextStyle(color: Style.whiteText)),
                        ),
                      )
                  ],
                );
              }
              return Container();
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.black,
      body: PageView(
        physics: _mainPageIndex == 2
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (int index) {
          if (index == 0) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
          } else {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          }
        },
        children: [
          PrimaryPage(
              cameraController: _cameraController,
              initCamera: initCamera,
              callback: _onMainPageChanged),
          MemoriesPage(
              mainPageController: _pageController,
              mediaList: _mediaList,
              handleScrollEvent: _handleScrollEvent,
              fetchMedia: _fetchNewMedia),
        ],
      ),
    );
  }

  static String formatDuration(Duration d) {
    int hours = d.inHours;
    int minutes = d.inMinutes - hours * 60;
    int seconds = d.inSeconds - minutes * 60 - hours * 3600;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }
}
