import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum ConnectivityStatus { Online, Offline }

class ConnectivityService {
  final StreamController<ConnectivityStatus> _connectionStatusController =
      StreamController<ConnectivityStatus>.broadcast();

  Stream<ConnectivityStatus> get connectivityStream =>
      _connectionStatusController.stream;

  late InternetConnectionChecker _connectionChecker;
  late StreamSubscription<InternetConnectionStatus> _subscription;

  ConnectivityService() {
    _connectionChecker = InternetConnectionChecker();
    _initializeConnectivity();
  }

  void _initializeConnectivity() {
    _subscription = _connectionChecker.onStatusChange.listen((status) {
      _connectionStatusController.add(_getStatusFromResult(status));
    });

    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    bool hasConnection = await _connectionChecker.hasConnection;
    _connectionStatusController.add(
        hasConnection ? ConnectivityStatus.Online : ConnectivityStatus.Offline);
  }

  ConnectivityStatus _getStatusFromResult(InternetConnectionStatus status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        return ConnectivityStatus.Online;
      case InternetConnectionStatus.disconnected:
        return ConnectivityStatus.Offline;
    }
  }

  void dispose() {
    _subscription.cancel();
    _connectionStatusController.close();
  }
}
