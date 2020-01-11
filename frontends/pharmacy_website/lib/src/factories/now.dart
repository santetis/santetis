typedef NowFactory = DateTime Function();

DateTime defaultNowFactory() => DateTime.now().toUtc().add(Duration(hours: 1));
