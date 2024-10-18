import 'package:get/get.dart';
import '../../widgets/shared/custom_check_internet.dart';

class ConnectivityController extends GetxController {
  final ConnectivityService _connectivityService = ConnectivityService();
  var connectivityStatus = ConnectivityStatus.Offline.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivityService.connectivityStream.listen((status) {
      connectivityStatus.value = status;
    });
  }

  @override
  void onClose() {
    _connectivityService.dispose();
    super.onClose();
  }
}
