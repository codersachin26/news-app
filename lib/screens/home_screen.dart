import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/internet_connectivity.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/screens/notification_screen.dart';
import 'package:short_news/widgets/app_logo.dart';
import 'package:short_news/widgets/bottom_nav_bar.dart';
import 'package:short_news/widgets/error_widget.dart';
import 'package:short_news/widgets/news_container.dart';
import 'package:short_news/widgets/theme_icon.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotificationScreen()));
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  List<Widget> screens = const <Widget>[
    NewsView(),
    BookmarkNewsView(),
  ];
  StreamSubscription? subscription;
  bool hasConnection = false;

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        if (hasConnection == false) {
          setState(() {});
        }
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    pageController.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
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
      body: FutureBuilder<bool>(
        future: hasInternetConnection(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: screens.length,
                itemBuilder: (context, index) => screens[index],
              );
            } else {
              return const NoInternetConnectionError();
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        pageController: pageController,
      ),
    ));
  }
}

// bookmark news container widget
class BookmarkNewsView extends StatefulWidget {
  const BookmarkNewsView({Key? key}) : super(key: key);

  @override
  State<BookmarkNewsView> createState() => _BookmarkNewsViewState();
}

class _BookmarkNewsViewState extends State<BookmarkNewsView>
    with AutomaticKeepAliveClientMixin<BookmarkNewsView> {
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

  @override
  bool get wantKeepAlive => true;
}

// newsAPI news container widget
class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView>
    with AutomaticKeepAliveClientMixin<NewsView> {
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

  @override
  bool get wantKeepAlive => true;
}
