import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
      _handleConnectivityChange(source);
    });
  }

  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        string = 'Mobile: Online';
        break;
      case ConnectivityResult.wifi:
        string = 'WiFi: Online';
        break;
      case ConnectivityResult.none:
      default:
        string = 'Offline';
    }

    return Scaffold(
      body: Center(child: Text(string)),
    );
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  // This method handles what happens when the connectivity changes
  void _handleConnectivityChange(Map source) {
    bool isConnected = source.values.toList()[0];
    if (!isConnected) {
      _showNoInternetSnackBar();
    }
  }

  // Display a SnackBar when there is no internet connection
  void _showNoInternetSnackBar() {
    final snackBar =  const SnackBar(
      content: const Text('No internet connection. Please check your connection.'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
  ConnectivityResult result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
  _checkStatus(result);
  _connectivity.onConnectivityChanged.listen((result) {
    _checkStatus(result as ConnectivityResult);
  });
}

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
