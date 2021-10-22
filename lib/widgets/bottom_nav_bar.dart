import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/services/news_app.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) notifyParent;

  BottomNavBar({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 0) {
            widget.notifyParent(index);
          } else if (index == 1) {
            widget.notifyParent(index);
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