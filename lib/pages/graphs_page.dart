import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RealTimeLineChart extends StatefulWidget {
  @override
  _RealTimeLineChartState createState() => _RealTimeLineChartState();
}

class _RealTimeLineChartState extends State<RealTimeLineChart> {
  List<ChartData> chartData = [];
  late DatabaseReference _databaseRef;
  String selectedChart = '/Sensores/Voltaje'; // Opción inicial seleccionada

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.ref();
    _setupDatabaseListener();
  }

  // Método para configurar el listener de Firebase
  void _setupDatabaseListener() {
    _databaseRef.child(selectedChart).onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        final double newValue = double.tryParse(data.toString()) ?? 0.0;
        setState(() {
          chartData.add(ChartData(chartData.length, newValue));
          if (chartData.length > 5000) {
            chartData.removeAt(0); // Limitar el número de puntos en el gráfico
          }
        });
      }
    });
  }

  // Método para obtener el rango máximo según la métrica seleccionada
  double _getYAxisMax() {
    switch (selectedChart) {
      case '/Sensores/Voltaje':
        return 16; // Rango máximo para velocidad del vehículo
      case '/Sensores/RPM':
        return 7000; // Rango máximo para RPM
      case '/Sensores/Carga del motor':
        return 100; // Rango máximo para carga del motor
      case '/Sensores/Consumo instantáneo combustible':
        return 50; // Rango máximo para consumo de combustible
      case '/Sensores/Posición acelerador':
        return 100; // Rango máximo para posición del acelerador
      case '/Sensores/Presión colector admisión':
        return 100; // Rango máximo para presión del colector de admisión
      case '/Sensores/Presión combustible':
        return 100; // Rango máximo para presión de combustible
      case '/Sensores/Sensor MAP':
        return 100; // Rango máximo para sensor MAP
      case '/Sensores/Temperatura aceite':
        return 120; // Rango máximo para temperatura del aceite
      case '/Sensores/Temperatura refrigerante':
        return 120; // Rango máximo para temperatura del refrigerante
      case '/Sensores/Tiempo de encendido':
        return 30; // Rango máximo para tiempo de encendido
      default:
        return 0.0;
    }
  }

  // Método para obtener el rango mínimo según la métrica seleccionada
  double _getYAxisMin() {
    switch (selectedChart) {
      case '/Sensores/Voltaje':
        return 0; // Rango mínimo para velocidad del vehículo
      case '/Sensores/RPM':
        return 0; // Rango mínimo para RPM
      case '/Sensores/Carga del motor':
        return 0; // Rango mínimo para carga del motor
      case '/Sensores/Consumo instantáneo combustible':
        return 0; // Rango mínimo para consumo de combustible
      case '/Sensores/Posición acelerador':
        return 0; // Rango mínimo para posición del acelerador
      case '/Sensores/Presión colector admisión':
        return 0; // Rango mínimo para presión del colector de admisión
      case '/Sensores/Presión combustible':
        return 0; // Rango mínimo para presión de combustible
      case '/Sensores/Sensor MAP':
        return 0; // Rango mínimo para sensor MAP
      case '/Sensores/Temperatura aceite':
        return 0; // Rango mínimo para temperatura del aceite
      case '/Sensores/Temperatura refrigerante':
        return 0; // Rango mínimo para temperatura del refrigerante
      case '/Sensores/Tiempo de encendido':
        return -10; // Rango mínimo para tiempo de encendido
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfica en Tiempo Real'),
      ),
      body: Column(
        children: [
          // Dropdown para seleccionar métrica
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedChart,
              items: <String>[
                '/Sensores/Voltaje',
                '/Sensores/RPM',
                '/Sensores/Carga del motor',
                '/Sensores/Consumo instantáneo combustible',
                '/Sensores/Posición acelerador',
                '/Sensores/Presión colector admisión',
                '/Sensores/Presión combustible',
                '/Sensores/Sensor MAP',
                '/Sensores/Temperatura aceite',
                '/Sensores/Temperatura refrigerante',
                '/Sensores/Tiempo de encendido',
              ].map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.replaceAll('/Sensores/', '')), // Mostrar nombre sin "/Sensores/"
                  )).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedChart = newValue!;
                  chartData.clear(); // Reiniciar datos al cambiar métrica
                  _setupDatabaseListener(); // Configurar listener para la nueva métrica
                });
              },
            ),
          ),
          // Contenedor para la gráfica
          Expanded(
            child: Center(
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  title: AxisTitle(text: 'Tiempo (s)'),
                  autoScrollingMode: AutoScrollingMode.end,
                  autoScrollingDelta: 10,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: selectedChart.replaceAll('/Sensores/', '')),
                  minimum: _getYAxisMin(),
                  maximum: _getYAxisMax(),
                ),
                series: <LineSeries<ChartData, int>>[
                  LineSeries<ChartData, int>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.blue,
                    width: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final int x;
  final double y;

  ChartData(this.x, this.y);
}
// /Sensores/Vel vehículo -
// /Sensores/RPM -
// /Sensores/Carga del motor -
// /Sensores/Consumo instantáneo combustible
// /Sensores/Posición acelerador -
// /Sensores/Presión colector admisión -
// /Sensores/Presión combustible
// /Sensores/Sensor MAP 
// /Sensores/Temperatura aceite
// /Sensores/Temperatura refrigerante -
// /Sensores/Tiempo de encendido -

// '/Sensores/Voltaje',
// '/Sensores/RPM',
// '/Sensores/Vel vehículo',
// '/Sensores/Posición acelerador',
// '/Sensores/Temperatura refrigerante',
// '/Sensores/Presión colector admisión',
// '/Sensores/Carga del motor',
// '/Sensores/Tiempo de encendido',