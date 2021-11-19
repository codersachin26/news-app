import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/enum.dart';
import 'package:short_news/services/news_app.dart';

class GoogleSignInConatiner extends StatelessWidget {
  const GoogleSignInConatiner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * .55,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Image.asset('google-icon.png'),
              ),
              const Text(
                'sign in with google',
              )
            ],
          ),
        ),
        onTap: () {
          final model = Provider.of<NewsAppNotifier>(context, listen: false);
          model.signInWith(OAuthType.google);
        },
      ),
    );
  }
}
