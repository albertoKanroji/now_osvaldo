import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:xr1/src/controllers/auth/auth_controller.dart';
import 'package:xr1/src/controllers/bluetooth/listen.dart';
import 'package:xr1/src/controllers/home/home_controller.dart';

class HomeView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final HomeController controller = Get.put(HomeController());
  final BluetoothControllerListen bluetoothController =
      Get.put(BluetoothControllerListen());

  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                bluetoothController.scanDevices();
              },
              child: const Text('Escanear dispositivos'),
            ),
            Expanded(
              child: Obx(() {
                if (bluetoothController.isConnectedToRedmi9.value) {
                  return GridView.count(
                    crossAxisCount: 1,
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      Card(
                        elevation: 12.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.greenAccent, Colors.green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.bluetooth_connected,
                                  color: Colors.white, size: 40),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'Estás conectado al Redmi 9',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Icon(Icons.check, color: Colors.white, size: 30),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else if (!bluetoothController.isBluetoothOn.value) {
                  return const Center(
                    child: Text(
                      'Por favor, enciende tu Bluetooth para continuar',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (bluetoothController.isScanning) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: bluetoothController.devices.length,
                    itemBuilder: (context, index) {
                      ScanResult device = bluetoothController.devices[index];
                      return Card(
                        elevation: 8.0,
                        margin: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blueAccent, Colors.blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              device.device.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'RSSI: ${device.rssi}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            leading: const Icon(
                              Icons.bluetooth,
                              color: Colors.white,
                              size: 40,
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                bluetoothController
                                    .connectToDevice(device.device);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 5.0,
                              ),
                              child: const Text('Conectar'),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
