import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:thebutters_cardapio_mobile/controllers/cadastro_controller.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final ctrl = GetIt.I.get<CadastroController>();

  final _formKey = GlobalKey<FormState>();

  final maskCelular = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(243, 236, 222, 1),
        scrolledUnderElevation: 0,
        toolbarHeight: 30,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(243, 236, 222, 1),
      // Mudamos o body para um Stack para conseguir sobrepor a tela de carregamento
      body: Stack(
        children: [
          // Camada 1: Toda a sua interface original
          Padding(
            padding: EdgeInsets.zero,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 30, left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(253, 247, 237, 1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 12),
                          )
                        ],
                      ),
                      child: ListView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        children: [
                          // Cabeçalho
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
                                  strokeAlign: BorderSide.strokeAlignInside,
                                ),
                              ),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Image(
                                    image: AssetImage('assets/images/Capivara1.png'),
                                    fit: BoxFit.contain,
                                  )
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

                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5, left: 25, right: 5, top: 5),
                              child: Text(
                                'The Butters',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          // Formulário
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Email
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: TextFormField(
                                    controller: ctrl.txtEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.email),
                                      filled: true,
                                      fillColor: const Color.fromRGBO(253, 217, 174, 1),
                                      hintText: 'E-mail',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o email';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Email inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // Nome completo
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 0),
                                  child: TextFormField(
                                    controller: ctrl.txtNomeCompleto,
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.person),
                                      filled: true,
                                      fillColor: const Color.fromRGBO(253, 217, 174, 1),
                                      hintText: 'Nome completo',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o nome completo';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // Telefone
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 0),
                                  child: TextFormField(
                                    controller: ctrl.txtTelefone,
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [maskCelular],
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.phone),
                                      filled: true,
                                      fillColor: const Color.fromRGBO(253, 217, 174, 1),
                                      hintText: 'Telefone (00) 00000-0000',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o telefone';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // Senha
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 0),
                                  child: TextFormField(
                                    controller: ctrl.txtSenha,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.lock),
                                      filled: true,
                                      fillColor: const Color.fromRGBO(253, 217, 174, 1),
                                      hintText: 'Senha',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe a senha';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // Confirmar senha
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 20),
                                  child: TextFormField(
                                    controller: ctrl.txtConfirmarSenha,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.lock),
                                      filled: true,
                                      fillColor: const Color.fromRGBO(253, 217, 174, 1),
                                      hintText: 'Confirme sua senha',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirme a senha';
                                      }
                                      if (value != ctrl.txtSenha.text) {
                                        return 'As senhas não conferem';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 35),

                          // Botão Registrar
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ElevatedButton(
                              onPressed: ctrl.carregando
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        await ctrl.realizarCadastro(context);
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
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'REGISTRAR',
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Camada 2: Tela de Carregamento em cima de tudo
          if (ctrl.carregando)
            Container(
              color: Colors.black45, // Deixa o fundo atrás borrado/escurecido
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(253, 247, 237, 1), // Cor do container centralizado
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
                        'Criando sua conta...',
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