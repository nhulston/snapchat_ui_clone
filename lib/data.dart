import 'package:snapchat_ui_clone/models/article.dart';

import 'models/friend.dart';

class Data {
  static List<Friend> friends = [
    Friend('assets/images/bitmojis/2.png', 'Tom', 0, '2m', 178),
    Friend('assets/images/bitmojis/3.png', 'Lily', 1, '7m', 0),
    Friend('assets/images/bitmojis/4.png', 'Cat', 1, '21m', 134),
    Friend('assets/images/bitmojis/5.png', 'Tasha', 9, '1h', 0),
    Friend('assets/images/bitmojis/6.png', 'Paige', 4, '1h', 0),
    Friend('assets/images/bitmojis/1.png', 'Bill', 4, '1h', 95),
    Friend('assets/images/bitmojis/2.png', 'Mac', 12, '1h', 0),
    Friend('assets/images/bitmojis/4.png', 'Taylor', 3, '2h', 83),
    Friend('assets/images/bitmojis/5.png', 'Cassidy', 3, '5h', 0),
    Friend('assets/images/bitmojis/6.png', 'Millie', 14, '6h', 0),
    Friend('assets/images/bitmojis/2.png', 'Nick', 0, '2m', 178),
    Friend('assets/images/bitmojis/3.png', 'Addie', 1, '7m', 0),
    Friend('assets/images/bitmojis/4.png', 'Katy', 1, '21m', 134),
    Friend('assets/images/bitmojis/5.png', 'Julia', 9, '1h', 0),
  ];

  static List<Article> subscriptions = [
    Article(
        name: 'The Washington Post',
        description:
            'Opinion | What\'s up with Amnesty International and its moral myopia on Ukraine?'),
    Article(
      name: 'The Telegraph',
      description: 'Teens might have to study maths and English after GCSE.',
    ),
    Article(
      name: 'LAD BIBLE',
      description: 'Fans Angry With Kim K Over Sus Body Scan 👀',
    ),
    Article(
      name: 'staytuned',
      description: 'A virtual Sunday service',
    ),
    Article(
      name: 'WORLD STAR',
      description: 'Kanye West Trolls "Skete" After Break Up With Kim!',
    ),
  ];

  static List<Article> discovers = [
    Article(
      name: 'EUROPE ON AMERICA',
      description: 'European Girls Think American Boys Are...',
    ),
    Article(
      name: 'cbcnews',
      description: 'The boat started taking on water when it jumped in',
    ),
    Article(
      name: 'INSIDER',
      description: 'Frank Ocean has released a \$25,000...',
    ),
    Article(
      name: 'Refresh',
      description: 'Dana White tells us the real reason why Jake pulled out!',
    ),
    Article(
      name: 'WSJ',
      description: 'Data Show Gender Pay Gap Opens Early',
    ),
    Article(
      name: 'WORLDNEWS',
      description: 'China Could Crush Russia, End War In Ukraine',
    ),
    Article(
      name: 'TMZ',
      description: 'FDA Checks On TikTok Viral Pink Sauce',
    ),
    Article(
      name: 'NEWS INSIDER',
      description: 'How Illegal Items Are Destroyed At Airports',
    ),
    Article(
      name: 'ANSWERS',
      description: '"Birds Aren\'t Real"',
    ),
    Article(
      name: 'U N S E E N',
      description: '911 Hangs Up On Girl Missing for 10 Years!',
    ),
  ];
}
