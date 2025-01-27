import 'package:flutter/material.dart';
import 'package:proyecto_auto/pages/dashboard_page.dart';
import 'package:proyecto_auto/pages/graphs_page.dart';
import 'package:proyecto_auto/pages/login_page.dart'; // Asegúrate de tener esta página creada

class HomePage extends StatefulWidget {
  final dynamic user; // Recibe el parámetro user

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout() {
    // Aquí puedes agregar lógica adicional para cerrar sesión, como limpiar datos locales o tokens
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner OBD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Aquí puedes manejar configuraciones relacionadas con el usuario
              print("Configuraciones del usuario: \${widget.user}");
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Llama a la función de logout
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Chevrolet-logo.png',
                  height: 150,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Botones principales
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              children: [
                _HomeButton(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpeedometerPage()),
                    );
                  },
                ),
                _HomeButton(
                  icon: Icons.monitor_heart,
                  label: 'Diagnostico',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RealTimeLineChart()),
                    );
                  },
                ),
                _HomeButton(
                  icon: Icons.car_rental,
                  label: 'Información del vehículo',
                  onTap: () {
                    // Puedes pasar el usuario si es necesario
                    print("Información del usuario: \${widget.user}");
                  },
                ),
                _HomeButton(
                  icon: Icons.report,
                  label: 'Reportes',
                  onTap: () {
                    // Lógica para reportes
                    print("Reportes del usuario: \${widget.user}");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  const _HomeButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: iconColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
