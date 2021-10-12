import 'package:flutter/material.dart';

class NewsThumbnail extends StatelessWidget {
  const NewsThumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .40,
        child: Image.asset(
          'news_img.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
