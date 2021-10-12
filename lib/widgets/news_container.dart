import 'package:flutter/material.dart';
import 'package:short_news/widgets/news_thumbnail.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          NewsThumbnail(),
          NewsContent(),
        ],
      ),
    );
  }
}

class NewsContent extends StatelessWidget {
  const NewsContent({Key? key}) : super(key: key);

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
            ),
            child: const Text(
              'Hack News',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Bug Bounty Radar The latest bug bounty programs for October 2021',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 3,
          ),
          const Text(
            'Apple’s bug bounty program came in for some pretty damning criticism this month, after the Washington Post interviewed two dozen security researchers about their experiences probing its applications for vulnerabilities',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal),
          )
        ],
      ),
    );
  }
}
