import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/news_api.dart';
import 'package:short_news/services/news_app.dart';

class NewsThumbnail extends StatelessWidget {
  final Article article;
  const NewsThumbnail({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .40,
          child: Image.network(
            article.imgURL,
            fit: BoxFit.cover,
          ),
        ),
        BookMarkBtn(
          article: article,
        ),
      ],
    );
  }
}

class BookMarkBtn extends StatefulWidget {
  final Article article;
  const BookMarkBtn({Key? key, required this.article}) : super(key: key);

  @override
  State<BookMarkBtn> createState() => _BookMarkBtnState();
}

class _BookMarkBtnState extends State<BookMarkBtn> {
  bool isBookmark = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        color: Colors.grey.withOpacity(0.3),
        child: const Icon(
          Icons.bookmark_border_sharp,
          size: 32,
        ),
      ),
      onTap: () {
        final model = Provider.of<NewsApp>(context, listen: false);
        model.bookmarkArticle(widget.article, isBookmark);
        setState(() {
          isBookmark = !isBookmark;
        });
      },
    );
  }
}
