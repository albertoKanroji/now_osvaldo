import 'package:get/get.dart';
import 'package:xr1/src/models/mi_familia.dart';
import 'package:xr1/src/services/familia/familiares_service.dart';

class FamiliaController extends GetxController {
  var familiaData = <Datum>[].obs;
  var familiaDataDetalle = <Datum>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final FamiliaService _familiaService = FamiliaService();

  Future<void> fetchFamiliaData() async {
    try {
      isLoading(true); // Inicia la carga
      familiaData.value = await _familiaService.obtenerFamilia();
    } catch (e) {
      errorMessage.value = 'Ocurrió un error al obtener los datos: $e';
    } finally {
      isLoading(false); // Finaliza la carga
    }
  }

  Future<void> fetchFamiliarData(String familiarId) async {
    try {
      isLoading(true); // Inicia la carga
      final Datum familiar = await _familiaService.obtenerFamiliar(familiarId);

      // Actualiza la lista de familiaData con el familiar específico obtenido
      familiaDataDetalle.value = [familiar];
    } catch (e) {
      errorMessage.value =
          'Ocurrió un error al obtener los datos del familiar: $e';
    } finally {
      isLoading(false); // Finaliza la carga
    }
  }
}
