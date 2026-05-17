import 'dart:async';

import 'package:flutter/material.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  GoRouterRefreshNotifier(List<Stream<dynamic>> streams) {
    for (final stream in streams) {
      notifyListeners();
      _subscriptions.add(
        stream.asBroadcastStream().listen((_) => notifyListeners()),
      );
    }
  }

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }
}