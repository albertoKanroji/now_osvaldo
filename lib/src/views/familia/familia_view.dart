import 'package:flutter/material.dart';
import 'package:xr1/src/views/familia/mi_familia_view.dart';
import 'codigo_view.dart'; // Asegúrate de importar la vista correspondiente

class FamiliaView extends StatelessWidget {
  const FamiliaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mi Familia')),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Código'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CodigoView()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.family_restroom),
            title: Text('Familia'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FamiliaDetailsView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
