import 'dart:io';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<bool> hasInternetConnection() async {
  bool hasConnection = false;
  try {
    final result = await InternetAddress.lookup('example.com');
    hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    hasConnection = false;
  }
  return hasConnection;
}
