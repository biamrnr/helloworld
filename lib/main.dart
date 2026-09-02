import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Distância até em casa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {

  String resultado = "Clique no botão para calcular a distância";

  double latitudeCasa = -21.496633962801006;
  double longitudeCasa = -47.008506733187374;

  Future<void> calcularDistancia() async {

    bool gpsAtivo = await Geolocator.isLocationServiceEnabled();

    if (!gpsAtivo) {
      setState(() {
        resultado = "Ative o GPS!";
      });
      return;
    }

    LocationPermission permissao =
        await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      setState(() {
        resultado = "Permissão de localização negada!";
      });
      return;
    }

    Position posicaoAtual =
        await Geolocator.getCurrentPosition();

    double distanciaMetros = Geolocator.distanceBetween(
      posicaoAtual.latitude,
      posicaoAtual.longitude,
      latitudeCasa,
      longitudeCasa,
    );


    double distanciaKm = distanciaMetros / 1000;

    setState(() {
      resultado =
          "${distanciaKm.toStringAsFixed(2)} km";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPS - Distância até em casa"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.house,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                "Distancia entre a escola e minha casa",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                resultado,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: calcularDistancia,
                child: const Text(
                  "Calcular distância",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}