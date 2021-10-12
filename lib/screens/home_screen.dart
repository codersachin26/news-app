import 'package:flutter/material.dart';
import 'package:short_news/widgets/news_container.dart';
import 'package:short_news/widgets/theme_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Short News"),
        actions: <Widget>[
          const SizedBox(width: 10),
          ThemeIcon(),
          const Icon(
            Icons.notifications,
            size: 28,
          ),
        ],
      ),
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, idx) => const NewsContainer()),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            print(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.collections), label: 'Save'),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'SignOut'),
          ]),
    ));
  }
}
