import 'package:flutter/material.dart';
import 'package:proyecto_auto/pages/dashboard_page.dart';
import 'package:proyecto_auto/pages/graphs_page.dart';
import 'package:proyecto_auto/pages/infovin.dart';
import 'package:proyecto_auto/pages/login_page.dart';

final Color colorPrimary = Color(0xFF007AFF); // Azul principal
final Color colorSecondary = Color(0xFF1E90FF); // Azul más claro

class HomePage extends StatefulWidget {
  final dynamic user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout() {
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
        title: const Text(
          'Monitoreo OBD',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: colorPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              print("Configuraciones del usuario: \${widget.user}");
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/car.png',
                  height: 190,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 32),
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
                  label: 'Diagnóstico',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoVinPage()),
                    );
                  },
                ),
                _HomeButton(
                  icon: Icons.report,
                  label: 'Diagnóstico',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RealTimeLineChart()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeButton({
    required this.icon,
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorSecondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
