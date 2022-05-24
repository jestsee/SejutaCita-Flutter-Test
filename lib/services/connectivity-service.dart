import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}