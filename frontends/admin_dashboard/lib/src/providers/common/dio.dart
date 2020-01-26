import 'package:admin_dashboard/src/providers/common/base_url.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

final dio = ProxyProvider<BaseUrl, Dio>(
  update: (context, baseUrl, previousValue) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl.baseUrl,
      ),
    );
  },
);
