import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xr1/src/controllers/admin/clientes_controller.dart';
import 'package:xr1/src/views/admin/detalle_cliente_view.dart';
import 'package:xr1/src/views/familia/detalle_familia_view.dart';

class ClientesView extends StatelessWidget {
  final AdminClientesController _controller =
      Get.put(AdminClientesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white, // Color cuando el AppBar está fijado
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Clientes',
                style: TextStyle(color: Colors.black), // Texto en estado pinned
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFB2DFDB), // Verde pastel
                      Color(0xFFC8E6C9), // Verde más claro
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Información de los Clientes',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: Obx(() {
              if (_controller.isLoading.value) {
                return const SliverFillRemaining(
                  child: Center(
                      child: CircularProgressIndicator()), // Indicador de carga
                );
              }

              if (_controller.errorMessage.value.isNotEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      _controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ); // Mensaje de error
              }

              if (_controller.familiaData.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No se encontraron datos de la familia.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ); // Mensaje si no hay datos
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
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
                          Get.to(() => ClienteDetailView(
                              clienteId: familia.id.toString()));
                        },
                      ),
                    );
                  },
                  childCount: _controller.familiaData.length,
                ),
              );
            }),
          ),
        ],
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
