import 'package:flutter/material.dart';
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
        body: Container(
            padding: const EdgeInsets.only(top: 5),
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => NotificationTile(
                      index: index,
                    ))),
      ),
    );
  }
}
