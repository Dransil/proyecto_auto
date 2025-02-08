import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActuadoresPage extends StatefulWidget {
  const ActuadoresPage({Key? key}) : super(key: key);

  @override
  _ActuadoresPageState createState() => _ActuadoresPageState();
}

class _ActuadoresPageState extends State<ActuadoresPage> {
  Map<String, dynamic>? actuadoresData;

  @override
  void initState() {
    super.initState();
    _fetchActuadoresData();
  }

  Future<void> _fetchActuadoresData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('DTC')
          .doc('Actuadores')
          .get();

      if (snapshot.exists) {
        setState(() {
          actuadoresData = snapshot.data() as Map<String, dynamic>;
        });
      }
    } catch (e) {
      print("Error al obtener los datos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 188, 188),
      appBar: AppBar(
        title: const Text(
          'Información de Actuadores',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Color(0xFF007AFF),
      ),
      body: actuadoresData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Datos de Actuadores:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView(
                          children: actuadoresData!.entries.map((entry) {
                            return _infoRow(entry.key, entry.value.toString());
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Alinea los elementos
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.centerRight, // Alinea el texto a la derecha
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign
                    .right, // Asegura que el texto también esté alineado a la derecha
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
