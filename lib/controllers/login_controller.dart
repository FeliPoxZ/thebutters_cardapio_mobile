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
        notifyListeners();
        return true;
      }else{
        notifyListeners();
        return false;
      }
    }else {
      notifyListeners();
      return false;
    }
  }

}