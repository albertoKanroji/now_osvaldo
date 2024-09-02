import 'package:get/get.dart';
import 'package:xr1/src/models/clientes_model.dart';
import 'package:xr1/src/models/mi_familia.dart';
import 'package:xr1/src/services/admin/clientes_serivce.dart';

class AdminClientesController extends GetxController {
  var familiaData = <Cliente>[].obs;
  var familiaDataDetalle = [].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final AdminClientesService _familiaService = AdminClientesService();

  Future<void> fetchFamiliaData() async {
    try {
      isLoading(true); // Inicia la carga
      familiaData.value = await _familiaService.obtenerClientes();
    } catch (e) {
      errorMessage.value = 'Ocurrió un error al obtener los datos: $e';
    } finally {
      isLoading(false); // Finaliza la carga
    }
  }

  Future<void> fetchFamiliarData(String id) async {
    try {
      isLoading(true); // Inicia la carga
      final welcome = await _familiaService.obtenerClienteConFamiliares(id);

      // Verifica si 'data' no es nulo y contiene datos
      if (welcome.data != null && welcome.data!.isNotEmpty) {
        // Actualiza la lista de familiaData con la lista de familiares obtenida
        familiaDataDetalle.value = welcome.data!;
      } else {
        // Maneja el caso en el que no se encuentran datos
        familiaDataDetalle.value = [];
      }
    } catch (e) {
      errorMessage.value =
          'Ocurrió un error al obtener los datos del familiar: $e';
    } finally {
      isLoading(false); // Finaliza la carga
    }
  }
}
