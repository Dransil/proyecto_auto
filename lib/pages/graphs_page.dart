import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RealTimeLineChart extends StatefulWidget {
  @override
  _RealTimeLineChartState createState() => _RealTimeLineChartState();
}

class _RealTimeLineChartState extends State<RealTimeLineChart> {
  List<ChartData> chartData = [];
  late Timer _timer;
  int timeCounter = 0;
  final Random _random = Random();
  String selectedChart = 'Voltaje de la batería'; // Opción inicial seleccionada

  @override
  void initState() {
    super.initState();

    // Inicializar con un punto inicial
    chartData = [ChartData(0, 0)];

    // Timer para actualizar los datos cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeCounter++;

        // Generar valores según la métrica seleccionada
        double newValue = _generateDataForSelectedChart();

        chartData.add(ChartData(timeCounter, newValue));

        if (chartData.length > 500) {
          chartData.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Método para generar datos simulados según la métrica seleccionada
  double _generateDataForSelectedChart() {
    switch (selectedChart) {
      case 'Voltaje de la batería':
        return 11.5 + _random.nextDouble() * 2.5; // Rango: 11.5V a 14.0V
      case 'Revoluciones por minuto':
        return 800 + _random.nextDouble() * 6200; // Rango: 800 a 7000 RPM
      case 'Velocidad del vehículo':
        return _random.nextDouble() * 220; // Rango: 0 a 220 km/h
      case 'Posición del acelerador':
        return _random.nextDouble() * 100; // Rango: 0% a 100%
      case 'Temperatura del refrigerante':
        return 70 + _random.nextDouble() * 50; // Rango: 70°C a 120°C
      case 'Temperatura del aire de admisión':
        return 10 + _random.nextDouble() * 40; // Rango: 10°C a 50°C
      case 'Carga del motor':
        return _random.nextDouble() * 100; // Rango: 0% a 100%
      case 'Avance de encendido':
        return -10 + _random.nextDouble() * 40; // Rango: -10° a 30°
      default:
        return 0.0;
    }
  }

  // Método para obtener el rango máximo según la métrica seleccionada
  double _getYAxisMax() {
    switch (selectedChart) {
      case 'Voltaje de la batería':
        return 14.0;
      case 'Revoluciones por minuto':
        return 7000;
      case 'Velocidad del vehículo':
        return 220;
      case 'Posición del acelerador':
        return 100;
      case 'Temperatura del refrigerante':
        return 120;
      case 'Temperatura del aire de admisión':
        return 50;
      case 'Carga del motor':
        return 100;
      case 'Avance de encendido':
        return 30;
      default:
        return 0.0;
    }
  }

  // Método para obtener el rango mínimo según la métrica seleccionada
  double _getYAxisMin() {
    switch (selectedChart) {
      case 'Voltaje de la batería':
        return 11.5;
      case 'Revoluciones por minuto':
        return 800;
      case 'Velocidad del vehículo':
        return 0;
      case 'Posición del acelerador':
        return 0;
      case 'Temperatura del refrigerante':
        return 70;
      case 'Temperatura del aire de admisión':
        return 10;
      case 'Carga del motor':
        return 0;
      case 'Avance de encendido':
        return -10;
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
                'Voltaje de la batería',
                'Revoluciones por minuto',
                'Velocidad del vehículo',
                'Posición del acelerador',
                'Temperatura del refrigerante',
                'Temperatura del aire de admisión',
                'Carga del motor',
                'Avance de encendido',
              ].map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  )).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedChart = newValue!;
                  chartData.clear(); // Reiniciar datos al cambiar métrica
                  timeCounter = 0;
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
                  title: AxisTitle(text: selectedChart),
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
