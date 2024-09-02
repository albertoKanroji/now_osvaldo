import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xr1/src/controllers/auth/auth_controller.dart';

class CuentaView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  CuentaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Center(child: Text('Vista de Código')),
    );
  }
}
