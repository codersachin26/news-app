import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: FutureBuilder(
          future:
              Provider.of<NewsApp>(context, listen: false).getNotification(),
          builder: (context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              return Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => NotificationTile(
                            index: snapshot.data!.length,
                            article: snapshot.data![index],
                          )));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
