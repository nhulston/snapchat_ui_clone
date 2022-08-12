import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapchat_ui_clone/secondary_screens/camera_roll_screen.dart';

import '../style.dart';

List<String> tabs = [
  'Snaps',
  'Stories',
  'Camera Roll',
  'My Eyes Only',
];

class MemoriesPage extends StatefulWidget {
  const MemoriesPage(
      {Key? key,
      required this.mainPageController,
      required this.mediaList,
      required this.handleScrollEvent,
      required this.fetchMedia})
      : super(key: key);

  final PageController mainPageController;
  final List<Widget> mediaList;
  final void Function(OverscrollNotification) handleScrollEvent;
  final VoidCallback fetchMedia;

  @override
  State<MemoriesPage> createState() => _MemoriesPageState();
}

class _MemoriesPageState extends State<MemoriesPage> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentScreen = 0;

  static double textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: Style.memoriesStyle()),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  double _underlineWidth = 50;
  final Map<int, double> _widthMap = {
    0: textSize(tabs[0]),
    1: textSize(tabs[1]),
    2: textSize(tabs[2]),
    3: textSize(tabs[3]),
  };

  double _leftPosition = 20;
  Map<int, double>? _positionMap;

  final Map<int, double> _scrollOffset = {
    0: 0,
    1: 0,
    2: 75,
    3: 75,
  };

  VoidCallback updateScreenState(int index, {bool shouldChangePage = true}) {
    assert(index >= 0 && index <= 3);
    return () {
      _leftPosition = _positionMap![index]!;
      _underlineWidth = _widthMap[index]!;
      _scrollController.animateTo(_scrollOffset[index]!,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);

      if (shouldChangePage) {
        int currentPage = _pageController.page!.round();
        if ((currentPage - index).abs() > 1) {
          int diff = (index - currentPage) > 0 ? -1 : 1;
          _pageController.jumpToPage(index + diff);
        }
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      }
      setState(() {
        _currentScreen = index;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    _positionMap ??= {
      0: 20,
      1: 60 + _widthMap[0]!,
      2: 100 + _widthMap[0]! + _widthMap[1]!,
      3: 140 + _widthMap[0]! + _widthMap[1]! + _widthMap[2]!,
    };
    return Scaffold(
      backgroundColor: Style.gray1,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
                height: 140,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              widget.mainPageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            },
                            icon: const Icon(CupertinoIcons.chevron_down,
                                size: 28)),
                        const Spacer(),
                        Style.screenTitle('Memories'),
                        const Spacer(),
                        const Icon(CupertinoIcons.check_mark_circled,
                            size: 28, color: Style.grayText),
                        const SizedBox(width: 20),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Style.gray2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: const [
                                Icon(Icons.search),
                                SizedBox(width: 5),
                                Text('Places, dates, etc.',
                                    style: TextStyle(
                                        color: Style.grayText,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 25,
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Style.memoriesSection(tabs[0], 0,
                                      _currentScreen, updateScreenState(0)),
                                  const SizedBox(width: 40),
                                  Style.memoriesSection(tabs[1], 1,
                                      _currentScreen, updateScreenState(1)),
                                  const SizedBox(width: 40),
                                  Style.memoriesSection(tabs[2], 2,
                                      _currentScreen, updateScreenState(2)),
                                  const SizedBox(width: 40),
                                  Style.memoriesSection(tabs[3], 3,
                                      _currentScreen, updateScreenState(3)),
                                  const SizedBox(width: 20),
                                ],
                              ),
                              AnimatedPositioned(
                                left: _leftPosition,
                                top: 20,
                                duration: const Duration(milliseconds: 200),
                                child: AnimatedContainer(
                                  width: _underlineWidth,
                                  height: 3,
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: Style.blackText,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                )),
            Expanded(
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int index) =>
                    updateScreenState(index, shouldChangePage: false)(),
                children: <Widget>[
                  Container(color: Colors.blue),
                  Container(color: Colors.red),
                  CameraRollScreen(
                      mainPageController: widget.mainPageController,
                      mediaList: widget.mediaList,
                      handleScrollEvent: widget.handleScrollEvent,
                      fetchMedia: widget.fetchMedia),
                  Container(color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
