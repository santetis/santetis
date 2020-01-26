import 'package:admin_dashboard/src/app.dart';
import 'package:admin_dashboard/src/providers/app_providers.dart';
import 'package:admin_dashboard/src/providers/staging_providers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    AppProviders(
      providers: stagingProviders,
      child: AdminDashboard(),
    ),
  );
}
