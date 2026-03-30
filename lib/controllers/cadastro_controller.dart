import 'package:flutter/material.dart';

class CadastroController extends ChangeNotifier {

  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtNomeCompleto = TextEditingController();
  final txtSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();

  void atualizarTela (){
    notifyListeners();
  }

  void limpar (){
    txtEmail.clear();
    txtSenha.clear();
    txtConfirmarSenha.clear();
    txtNomeCompleto.clear();
    txtTelefone.clear();
    notifyListeners();
  }

}