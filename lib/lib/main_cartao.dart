import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Meu cartão"),
        ),
        body: Center(
          child: Container(
            width: 350,
            height: 210,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 157, 5, 88),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // INFORMAÇÕES
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Banco SESI/SENAI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "1234 5678 9012 3456",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Titular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                    const Text(
                      "Beatriz Marques",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Validade",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),

                            Text(
                              "01/25",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // ÍCONES
                Column(
                  children: const [

                    Icon(
                      Icons.contactless_rounded,
                      color: Colors.white,
                      size: 30,
                    ),

                    SizedBox(height: 10),

                    Icon(
                      Icons.sim_card,
                      color: Colors.white,
                      size: 30,
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}