import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thebutters_cardapio_mobile/controllers/aux_controller.dart';
import 'package:thebutters_cardapio_mobile/services/usuario_service.dart';

class CadastroController extends ChangeNotifier {

  //Variável para serviço de sessão
  final UsuarioService _usuarioService;

  CadastroController({required UsuarioService usuarioService})
    : _usuarioService = usuarioService;

  //Controladores de texto
  final txtEmail = TextEditingController();
  final txtTelefone = TextEditingController();
  final txtNomeCompleto = TextEditingController();
  final txtSenha = TextEditingController();
  final txtConfirmarSenha = TextEditingController();

  //Instâncias Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _carregando = false;
  bool get carregando => _carregando;

  void atualizarTela (){
    notifyListeners();
  }

  //Método Principal de Cadastro
  Future<void> realizarCadastro(BuildContext context) async {
    // Validações básicas antes de chamar o Firebase
    if (txtNomeCompleto.text.trim().isEmpty ||
        txtEmail.text.trim().isEmpty ||
        txtTelefone.text.trim().isEmpty ||
        txtSenha.text.trim().isEmpty ||
        txtConfirmarSenha.text.trim().isEmpty) {
          erro(context, "Por favor, preencha todos os campos!");
          return;
        }
    
    if (txtSenha.text != txtConfirmarSenha.text) {
      erro(context, "As senhas não coincidem!");
      return;
    }

    //Ativa o loading na tela
    _carregando = true;
    notifyListeners();

    try {
      //Criar Usuário no Firebase Authentication (Apenas e-mail e senha)
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: txtEmail.text.trim(),
        password: txtSenha.text.trim());

      String uid = userCredential.user!.uid;

      //Criar a coleção/documento no Firestore usando o mesmo UID
      await _firestore.collection('usuarios').doc(uid).set({
        'Nome': txtNomeCompleto.text.trim(),
        "Email": txtEmail.text.trim(),
        'Telefone' : txtTelefone.text.trim()
      });

      // Salva os dados na sessão local
      _usuarioService.uid = uid;
      _usuarioService.nome = txtNomeCompleto.text.trim();
      _usuarioService.email = txtEmail.text.trim();
      _usuarioService.telefone = txtTelefone.text.trim();
      _usuarioService.notifyListeners();

      // Sucesso! Limpa os campos e avisa o usuário
      if (!context.mounted) return;
      limpar();
      sucesso(context, "Cadastro realizado com sucesso!");
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      // Trata erros do Firebase Auth
      String mensagemErro = "Ocorreu um erro ao cadastrar";
      if (e.code == 'weak-password') {
        mensagemErro = "A senha digitada é muito fraca";
      } else if (e.code == 'email-already-in-use') {
        mensagemErro = "Este e-mail já está cadastrado";
      } else if (e.code == 'invalid-email') {
        mensagemErro = "O formato do e-mail é inválido";
      }
      erro(context, mensagemErro);
    } catch (e) {
      //Trata outros erros
      erro(context, "Erro ao salvar dados: $e");
    } finally {
      //Desativa o loading, independente de ter dado certo ou errado
      _carregando = false;
      limpar();
      notifyListeners();
    }
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