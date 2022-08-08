import 'package:flutter/cupertino.dart';
import 'package:snapchat_ui_clone/data.dart';

import 'discover_view.dart';

class DiscoverGrid extends StatelessWidget {
  const DiscoverGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.8,
      children: List.generate(
          Data.discovers.length,
          (index) => DiscoverView(
              index: index,
              title: Data.discovers[index].name,
              description: Data.discovers[index].description)),
    );
  }
}
