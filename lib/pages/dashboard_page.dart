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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: rpm,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        rpm.toStringAsFixed(0),
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: carmotor,
                  enableAnimation: true,
                  needleColor: Colors.red,
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: conincom,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        conincom.toStringAsFixed(0),
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
                        "Consumo instantaneo de combustible",
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: posace,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        posace.toStringAsFixed(0),
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
                        "Posición del acelerador",
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

  Widget buildPresColAdmGauge() {
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: prescom,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        prescom.toStringAsFixed(0),
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
                        "Presión colector admisión",
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: prescom,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        prescom.toStringAsFixed(0),
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
                        "Presion de combustible",
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: sensmap,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        sensmap.toStringAsFixed(0),
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
                        "Sensor MAP",
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: tempace,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        tempace.toStringAsFixed(0),
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
                        "Temperatura del aceite",
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: tempref,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        tempref.toStringAsFixed(0),
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
                        "Temperatura refrigerante",
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

  Widget buildTieEncGauge() {
    return ValueListenableBuilder<double>(
      valueListenable: _tiemEncNotifier,
      builder: (context, tiempen, child) {
        if (tiempen == -1) {
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
              minimum: 0,
              maximum: 8000,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: tiempen,
                  enableAnimation: true,
                  needleColor: Colors.red,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Column(
                    children: [
                      const SizedBox(height: 180),
                      Text(
                        tiempen.toStringAsFixed(0),
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
