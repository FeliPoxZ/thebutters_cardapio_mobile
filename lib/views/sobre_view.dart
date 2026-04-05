import 'package:flutter/material.dart';

class SobreView extends StatefulWidget {
  const SobreView({super.key});

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(253, 247, 237, 1),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Color.fromRGBO(253, 247, 237, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(30),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width* 0.9,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(253, 247, 237, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0,12)
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(254, 187, 111, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(255, 139, 47, 1),
                              width: 5,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsetsGeometry.fromLTRB(20, 20, 20, 0),
                            child: Image.asset(
                              'assets/images/Capivara1.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Objetivos',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C63B2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                '• Facilitar a apresentação dos produtos.\n• Melhorar a experiência de delivery.',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'Desenvolvedores',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1C63B2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Antony Felipe Lampa\nFelipe Granvile\nGabriel Pereira Reverso',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                    )
                                ],
                              )
                            ),
                            const SizedBox(height: 90),
                            Center(
                              child: const Text(
                                'Todos os direitos reservados © 2026',
                                style: TextStyle(),
                                ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}