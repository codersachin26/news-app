import 'package:flutter/material.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/widgets/news_thumbnail.dart';

class NewsContainer extends StatelessWidget {
  final Article article;
  const NewsContainer({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          NewsThumbnail(article: article),
          NewsContent(
            article: article,
          ),
        ],
      ),
    );
  }
}

class NewsContent extends StatelessWidget {
  final Article article;
  const NewsContent({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .96,
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor),
            child: Text(
              article.source,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).dividerColor),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            article.title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            article.content,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal),
            overflow: TextOverflow.clip,
          )
        ],
      ),
    );
  }
}
