import 'package:flutter/material.dart';
import 'package:short_news/widgets/news_container.dart';

class NotificationTile extends StatelessWidget {
  final int index;
  const NotificationTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationView(index: index)));
      },
      child: Hero(
        tag: 'notification$index',
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset('news_img.jpg'),
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                      'Bug Bounty Radar The latest bug bounty programs for October 2021'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationView extends StatelessWidget {
  final int index;
  const NotificationView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: Hero(
          tag: 'notification$index',
          child: NewsContainer(),
        ),
      ),
    );
  }
}
