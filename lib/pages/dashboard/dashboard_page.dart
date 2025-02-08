import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

final Color colorPrimary = Color(0xFF007AFF); // Azul principal

class SpeedometerPage extends StatefulWidget {
  const SpeedometerPage({super.key});

  @override
  State<SpeedometerPage> createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  final ValueNotifier<double> _velocidadNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _rpmNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _cargaMotorNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _cargaInComNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _posiAceNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _presColAdmiNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _presComNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _sensorMapNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _tempAceNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _tempRefNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _tiemEncNotifier = ValueNotifier(0.0);
  final ValueNotifier<double> _voltajeNotifier = ValueNotifier(0.0);
  String selectedMetric = "Velocidad";
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _setupDatabaseListeners();
  }

  void _setupDatabaseListeners() {
    // Listener para la velocidad
    _databaseRef.child('/Sensores/Vel vehículo').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _velocidadNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final velocidad = double.tryParse(data.toString()) ?? 0.0;
          _velocidadNotifier.value = velocidad;
        }
      }
    });
    _databaseRef.child('/Sensores/RPM').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _rpmNotifier.value = -1; // Valor especial para indicar "No soportado"
        } else {
          final rpm = double.tryParse(data.toString()) ?? 0.0;
          _rpmNotifier.value = rpm;
        }
      }
    });
    _databaseRef.child('/Sensores/Carga del motor').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _cargaMotorNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final carmotor = double.tryParse(data.toString()) ?? 0.0;
          _cargaMotorNotifier.value = carmotor;
        }
      }
    });
    _databaseRef
        .child('/Sensores/Consumo instantáneo combustible')
        .onValue
        .listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _cargaInComNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final conincom = double.tryParse(data.toString()) ?? 0.0;
          _cargaInComNotifier.value = conincom;
        }
      }
    });
    _databaseRef.child('/Sensores/Posición acelerador').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _posiAceNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final posace = double.tryParse(data.toString()) ?? 0.0;
          _posiAceNotifier.value = posace;
        }
      }
    });
    _databaseRef
        .child('/Sensores/Presión colector admisión')
        .onValue
        .listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _presColAdmiNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final prescoladm = double.tryParse(data.toString()) ?? 0.0;
          _presColAdmiNotifier.value = prescoladm;
        }
      }
    });
    _databaseRef.child('/Sensores/Presión combustible').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _presComNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final prescom = double.tryParse(data.toString()) ?? 0.0;
          _presComNotifier.value = prescom;
        }
      }
    });
    _databaseRef.child('/Sensores/Sensor MAP').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _sensorMapNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final sensmap = double.tryParse(data.toString()) ?? 0.0;
          _sensorMapNotifier.value = sensmap;
        }
      }
    });
    _databaseRef.child('/Sensores/Temperatura aceite').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _tempAceNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final tempace = double.tryParse(data.toString()) ?? 0.0;
          _tempAceNotifier.value = tempace;
        }
      }
    });
    _databaseRef
        .child('/Sensores/Temperatura refrigerante')
        .onValue
        .listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _tempRefNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final tempref = double.tryParse(data.toString()) ?? 0.0;
          _tempRefNotifier.value = tempref;
        }
      }
    });
    _databaseRef.child('/Sensores/Tiempo de encendido').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _tiemEncNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final tiempen = double.tryParse(data.toString()) ?? 0.0;
          _tiemEncNotifier.value = tiempen;
        }
      }
    });
    _databaseRef.child('/Sensores/Voltaje').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        if (data == "No soportado") {
          _voltajeNotifier.value =
              -1; // Valor especial para indicar "No soportado"
        } else {
          final voltaje = double.tryParse(data.toString()) ?? 0.0;
          _voltajeNotifier.value = voltaje;
        }
      }
    });
  }

  Widget buildGauge() {
    switch (selectedMetric) {
      case 'RPM':
        return buildRpmGauge();
      case 'Carga del motor':
        return buildCargamotorGauge();
      case 'Consumo instantáneo combustible':
        return buildConsumoInsComGauge();
      case 'Posición acelerador':
        return buildPosiAceGauge();
      case 'Presión colector admisión':
        return buildPresColAdmGauge();
      case 'Presión combustible':
        return buildPresComGauge();
      case 'Sensor MAP':
        return buildSensMapGauge();
      case 'Temperatura aceite':
        return buildTempAceiteGauge();
      case 'Temperatura refrigerante':
        return buildTempRefGauge();
      case 'Tiempo de encendido':
        return buildTieEncGauge();
      case 'Voltaje':
        return buildVoltajeGauge();
      default:
        return buildSpeedGauge();
    }
  }

  Widget buildSpeedGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _velocidadNotifier,
      builder: (context, velocidad, child) {
        if (velocidad == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
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
                      const SizedBox(height: 180),
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
    return ValueListenableBuilder<double>(
      valueListenable: _rpmNotifier,
      builder: (context, rpm, child) {
        if (rpm == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 0,
              maximum: 8000,
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
                  value: rpm,
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
                  endValue: 2000,
                  color: Colors.green,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 2000,
                  endValue: 5000,
                  color: Colors.yellow,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 5000,
                  endValue: 7000,
                  color: Colors.orange,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 7000,
                  endValue: 8000,
                  color: Colors.red,
                  startWidth: 15,
                  endWidth: 15,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(rpm.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 20,
                              ),
                            ],
                          )),
                      const Text(
                        "RPM",
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

  Widget buildCargamotorGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _cargaMotorNotifier,
      builder: (context, carmotor, child) {
        if (carmotor == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140, // Ángulo de inicio
              endAngle: 40, // Ángulo de fin
              minimum: 0, // Valor mínimo (0%)
              maximum: 100, // Valor máximo (100%)
              radiusFactor: 0.9, // Tamaño del medidor
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
                  value: carmotor,
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
                  endValue: 25,
                  color: Colors.green,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 25,
                  endValue: 50,
                  color: Colors.yellow,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 50,
                  endValue: 75,
                  color: Colors.orange,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 75,
                  endValue: 100,
                  color: Colors.red,
                  startWidth: 15,
                  endWidth: 15,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        carmotor.toStringAsFixed(0),
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
                        "Carga del Motor",
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

  Widget buildConsumoInsComGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _cargaInComNotifier,
      builder: (context, conincom, child) {
        if (conincom == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 0,
              maximum: 30, // Ajustado a un rango más realista
              radiusFactor: 0.9,
              majorTickStyle: const MajorTickStyle(
                length: 10,
                thickness: 2,
                color: Colors.black,
              ),
              minorTicksPerInterval: 2,
              minorTickStyle: const MinorTickStyle(
                length: 5,
                thickness: 1,
                color: Colors.grey,
              ),
              axisLineStyle: const AxisLineStyle(
                thickness: 12,
                gradient: SweepGradient(
                  colors: [
                    Colors.green, // Bajo consumo
                    Colors.yellow, // Moderado
                    Colors.orange, // Alto consumo
                    Colors.red, // Excesivo
                  ],
                  stops: [0.15, 0.35, 0.65, 1],
                ),
              ),
              axisLabelStyle: const GaugeTextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value:
                      conincom.clamp(0, 30), // Limita valores fuera del rango
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                  needleColor: Colors.red,
                  needleStartWidth: 1,
                  needleEndWidth: 5,
                  needleLength: 0.75,
                  animationDuration: 1500,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.red],
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
                  endValue: 5,
                  color: Colors.green,
                  startWidth: 12,
                  endWidth: 12,
                ),
                GaugeRange(
                  startValue: 5,
                  endValue: 10,
                  color: Colors.yellow,
                  startWidth: 12,
                  endWidth: 12,
                ),
                GaugeRange(
                  startValue: 10,
                  endValue: 20,
                  color: Colors.orange,
                  startWidth: 12,
                  endWidth: 12,
                ),
                GaugeRange(
                  startValue: 20,
                  endValue: 30,
                  color: Colors.red,
                  startWidth: 12,
                  endWidth: 12,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${conincom.toStringAsFixed(1)} L/100km",
                        style: const TextStyle(
                          fontSize: 45,
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
                        "Consumo Instantáneo",
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

  Widget buildPosiAceGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _posiAceNotifier,
      builder: (context, posace, child) {
        if (posace == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 0,
              maximum: 100, // 🔹 Ajustado a % real
              radiusFactor: 0.9,
              axisLineStyle: const AxisLineStyle(
                thickness: 12,
                gradient: SweepGradient(
                  colors: [Colors.green, Colors.yellow, Colors.red],
                  stops: [0.3, 0.7, 1],
                ),
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: posace.clamp(0, 100),
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                  needleColor: Colors.red,
                  needleLength: 0.75,
                  animationDuration: 1500,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.red],
                  ),
                  knobStyle: KnobStyle(
                    color: Colors.transparent,
                    borderColor: Colors.blue.withAlpha(100),
                    borderWidth: 1,
                  ),
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${posace.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 20)
                          ],
                        ),
                      ),
                      const Text(
                        "Posición del Acelerador",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.75,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildPresColAdmGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _presColAdmiNotifier,
      builder: (context, prescoladm, child) {
        if (prescoladm == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 20, // 🔹 Rango realista
              maximum: 250, // 🔹 MAP puede llegar a 250 kPa en motores turbo
              radiusFactor: 0.9,
              axisLineStyle: const AxisLineStyle(
                thickness: 12,
                gradient: SweepGradient(
                  colors: [Colors.green, Colors.yellow, Colors.red],
                  stops: [0.3, 0.7, 1],
                ),
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: prescoladm.clamp(20, 250),
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                  needleColor: Colors.red,
                  needleLength: 0.75,
                  animationDuration: 1500,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.red],
                  ),
                  knobStyle: KnobStyle(
                    color: Colors.transparent,
                    borderColor: Colors.blue.withAlpha(100),
                    borderWidth: 1,
                  ),
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${prescoladm.toStringAsFixed(0)} kPa",
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 20)
                          ],
                        ),
                      ),
                      const Text(
                        "Presión Colector Admisión",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.75,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildPresComGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _presComNotifier,
      builder: (context, prescom, child) {
        if (prescom == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 0,
              maximum: 500,
              radiusFactor: 0.9,
              axisLineStyle: const AxisLineStyle(
                thickness: 12,
                gradient: SweepGradient(
                  colors: [Colors.red, Colors.yellow, Colors.green],
                  stops: [0.3, 0.7, 1],
                ),
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: prescom.clamp(0, 500),
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                  needleColor: Colors.red,
                  needleLength: 0.75,
                  animationDuration: 1500,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.red],
                  ),
                  knobStyle: KnobStyle(
                    color: Colors.transparent,
                    borderColor: Colors.blue.withAlpha(100),
                    borderWidth: 1,
                  ),
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${prescom.toStringAsFixed(0)} kPa",
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 20)
                          ],
                        ),
                      ),
                      const Text(
                        "Presión de Combustible",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.75,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildSensMapGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _sensorMapNotifier,
      builder: (context, sensmap, child) {
        if (sensmap == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 20, // 🔹 Rango realista para Sensor MAP
              maximum: 250,
              radiusFactor: 0.9,
              axisLineStyle: const AxisLineStyle(
                thickness: 12,
                gradient: SweepGradient(
                  colors: [Colors.green, Colors.yellow, Colors.red],
                  stops: [0.3, 0.7, 1],
                ),
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: sensmap.clamp(20, 250),
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                  needleColor: Colors.red,
                  needleLength: 0.75,
                  animationDuration: 1500,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.red],
                  ),
                  knobStyle: KnobStyle(
                    color: Colors.transparent,
                    borderColor: Colors.blue.withAlpha(100),
                    borderWidth: 1,
                  ),
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${sensmap.toStringAsFixed(0)} kPa",
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 20)
                          ],
                        ),
                      ),
                      const Text(
                        "Sensor MAP",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.75,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildTempAceiteGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _tempAceNotifier,
      builder: (context, tempace, child) {
        if (tempace == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 0,
              maximum: 150,
              radiusFactor: 0.9,
              axisLineStyle: const AxisLineStyle(
                thickness: 12,
                gradient: SweepGradient(
                  colors: [Colors.green, Colors.yellow, Colors.red],
                  stops: [0.3, 0.7, 1],
                ),
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: tempace.clamp(20, 250),
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                  needleColor: Colors.red,
                  needleLength: 0.75,
                  animationDuration: 1500,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.red],
                  ),
                  knobStyle: KnobStyle(
                    color: Colors.transparent,
                    borderColor: Colors.blue.withAlpha(100),
                    borderWidth: 1,
                  ),
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${tempace.toStringAsFixed(0)} C°",
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 20)
                          ],
                        ),
                      ),
                      const Text(
                        "Temperatura del aceite",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.75,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildTempRefGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _tempRefNotifier,
      builder: (context, tempref, child) {
        if (tempref == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 40,
              maximum: 150,
              radiusFactor: 0.9,
              axisLineStyle: const AxisLineStyle(
                thickness: 12,
                gradient: SweepGradient(
                  colors: [Colors.green, Colors.yellow, Colors.red],
                  stops: [0.3, 0.7, 1],
                ),
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: tempref.clamp(20, 250),
                  enableAnimation: true,
                  animationType: AnimationType.elasticOut,
                  needleColor: Colors.red,
                  needleLength: 0.75,
                  animationDuration: 1500,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.red],
                  ),
                  knobStyle: KnobStyle(
                    color: Colors.transparent,
                    borderColor: Colors.blue.withAlpha(100),
                    borderWidth: 1,
                  ),
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${tempref.toStringAsFixed(0)} C°",
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 20)
                          ],
                        ),
                      ),
                      const Text(
                        "Temperatura refrigerante",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                  angle: 90,
                  positionFactor: 0.75,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildTieEncGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _tiemEncNotifier,
      builder: (context, tiempen, child) {
        if (tiempen == -11) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: -10,
              maximum: 50,
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
                thickness: 12,
                gradient: SweepGradient(
                  colors: [Colors.green, Colors.yellow, Colors.red],
                  stops: [0.3, 0.7, 1],
                ),
              ),
              axisLabelStyle: const GaugeTextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: tiempen.clamp(0, 50),
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
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        "${tiempen.toStringAsFixed(0)} °",
                        style: TextStyle(
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
                        "Tiempo de Encendido",
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

  Widget buildVoltajeGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _voltajeNotifier,
      builder: (context, voltaje, child) {
        if (voltaje == -1) {
          return Center(
            child: Text(
              "No soportado",
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              startAngle: 140,
              endAngle: 40,
              minimum: 6,
              maximum: 18,
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
                    Colors.red,
                    Colors.green,
                    Colors.red,
                  ],
                  stops: [1, 1, 1],
                ),
              ),
              axisLabelStyle: const GaugeTextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: voltaje,
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
                  endValue: 8,
                  color: Colors.red,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 10,
                  endValue: 14,
                  color: Colors.green,
                  startWidth: 15,
                  endWidth: 15,
                ),
                GaugeRange(
                  startValue: 14,
                  endValue: 18,
                  color: Colors.red,
                  startWidth: 15,
                  endWidth: 15,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text("${voltaje.toDouble()} V",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 20,
                              ),
                            ],
                          )),
                      const Text(
                        "Voltaje",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 188, 188),
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.blueAccent, width: 2), // Borde azul
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2), // Sombra ligera
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: selectedMetric,
                  items: <String>[
                    'Velocidad',
                    'RPM',
                    'Carga del motor',
                    'Consumo instantáneo combustible',
                    'Posición acelerador',
                    'Presión colector admisión',
                    'Presión combustible',
                    'Sensor MAP',
                    'Temperatura aceite',
                    'Temperatura refrigerante',
                    'Tiempo de encendido',
                    'Voltaje',
                  ]
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMetric = newValue!;
                    });
                  },
                  isExpanded: true,
                  underline: Container(), // Quita la línea por defecto
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.blueAccent,
                    size: 28,
                  ),
                  dropdownColor: Colors.white,
                ),
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
