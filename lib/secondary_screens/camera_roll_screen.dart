import 'package:flutter/material.dart';
import 'package:snapchat_ui_clone/widgets/photo_gallery.dart';

import '../style.dart';

class CameraRollScreen extends StatefulWidget {
  const CameraRollScreen(
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
  State<CameraRollScreen> createState() => _CameraRollScreenState();
}

class _CameraRollScreenState extends State<CameraRollScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        const Text('Your Camera Roll isn\'t backed up by Snapchat.',
            style: TextStyle(color: Style.darkGrayText, fontSize: 13)),
        const SizedBox(height: 5),
        Expanded(
          child: PhotoGallery(
              mainPageController: widget.mainPageController,
              mediaList: widget.mediaList,
              handleScrollEvent: widget.handleScrollEvent,
              fetchMedia: widget.fetchMedia),
        ),
      ],
    );
  }
}
