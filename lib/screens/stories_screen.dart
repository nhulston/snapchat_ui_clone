import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapchat_ui_clone/widgets/stories.dart';
import 'package:snapchat_ui_clone/widgets/top_bar.dart';
import '../style.dart';
import '../widgets/discover_grid.dart';
import '../widgets/subscriptions.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const TopBar(isCameraPage: false, text: 'Stories'),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height - 100 - (Platform.isIOS ? 90 : 60),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Style.sectionTitle('Friends'),
                  const Stories(),
                  const SizedBox(height: 20),
                  Style.sectionTitle('Subscriptions'),
                  const Subscriptions(),
                  const SizedBox(height: 20),
                  Style.sectionTitle('Discover'),
                  const DiscoverGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
