import 'package:get/get.dart';
import 'package:xr1/main.dart';
import 'package:xr1/src/services/auth/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService =
      Get.find<AuthService>(); // Usar Get.find() en lugar de Get.put()
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      bool success = await authService.login(email, password);
      if (success) {
        Get.offAll(() => HomeScreen()); // Navegar a la pantalla principal
      } else {
        Get.snackbar('Error', 'Login fallido, verifica tus credenciales');
      }
    } catch (error) {
      print('Login error: $error');
      Get.snackbar('Error', 'Ocurrió un error inesperado');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginAdmin(String email, String password) async {
    isLoading.value = true;
    try {
      bool success = await authService.loginAdmin(email, password);
      if (success) {
        Get.offAll(() => HomeScreen()); // Navegar a la pantalla principal
      } else {
        Get.snackbar('Error', 'Login fallido, verifica tus credenciales');
      }
    } catch (error) {
      print('Login error: $error');
      Get.snackbar('Error', 'Ocurrió un error inesperado');
    } finally {
      isLoading.value = false;
    }
  }
}
