import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/services/news_app.dart';

class BottomNavBar extends StatefulWidget {
  final PageController pageController;

  const BottomNavBar({Key? key, required this.pageController})
      : super(key: key);

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
            widget.pageController.jumpToPage(0);
          } else if (index == 1) {
            widget.pageController.jumpToPage(1);
          } else if (index == 2) {
            final model = Provider.of<NewsAppNotifier>(context, listen: false);
            model.signOut();
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              tooltip: 'save',
              icon: Icon(Icons.bookmark_border_sharp),
              label: 'Save'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'SignOut'),
        ]);
  }
}
