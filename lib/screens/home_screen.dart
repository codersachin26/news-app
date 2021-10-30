import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/screens/notification_screen.dart';
import 'package:short_news/services/notification_handler.dart';
import 'package:short_news/widgets/app_logo.dart';
import 'package:short_news/widgets/bookmark_pageview.dart';
import 'package:short_news/widgets/bottom_nav_bar.dart';
import 'package:short_news/widgets/news_pageview.dart';
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
  void onSelectNotification(String? data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NotificationScreen()));
  }

  void initializeNotification() async {
    var androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initSetttings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  void _handleMessage(RemoteMessage message) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NotificationScreen()));
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

  @override
  void initState() {
    super.initState();

    setupInteractedMessage();
    initializeNotification();
  }

  @override
  dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
        actions: <Widget>[
          const SizedBox(width: 8),
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
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: screens.length,
        itemBuilder: (context, index) => screens[index],
      ),
      bottomNavigationBar: BottomNavBar(
        pageController: pageController,
      ),
    ));
  }
}
