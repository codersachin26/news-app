// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/auth.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/widgets/app_logo.dart';
import 'package:short_news/widgets/bottom_nav_bar.dart';
import 'package:short_news/widgets/news_container.dart';
import 'package:short_news/widgets/news_thumbnail.dart';
import 'package:short_news/widgets/notification_tile.dart';
import 'package:short_news/widgets/sign_in_container.dart';
import 'package:short_news/widgets/theme_icon.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:short_news/widgets/welcome_text.dart';

import 'mock.dart';

void main() {
  group("HomeScreen widgets ->", () {
    testWidgets('ThemeIcon -- changed icon by tapping on IconButton',
        (WidgetTester tester) async {
      const String _key = 'themeMode';
      const String _prefixedKey = 'flutter.' + _key;
      SharedPreferences.setMockInitialValues(
          <String, Object>{_prefixedKey: 'light'});

      final model = NewsAppNotifier(OAuth(), MockPrefs());
      Widget themeIconWidget = ChangeNotifierProvider(
          create: (context) => model,
          child: Consumer<NewsAppNotifier>(
              builder: (context, model, _) =>
                  returnTestableWidget(ThemeIcon())));
      await tester.pumpWidget(themeIconWidget);
      final darkModeIcon = find.byIcon(Icons.dark_mode);
      expect(darkModeIcon, findsOneWidget);
      final iconBtn = find.byType(IconButton);
      await tester.tap(iconBtn);
      await tester.pumpAndSettle();
      final lightModeIcon = find.byIcon(Icons.light_mode);
      expect(lightModeIcon, findsOneWidget);
    });

    testWidgets('AppLogo', (WidgetTester tester) async {
      final testingWidget = returnTestableWidget(const AppLogo());
      await tester.pumpWidget(testingWidget);
      final testWidget = find.text('Short News');
      expect(testWidget, findsOneWidget);
    });

    testWidgets('NewsThumbnail', (WidgetTester tester) async {
      final dummyArticle = Article(
          'id',
          'title',
          'source',
          'content',
          'https://images.macrumors.com/article-new/2021/03/Facebook-Feature.jpg',
          'publshedAt');
      final testingWidget =
          returnTestableWidget(NewsThumbnail(article: dummyArticle));
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(testingWidget);
        final bookmarkBtn = find.byType(BookMarkBtn);

        expect(bookmarkBtn, findsOneWidget);
        expect(find.byIcon(Icons.bookmark_border_rounded), findsOneWidget);

        await tester.tap(bookmarkBtn);
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.bookmark), findsOneWidget);
      });
    });

    testWidgets('NewsContent', (WidgetTester tester) async {
      final dummyArticle = Article(
          'id',
          'title',
          'source',
          'content',
          "https://images.macrumors.com/article-new/2021/03/Facebook-Feature.jpg",
          'publshedAt');
      final testingWidget =
          returnTestableWidget(NewsContent(article: dummyArticle));
      await tester.pumpWidget(testingWidget);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('source'), findsOneWidget);
      expect(find.text('content'), findsOneWidget);
    });

    testWidgets('BottomNavBar', (WidgetTester tester) async {
      final pageController = PageController(initialPage: 0);

      final screens = [Container(), Container()];

      final testingWidget = MaterialApp(
        home: Scaffold(
          body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: screens.length,
            itemBuilder: (context, index) => screens[index],
          ),
          bottomNavigationBar: BottomNavBar(
            pageController: pageController,
          ),
        ),
      );
      await tester.pumpWidget(testingWidget);
      final homeIcon = find.byIcon(Icons.home);

      expect(homeIcon, findsOneWidget);
      expect(pageController.page, equals(0.0));
      expect(pageController.initialPage, equals(0));
      expect(find.byIcon(Icons.bookmark_border_sharp), findsOneWidget);

      await tester.tap(find.byTooltip('save'));
      await tester.pump();

      expect(pageController.page, equals(1.0));
    });
  });

  group("LoginScreen widgets --> ", () {
    testWidgets('WelcomeText', (WidgetTester tester) async {
      final testingWidget = returnTestableWidget(WelcomeText());

      await tester.pumpWidget(testingWidget);

      expect(find.text('Welcome To'), findsOneWidget);
      expect(find.text('Short News'), findsOneWidget);
      expect(((tester.widget(find.text('Short News')) as Text).style)?.color,
          Colors.black);
    });

    testWidgets('GoogleSignInConatiner', (WidgetTester tester) async {
      final testingWidget = returnTestableWidget(GoogleSignInConatiner());

      await tester.pumpWidget(testingWidget);

      expect(find.text('sign in with google'), findsOneWidget);
      expect(find.byType(Container).last, findsOneWidget);
    });
  });

  group("NotificationScreen widgets --> ", () {
    testWidgets('NotificationTile', (WidgetTester tester) async {
      final dummyArticle = Article(
          'id',
          'title',
          'source',
          'content',
          "https://images.macrumors.com/article-new/2021/03/Facebook-Feature.jpg",
          'publshedAt');
      final testingWidget = returnTestableWidget(NotificationTile(
        index: 1,
        article: dummyArticle,
      ));

      mockNetworkImagesFor(() async {
        await tester.pumpWidget(testingWidget);

        expect(find.text('title'), findsOneWidget);
      });
    });
  });
}

Widget returnTestableWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}
