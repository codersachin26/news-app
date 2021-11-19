import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/widgets/error_widget.dart';
import 'package:short_news/widgets/news_container.dart';

// newsAPI news container widget
class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView>
    with AutomaticKeepAliveClientMixin<NewsView> {
  bool hasConnection = false;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();

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

    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NewsAppNotifier>(context, listen: false).getNews(),
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasError) {
            final _error = snapshot.error.toString();
            if (_error.contains('SocketException')) {
              return const Center(child: NoInternetConnectionError());
            } else {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }
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
