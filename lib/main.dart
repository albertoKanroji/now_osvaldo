import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xr1/src/controllers/auth/auth_controller.dart';
import 'package:xr1/src/services/auth/auth_service.dart';
import 'package:xr1/src/views/admin/clientes_view.dart';
import 'package:xr1/src/views/auth/login_view.dart';
import 'package:xr1/src/views/datos/datos_view.dart';
import 'package:xr1/src/views/familia/familia_view.dart';
import 'package:xr1/src/views/historial/historial_view.dart';
import 'package:xr1/src/views/home/home_view.dart';
import 'package:xr1/src/views/tabs/cuenta_view.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(AuthService());
  Get.put(AuthController());
  final GetStorage _storage = GetStorage();
  final token = _storage.read('access_token');

  final initialRoute = token != null && token.isNotEmpty ? '/home' : '/login';
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Login',
      home: HomeScreen(),
      // initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? _role;

  final List<Widget> _adminViews = [
    ClientesView(),
    CuentaView(key: UniqueKey())
  ];

  final List<Widget> _userViews = [
    HomeView(key: UniqueKey()),
    HistorialView(key: UniqueKey()),
    MistadosView(key: UniqueKey()),
    FamiliaView(key: UniqueKey()),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserRole(); // Cargar el rol al iniciar
  }

  void _loadUserRole() async {
    final role = await GetStorage().read('role');
    setState(() {
      _role = role;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = _role == 'admin';
    final views = isAdmin ? _adminViews : _userViews;

    return Scaffold(
      body: views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: isAdmin
            ? const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle_sharp),
                  label: 'Titulares',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle_sharp),
                  label: 'Cuenta',
                ),
              ]
            : const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Historial',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Datos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.family_restroom),
                  label: 'Familia',
                ),
              ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
