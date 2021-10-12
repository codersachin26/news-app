import 'package:flutter/material.dart';

class NewsThumbnail extends StatelessWidget {
  const NewsThumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .40,
          child: Image.asset(
            'news_img.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          color: Colors.grey.withOpacity(0.3),
          child: const Icon(
            Icons.bookmark_border_sharp,
            size: 32,
          ),
        ),
      ],
    );
  }
}
