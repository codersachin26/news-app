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
            home: FutureBuilder(
                future: Provider.of<NewsApp>(context, listen: false).getNews(),
                builder: (context, AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.hasData) {
                    return HomeView(articles: snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class HomeView extends StatefulWidget {
  List<Article> articles = [];
  HomeView({Key? key, required this.articles}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void notifyParent() {
    setState(() {});
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
                        builder: (context) =>
                            NotificationScreen(articles: widget.articles)));
              },
              icon: const Icon(
                Icons.notifications,
                size: 28,
              ),
            );
          }),
        ],
      ),
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.articles.length,
          itemBuilder: (context, index) => NewsContainer(
                article: widget.articles[index],
              )),
      bottomNavigationBar: BottomNavBar(
        notifyParent: notifyParent,
      ),
    ));
  }
}
