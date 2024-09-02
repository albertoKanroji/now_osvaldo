import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xr1/src/controllers/bluetooth/listen.dart';
import 'package:xr1/src/services/auth/utils/location_service.dart';

class HomeController extends GetxController {
  final LocationService locationService = LocationService();
  var locationMessage = 'Obtaining location...'.obs;
  var isLoading = true.obs;
  BluetoothControllerListen bluetoothController =
      Get.put(BluetoothControllerListen());
  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await locationService.getCurrentLocation();
      locationMessage.value =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    } catch (e) {
      locationMessage.value = 'Failed to get location: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
