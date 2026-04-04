import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/login_controller.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_colors.dart';


class EsqueceuSenhaView extends StatefulWidget {
  const EsqueceuSenhaView({super.key});

  @override
  State<EsqueceuSenhaView> createState() => _EsqueceuSenhaViewState();
}

class _EsqueceuSenhaViewState extends State<EsqueceuSenhaView> {
  final ctrl = GetIt.I.get<LoginController>();

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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(253, 247, 237, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 12)
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
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Recuperar Senha',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Informe seu E-mail'
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Aviso'),
                                    content: Text('O código para recuperação virá no seu E-mail'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, 'Login');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              minimumSize: Size(290, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10)
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'ENVIAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
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
    );
  }
}