import 'package:flutter/material.dart';

class NoInternetConnectionError extends StatelessWidget {
  const NoInternetConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.signal_wifi_connected_no_internet_4_rounded,
              size: 30,
              color: Colors.grey,
            ),
            SizedBox(
              width: 2,
            ),
            Text('No Internet Connection :( ')
          ],
        ),
      ),
    );
  }
}
