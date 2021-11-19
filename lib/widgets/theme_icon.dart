import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/services/news_app.dart';

class ThemeIcon extends StatelessWidget {
  ThemeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NewsAppNotifier>(context, listen: false);
    if (ThemeMode.dark != model.currentThemeMode) {
      return IconButton(
          onPressed: () {
            model.setTheme(ThemeMode.dark);
          },
          icon: const Icon(Icons.dark_mode));
    } else {
      return IconButton(
          onPressed: () {
            model.setTheme(ThemeMode.light);
          },
          icon: const Icon(Icons.light_mode));
    }
  }
}
