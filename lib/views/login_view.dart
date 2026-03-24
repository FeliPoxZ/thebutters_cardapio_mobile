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
        padding: EdgeInsetsGeometry.fromLTRB(0, 30, 0, 30),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        spreadRadius: 2, // espalhamento
                        offset: Offset(0, 12), // posição (x, y)
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(254, 187, 111, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                          ),
                          border: BoxBorder.fromLTRB(bottom: BorderSide(
                            color: Color.fromRGBO(255, 139, 47, 1),
                            strokeAlign: BorderSide.strokeAlignInside,
                            style: BorderStyle.solid,
                            width: 5
                          ))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.fromLTRB(30, 0, 30, 0),
                              child: Image.asset(
                                'assets/images/Capivara1.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 247, 237, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          )
        ),
      ),
      backgroundColor: Color.fromRGBO(243, 236, 222, 1),
    );
  }
}

/*
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(50, 30, 30, 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(254, 187, 111, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),                    
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.fromLTRB(30, 25, 30, 0),
                      child: Image.asset(
                        'assets/images/Capivara1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Color.fromRGBO(255, 139, 47, 1),
                    )
                  ],
                )
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 400,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(243, 236, 222, 1),
    );
  }
*/