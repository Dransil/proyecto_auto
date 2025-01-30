import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedometerPage extends StatefulWidget {
  const SpeedometerPage({super.key});

  @override
  State<SpeedometerPage> createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  final ValueNotifier<double> _notifier = ValueNotifier(0.0);
  late final Ticker _ticker;
  bool isAccelerating = false;
  String selectedMetric = "Velocidad"; // Métrica inicial seleccionada

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(updateSpeed);
    _ticker.start();
  }

  void updateSpeed(Duration elapsed) {
    setState(() {
      if (isAccelerating) {
        // gradual accelerating
        _notifier.value = (_notifier.value + elapsed.inMilliseconds * 0.00003)
            .clamp(0.0, 240);
      } else {
        // gradual declerating
        _notifier.value = (_notifier.value - elapsed.inMilliseconds * 0.00001)
            .clamp(0.0, 240);
      }
    });
  }

  void startAcceleration() {
    setState(() {
      isAccelerating = true;
    });
  }

  void startDecleration() {
    setState(() {
      isAccelerating = false;
    });
  }

  void applyBreak() {
    setState(() {
      isAccelerating = false;
      // smooth braking
      _notifier.value = (_notifier.value - 20).clamp(0.0, 240);
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _notifier.dispose();
    super.dispose();
  }

  Widget buildGauge() {
    switch (selectedMetric) {
      case 'RPM':
        return buildRpmGauge();
      case 'Combustible':
        return buildCombustibleGauge();
      case 'Temperatura':
        return buildTemperaturaGauge();
      case 'Bateria':
        return buildBateriaGauge();
      default:
        return buildSpeedGauge();
    }
  }

  Widget buildSpeedGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _notifier,
      builder: (context, velocidad, child) {
        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 0,
              maximum: 240,
              radiusFactor: 0.9,
              majorTickStyle: const MajorTickStyle(
                length: 12,
                thickness: 2,
                color: Colors.black,
              ),
              minorTicksPerInterval: 4,
              minorTickStyle: const MinorTickStyle(
                length: 6,
                thickness: 1,
                color: Colors.grey,
              ),
              axisLineStyle: const AxisLineStyle(
                thickness: 15,
                gradient: SweepGradient(
                  colors: [
                    Colors.green,
                    Colors.yellow,
                    Colors.orange,
                    Colors.red,
                  ],
                  stops: [0.25, 0.5, 0.75, 1],
                ),
              ),
              axisLabelStyle: const GaugeTextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: velocidad,
                  enableAnimation: true,
                  animationType: AnimationType.easeOutBack,
                  needleColor: Colors.red,
                  needleStartWidth: 1,
                  needleEndWidth: 5,
                  needleLength: 0.75,
                  animationDuration: 2000,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.red,
                    ],
                  ),
                  knobStyle: KnobStyle(
                    color: Colors.transparent,
                    borderColor: Colors.blue.withAlpha(100),
                    borderWidth: 1,
                  ),
                ),
              ],
              ranges: [
                GaugeRange(
                  startValue: 0,
                  endValue: 30,
                  color: Colors.pink,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 30,
                  endValue: 80,
                  color: Colors.green,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 80,
                  endValue: 160,
                  color: Colors.amber,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 160,
                  endValue: 240,
                  color: Colors.red,
                  startWidth: 15,
                  endWidth: 15,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 125),
                      Text(
                        velocidad.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(
                              color: Colors.white,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "km/h",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.75,
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildRpmGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 8000,
          pointers: <GaugePointer>[
            NeedlePointer(
              value: 3500, // Valor fijo de ejemplo
              enableAnimation: true,
              needleColor: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCombustibleGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          pointers: <GaugePointer>[
            NeedlePointer(
              value: 65, // Porcentaje fijo de ejemplo
              enableAnimation: true,
              needleColor: Colors.orange,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTemperaturaGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 120,
          pointers: <GaugePointer>[
            NeedlePointer(
              value: 92,
              enableAnimation: true,
              needleColor: Colors.redAccent,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBateriaGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 15,
          pointers: <GaugePointer>[
            NeedlePointer(
              value: 12.8, // Voltaje fijo de ejemplo
              enableAnimation: true,
              needleColor: Colors.pinkAccent,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // DropdownButton para seleccionar métrica
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButton<String>(
                value: selectedMetric,
                items: <String>[
                  'Velocidad',
                  'RPM',
                  'Combustible',
                  'Temperatura',
                  'Bateria'
                ]
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMetric = newValue!;
                  });
                },
                isExpanded: true,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                dropdownColor: Colors.white,
                icon: const Icon(Icons.arrow_drop_down),
              ),
            ),
            Expanded(
              child: Center(
                child: buildGauge(), // Mostrar gauge basado en selección
              ),
            ),
          ],
        ),
      ),
    );
  }
}
