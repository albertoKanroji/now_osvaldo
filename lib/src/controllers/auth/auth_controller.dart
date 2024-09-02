import 'package:get/get.dart';
import 'package:xr1/src/services/auth/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs; // Estado de carga
  final AuthService _authService = Get.find<AuthService>();

  Future<void> login(String email, String password) async {
    isLoading.value = true; // Activar el loader
    try {
      bool success = await _authService.login(email, password);
      if (success) {
        Get.offNamed(
            '/home'); // Redirigir a la pantalla principal en caso de éxito
      } else {
        Get.snackbar('Error', 'Login failed'); // Mostrar mensaje de error
      }
    } catch (error) {
      print('Login error: $error');
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false; // Desactivar el loader
    }
  }

  void logout() {
    _authService.logout(); // Eliminar el token del servicio
    Get.offNamed('/login'); // Redirigir al login después del logout
  }
}
