import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ctrl = GetIt.I.get<LoginController>();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )
                  ),
                ),
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Color.fromRGBO(255, 162, 0, 1),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 243, 236, 222),
    );
  }
}

/*
Container(
  width: MediaQuery.of(context).size.width * 0.8,
  height: 200,
  decoration: BoxDecoration(
    color: Color.fromRGBO(255, 162, 0, 1),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  ),
  child: Center(
    child: SizedBox(
      width: 120, // controla o tamanho da imagem
      height: 120,
      child: Image.asset(
        'assets/images/Capivara1.png',
        fit: BoxFit.contain,
      ),
    ),
  ),
)
*/