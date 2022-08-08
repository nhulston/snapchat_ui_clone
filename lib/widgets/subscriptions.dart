import 'package:flutter/cupertino.dart';
import 'package:snapchat_ui_clone/widgets/subscription.dart';

import '../data.dart';
import '../models/article.dart';

class Subscriptions extends StatelessWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Row(
            children: Data.subscriptions.asMap().entries.map((entry) {
              final int index = entry.key;
              final Article subscription = entry.value;
              return Subscription(
                  index: index,
                  title: subscription.name,
                  description: subscription.description);
            }).toList(),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
