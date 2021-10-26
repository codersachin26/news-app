import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/widgets/news_container.dart';

// bookmark news container widget
class BookmarkNewsView extends StatelessWidget {
  const BookmarkNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NewsApp>(context, listen: false).getBookmarkArticle(),
      builder: (context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) => NewsContainer(
                    article: snapshot.data![index],
                  ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
