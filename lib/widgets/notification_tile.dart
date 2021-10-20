import 'package:flutter/material.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/widgets/news_container.dart';

class NotificationTile extends StatelessWidget {
  final int index;
  final Article article;
  const NotificationTile({Key? key, required this.index, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationView(
                      index: index,
                      article: article,
                    )));
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
                    child: Image.network(article.imgURL),
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  flex: 2,
                  child: Text(article.title),
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
  final Article article;
  final int index;
  const NotificationView({Key? key, required this.index, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: Hero(
          tag: 'notification$index',
          child: Material(
            child: NewsContainer(
              article: article,
            ),
          ),
        ),
      ),
    );
  }
}
