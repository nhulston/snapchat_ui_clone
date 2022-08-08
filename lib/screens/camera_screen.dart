import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snapchat_ui_clone/style.dart';
import 'package:snapchat_ui_clone/widgets/custom_icon.dart';
import 'package:snapchat_ui_clone/widgets/top_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen(
      {Key? key, required this.cameraController, required this.initCamera})
      : super(key: key);
  final CameraController? cameraController;
  final Future<void> Function({required bool frontCamera}) initCamera;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isFront = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () async {
          if (widget.cameraController != null) {
            _isFront = !_isFront;
            setState(() {
              widget.initCamera(frontCamera: _isFront);
            });
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.cameraController == null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.blue, // TODO change to black
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )
                : Builder(builder: (BuildContext builder) {
                    var camera = widget.cameraController!.value;
                    final fullSize = MediaQuery.of(context).size;
                    final size = Size(fullSize.width,
                        fullSize.height - (Platform.isIOS ? 90 : 60));
                    double scale;
                    try {
                      scale = size.aspectRatio * camera.aspectRatio;
                    } catch (e) {
                      scale = 1.0;
                    }
                    if (scale < 1) scale = 1 / scale;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Transform.scale(
                          scale: scale,
                          child: Center(
                            child: LimitedBox(
                              maxWidth: size.width,
                              child: CameraPreview(widget.cameraController!),
                            ),
                          )),
                    );
                  }),
            const TopBar(isCameraPage: true, text: ''),
            Positioned(
              bottom: 15,
              child: Row(
                children: [
                  const CustomIcon(
                    child: Icon(Icons.photo_library_outlined,
                        color: Style.white, size: 26),
                    isCameraPage: true,
                  ),
                  const SizedBox(width: 18),
                  Image.asset('assets/images/camera_button.png', scale: 4.3),
                  const SizedBox(width: 18),
                  const CustomIcon(
                    child: Icon(Icons.tag_faces, color: Style.white, size: 28),
                    isCameraPage: true,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
