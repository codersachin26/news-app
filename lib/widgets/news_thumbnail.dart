import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/data_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        color: Colors.grey.withOpacity(0.3),
        child: widget.article.isBookmark
            ? const Icon(
                Icons.bookmark,
                size: 32,
                color: Colors.deepPurple,
              )
            : const Icon(
                Icons.bookmark_border_rounded,
                size: 32,
              ),
      ),
      onTap: () {
        final model = Provider.of<NewsAppNotifier>(context, listen: false);
        model.bookmarkArticle(widget.article, widget.article.isBookmark);
        widget.article.isBookmark = !widget.article.isBookmark;
        setState(() {});
      },
    );
  }
}
