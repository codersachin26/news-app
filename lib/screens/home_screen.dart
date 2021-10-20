import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/screens/notification_screen.dart';
import 'package:short_news/widgets/bottom_nav_bar.dart';
import 'package:short_news/widgets/news_container.dart';
import 'package:short_news/widgets/theme_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NewsApp>(context, listen: false).getTheme(),
      builder: (context, AsyncSnapshot<ThemeData> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: snapshot.data,
            home: HomeView(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isBookmarkPage = false;
  void notifyParent(int index) {
    if (index == 0) {
      setState(() {
        isBookmarkPage = false;
      });
    } else if (index == 1) {
      setState(() {
        isBookmarkPage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Short News"),
        actions: <Widget>[
          const SizedBox(width: 10),
          ThemeIcon(),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              icon: const Icon(
                Icons.notifications,
                size: 28,
              ),
            );
          }),
        ],
      ),
      body: isBookmarkPage ? const BookmarkNewsView() : const NewsView(),
      bottomNavigationBar: BottomNavBar(
        notifyParent: notifyParent,
      ),
    ));
  }
}

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

// newsAPI news container widget
class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NewsApp>(context, listen: false).getNews(),
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) => NewsContainer(
                      article: snapshot.data![index],
                    ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
