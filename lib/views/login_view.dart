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
      backgroundColor: const Color.fromRGBO(243, 236, 222, 1),
      // Adicionamos o Stack aqui para sobrepor a tela de carregamento quando necessário
      body: Stack(
        children: [
          // Camada 1: Interface principal do Login
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
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
                      // Alterado de Column para ListView para evitar erros de teclado (Overflow)
                      child: ListView(
                        padding: EdgeInsets.zero,
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
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  'assets/images/Logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          const Center(
                            child: Text(
                              'The Butters',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              controller: ctrl.txtEmail,
                              keyboardType: TextInputType.emailAddress, // Melhora a UX do teclado
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

                          Padding(
                            padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 0),
                            child: TextField(
                              controller: ctrl.txtSenha,
                              obscureText: true, // Esconde a senha digitada
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromRGBO(253, 217, 174, 1),
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
                                // Desabilita o link se o app estiver processando algo
                                onPressed: ctrl.carregando
                                    ? null
                                    : () {
                                        Navigator.pushNamed(context, 'EsqueceuSenha');
                                      },
                                child: const Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 35),

                          Center(
                            child: ElevatedButton(
                              // Trava o botão principal se já estiver carregando
                              onPressed: ctrl.carregando
                                  ? null
                                  : () {
                                      ctrl.login(context);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(28, 99, 178, 1),
                                minimumSize: const Size(290, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
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
                          ),

                          const SizedBox(height: 10),

                          Center(
                            child: TextButton(
                              // Desabilita o link se o app estiver processando algo
                              onPressed: ctrl.carregando
                                  ? null
                                  : () {
                                      Navigator.pushNamed(context, 'Cadastro');
                                    },
                              child: const Text(
                                'Criar uma conta',
                                style: TextStyle(
                                  color: Color.fromRGBO(236, 166, 80, 1),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Camada 2: TELA DE CARREGAMENTO GLOBAL DO LOGIN
          if (ctrl.carregando)
            Container(
              color: Colors.black45, // Cortina escura bloqueadora de cliques
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
                        'Autenticando...',
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