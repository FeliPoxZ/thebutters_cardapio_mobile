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
        backgroundColor: Color.fromRGBO(243, 236, 222, 1),
        scrolledUnderElevation: 0,
        toolbarHeight: 30,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(243, 236, 222, 1),
      body: Padding(
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
                    color: Color.fromRGBO(253, 247, 237, 1),
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
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(254, 187, 111, 1),
                          borderRadius: const BorderRadius.only(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
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
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/Logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(bottom: 5, left: 25, right: 5, top: 5),
                        child: Text(
                          'The Butters',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                                  icon: Icon(
                                    Icons.email
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(253, 217, 174, 1),
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

                            // Nome completo (obrigatório)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 0),
                              child: TextFormField(
                                controller: ctrl.txtNomeCompleto,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.person
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(253, 217, 174, 1),
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

                            // Telefone (obrigatório)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 0),
                              child: TextFormField(
                                controller: ctrl.txtTelefone,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [maskCelular],
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.phone
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(253, 217, 174, 1),
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

                            // Senha (obrigatório, placeholder *******)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 0),
                              child: TextFormField(
                                controller: ctrl.txtSenha,
                                obscureText: true,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(253, 217, 174, 1),
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

                            // Confirmar senha (obrigatório)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20, top: 20),
                              child: TextFormField(
                                controller: ctrl.txtConfirmarSenha,
                                obscureText: true,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.lock
                                  ),
                                  filled: true,
                                  fillColor: Color.fromRGBO(253, 217, 174, 1),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Formulário válido, prossiga
                              print('Formulário válido!');
                              // Aqui você pode chamar a lógica de cadastro
                            }

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(28, 99, 178, 1),
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
    );
  }
}