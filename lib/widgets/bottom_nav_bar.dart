import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/services/news_app.dart';

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
