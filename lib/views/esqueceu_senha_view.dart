import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/login_controller.dart';

class EsqueceuSenhaView extends StatefulWidget {
  const EsqueceuSenhaView({super.key});

  @override
  State<EsqueceuSenhaView> createState() => _EsqueceuSenhaViewState();
}

class _EsqueceuSenhaViewState extends State<EsqueceuSenhaView> {
  final ctrl = GetIt.I.get<LoginController>();

  @override
  void initState() {
    super.initState();
    // Escuta as alterações de carregamento do controller
    ctrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(253, 247, 237, 1),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(243, 236, 222, 1),
      // Stack para suportar a tela de loading por cima
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(253, 247, 237, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 12),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(244, 164, 84, 1), // Cor de cabeçalho padrão
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(255, 139, 47, 1),
                                strokeAlign: BorderSide.strokeAlignInside,
                                style: BorderStyle.solid,
                                width: 5,
                              ),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Image(
                                  image: AssetImage('assets/images/Capivara1.png'),
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                'Recuperar Senha',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              const Text('Informe seu E-mail', style: TextStyle(color: Colors.black54)),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                child: TextField(
                                  controller: ctrl.txtEmailEsqueciSenha,
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: !ctrl.carregando, // Desativa o input no loading
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromRGBO(253, 217, 174, 1),
                                    hintText: 'E-mail',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                // Usando o estado global do Controller para desabilitar o botão
                                onPressed: ctrl.carregando 
                                    ? null 
                                    : () async {
                                        // Chama o método que já gerencia o loading
                                        bool enviadoComSucesso = await ctrl.esqueceuSenha(context);

                                        // Se deu certo, exibe o pop-up de instruções
                                        if (enviadoComSucesso && context.mounted) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Aviso'),
                                                content: const Text(
                                                  'Se o e-mail informado estiver correto, o link para redefinição chegará na sua caixa de entrada. Verifique a caixa de Spam também.'
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context); // Fecha o AlertDialog
                                                      Navigator.pop(context); // Volta para a tela de Login
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(28, 99, 178, 1),
                                  minimumSize: const Size(290, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'ENVIAR',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
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

          // Camada 2: TELA DE CARREGAMENTO GLOBAL UNIFICADA
          if (ctrl.carregando)
            Container(
              color: Colors.black45, // Cortina de bloqueio
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(253, 247, 237, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(28, 99, 178, 1)),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Enviando e-mail...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}