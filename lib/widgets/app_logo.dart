import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * .1,
          height: MediaQuery.of(context).size.width * .1,
          child: Image.asset('assets/app_icon.png'),
        ),
        const Text('Short News')
      ],
    );
  }
}
