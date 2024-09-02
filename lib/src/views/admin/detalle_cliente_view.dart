import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xr1/src/controllers/admin/clientes_controller.dart';
import 'package:xr1/src/models/clientes_model.dart';
import 'package:xr1/src/models/mi_familia.dart';

class ClienteDetailView extends StatelessWidget {
  final String clienteId;

  ClienteDetailView({required this.clienteId});

  @override
  Widget build(BuildContext context) {
    // Usa Get.find para obtener el controlador ya existente
    final AdminClientesController controller = Get.find();

    // Asegúrate de que el ID del cliente se pase correctamente
    controller.fetchFamiliarData(clienteId);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('Detalle del Cliente'),
        backgroundColor: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 0.5,
          ),
        ),
        leading: CupertinoNavigationBarBackButton(
          color: Colors.blueAccent,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        if (controller.familiaDataDetalle.value.isEmpty) {
          return const Center(child: Text('No se encontraron familiares.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Familiares:',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.familiaDataDetalle.value.length,
                  itemBuilder: (context, index) {
                    final familiar = controller.familiaDataDetalle.value[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                            '${familiar.nombre} ${familiar.apellido1} ${familiar.apellido2}'),
                        subtitle: Text(familiar.email ?? ''),
                        trailing: Text(familiar.estado ?? ''),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
