import 'package:provider/provider.dart';

class BaseUrl {
  final String baseUrl;

  BaseUrl(this.baseUrl);
}

final baseUrl = (String base) => Provider(
      create: (context) => BaseUrl(base),
    );
