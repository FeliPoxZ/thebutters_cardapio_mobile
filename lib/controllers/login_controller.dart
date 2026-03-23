import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier{

  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();

  void atualizarTela (){
    notifyListeners();
  }
  
  void limpar (){
    txtEmail.clear();
    txtSenha.clear();
    notifyListeners();
  }


  bool validarUsuarioBasico(){
    if (txtEmail.text == 'adm' || txtEmail.text == 'ADM'){
      if (txtSenha.text == 'adm' || txtSenha.text == 'ADM'){
        return true;
      }else{
        return false;
      }
    }else {
      return false;
    }
  }

}