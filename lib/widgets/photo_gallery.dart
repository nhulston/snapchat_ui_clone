import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({
    Key? key,
    this.scrollCtr,
    required this.mainPageController,
    required this.mediaList,
    required this.handleScrollEvent,
    required this.fetchMedia,
  }) : super(key: key);

  final ScrollController? scrollCtr;
  final PageController mainPageController;
  final List<Widget> mediaList;
  final void Function(OverscrollNotification) handleScrollEvent;
  final VoidCallback fetchMedia;

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  @override
  void initState() {
    super.initState();
    widget.fetchMedia();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
        onNotification: (OverscrollNotification value) {
          widget.handleScrollEvent(value);
          if (value.metrics.pixels < 10) {
            widget.mainPageController
                .jumpTo(widget.mainPageController.offset + value.overscroll);
          }
          return false;
        },
        child: widget.mediaList.isEmpty
            ? Column(
                children: [
                  const Spacer(),
                  Image.asset('assets/images/camera_roll.png', scale: 2.5),
                  const Spacer(),
                  const Text(
                      'No photos found. Are the\ncorrect permissions set?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      PhotoManager.openSetting();
                    },
                    child: const Text('Open settings',
                        style: TextStyle(fontSize: 16)),
                  ),
                  const Spacer(flex: 2),
                ],
              )
            : GridView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 20),
                controller: widget.scrollCtr,
                itemCount: widget.mediaList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 4, crossAxisSpacing: 4, crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return widget.mediaList[index];
                }));
  }
}
