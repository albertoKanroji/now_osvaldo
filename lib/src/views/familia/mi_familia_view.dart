import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xr1/src/controllers/familia/familia_controller.dart';
import 'package:xr1/src/views/familia/detalle_familia_view.dart';

class FamiliaDetailsView extends StatelessWidget {
  final FamiliaController _controller = Get.put(FamiliaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('Detalle del Familiar'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator()); // Indicador de carga
          }

          if (_controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(
                _controller.errorMessage.value,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ); // Mensaje de error
          }

          if (_controller.familiaData.isEmpty) {
            return const Center(
              child: Text(
                'No se encontraron datos de la familia.',
                style: TextStyle(fontSize: 18),
              ),
            ); // Mensaje si no hay datos
          }

          return ListView.builder(
            itemCount: _controller.familiaData.length,
            itemBuilder: (context, index) {
              final familia = _controller.familiaData[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset:
                          const Offset(0, 3), // Cambia la posición de la sombra
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      familia.nombre[0], // Primera letra del nombre
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    '${familia.nombre} ${familia.apellido1} ${familia.apellido2}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    familia.email,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: familia.estado == 'activo'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      familia.estado,
                      style: TextStyle(
                        color: familia.estado == 'activo'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(() => FamiliarDetailView(familiar: familia));
                  },
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí puedes llamar al método fetchFamiliaData con un ID
          _controller.fetchFamiliaData(); // Reemplaza '123' con el ID deseado
        },
        tooltip: 'Actualizar Datos',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
