import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/news_app.dart';
import 'package:short_news/screens/notification_screen.dart';
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
          return HomeView(
            themeData: snapshot.data!,
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}

class HomeView extends StatefulWidget {
  final ThemeData themeData;
  const HomeView({Key? key, required this.themeData}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void notifyParent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: widget.themeData,
      home: SafeArea(
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
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, idx) => const NewsContainer()),
        bottomNavigationBar: BottomNavBar(
          notifyParent: notifyParent,
        ),
      )),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  VoidCallback notifyParent;
  BottomNavBar({Key? key, required this.notifyParent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            notifyParent();
          } else if (index == 1) {
            notifyParent();
          } else if (index == 2) {
            final model = Provider.of<NewsApp>(context, listen: false);
            model.signOut();
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_sharp), label: 'Save'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'SignOut'),
        ]);
  }
}
