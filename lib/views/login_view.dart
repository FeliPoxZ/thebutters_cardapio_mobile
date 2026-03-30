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
                    color: Color.fromRGBO(253, 247, 237, 1),
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

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/Logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      Text(
                        'The Butters',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: ctrl.txtEmail,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(253, 217, 174, 1),
                            hintText: 'E-mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 0,
                          left: 20,
                          right: 20,
                          top: 0
                        ),
                        child: TextField(
                          controller: ctrl.txtSenha,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(253, 217, 174, 1),
                            hintText: 'Senha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),


                      SizedBox(height: 35),

                      ElevatedButton(
                        onPressed: () {
                          var retorno = ctrl.validarUsuarioBasico();
                          if (retorno){
                            Navigator.pushNamed(context, 'Cadastro');
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'E-mail e/ou senha errados, tente novamente',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                  ),
                                ),
                                backgroundColor: const Color.fromRGBO(236, 166, 80, 1),
      
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom (
                          backgroundColor: Color.fromRGBO(28, 99, 178, 1),
                          minimumSize: Size(290, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ENTRAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      TextButton(
                        onPressed: () {
                          var retorno = ctrl.validarUsuarioBasico();
                          if (retorno){
                            Navigator.pushNamed(context, 'Cadastro');
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'E-mail e/ou senha errados, tente novamente',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15
                                  ),
                                ),
                                backgroundColor: const Color.fromRGBO(236, 166, 80, 1),
      
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Criar uma conta',
                          style: TextStyle(
                            color: Color.fromRGBO(236, 166, 80, 1),
                            fontStyle: FontStyle.italic
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