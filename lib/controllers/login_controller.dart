import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/services/usuario_service.dart';
import 'aux_controller.dart';

class LoginController extends ChangeNotifier {
  // Variável para o serviço de sessão
  final UsuarioService _usuarioService;

  LoginController({required UsuarioService usuarioService})
    : _usuarioService = usuarioService;

  //Controladores
  final txtEmail = TextEditingController();
  final txtSenha = TextEditingController();
  final txtEmailEsqueciSenha = TextEditingController();

  // Instâncias Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool _carregando = false;
  bool get carregando => _carregando;

  void atualizarTela() {
    notifyListeners();
  }

  void limpar() {
    txtEmail.clear();
    txtSenha.clear();
    notifyListeners();
  }

  // LOGIN
  // Efetuar o login de um usuário previamente cadastrado
  // no serviço Firebase Authentication
  //

  Future<void> login(dynamic context) async {
    if (txtEmail.text.trim().isEmpty || txtSenha.text.trim().isEmpty) {
      erro(context, "Por favor, preencha todos os campos!");
      return;
    }

    //Loading
    _carregando = true;
    notifyListeners();

    try {
      //Efetua login no Firebase Authentication
      await auth.signInWithEmailAndPassword(
        email: txtEmail.text.trim(),
        password: txtSenha.text.trim(),
      );

      //Carrega os dados do usuário do Firestore passa a sessão global
      await _usuarioService.carregarSessao();

      //Verifica se a tela ainda existe antes de navegar (async gap protection)
      if (!context.mounted) return;

      sucesso(context, "Usuário logado com sucesso");
      Navigator.pushReplacementNamed(context, 'Cardapio');

      //Limpa os campos apenas se o login funcionar
      limpar();
    } on FirebaseAuthException catch (e) {
      String mensagem =
          "As credenciais fornecidas estão incorretas ou expiraram";
      if (e.code == 'invalid-email') {
        mensagem = "O formato do e-mail é inválido";
      } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        mensagem = "E-mail e/ou senha incorretos!";
      }
      erro(context, mensagem);
    } catch (e) {
      erro(context, "Ocorreu um erro inesperado: $e");
    } finally {
      _carregando = false;
      limpar();
      notifyListeners();
    }
  }

  //
  // ESQUECEU A SENHA
  // Envia uma mensagem de email para recuperação de senha para
  // um conta de email válida
  //
  Future<bool> esqueceuSenha(dynamic context) async {
    if (txtEmailEsqueciSenha.text.trim().isEmpty) {
      erro(context, "Por favor, informe o e-mail de recuperação");
      return false;
    }

    _carregando = true;
    notifyListeners();

    try {
      // O trim() remove espaços em branco acidentais
      await auth.sendPasswordResetEmail(
        email: txtEmailEsqueciSenha.text.trim(),
      );

      // Se chegou aqui, deu certo!
      return true;
    } on FirebaseAuthException catch (e) {
      String mensagem = "Ocorreu um erro ao tentar validar o e-mail!";
      if (e.code == 'invalid-email') {
        mensagem = "O e-mail informado é inválido";
      } else if (e.code == 'user-not-found') {
        mensagem = "Usuário não encontrado com esse e-mail";
      }
      erro(context, mensagem);
      return false;
    } catch (e) {
      erro(context, "Erro: $e");
      return false;
    } finally {
      _carregando = false;
      limpar();
      notifyListeners();
    }
  }

  //
  // LOGOUT
  // Efetuar o logoff do usuário, limpar a sessão e voltar ao Login
  //
  Future<void> logout(dynamic context) async {
    // Ativa o estado de carregamento caso queira mostrar um loading na tela
    _carregando = true;
    notifyListeners();

    try {
      // 1. Chama o serviço que limpa a sessão e faz o signOut no Firebase
      await _usuarioService.deslogar();

      // 2. Verifica se a tela ainda existe antes de navegar
      if (!context.mounted) return;

      // 3. Redireciona o usuário para a tela de Login e remove o histórico de navegação
      Navigator.pushNamedAndRemoveUntil(context, 'Login', (route) => false);
    } catch (e) {
      if (context.mounted) {
        erro(context, "Ocorreu um erro ao tentar sair: $e");
      }
    } finally {
      // Garante que o estado de carregamento seja desligado
      _carregando = false;
      limpar(); // Garante que os campos de texto do login estarão vazios
      notifyListeners();
    }
  }

  bool validarUsuarioBasico() {
    if (txtEmail.text == 'adm' || txtEmail.text == 'ADM') {
      if (txtSenha.text == 'adm' || txtSenha.text == 'ADM') {
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } else {
      notifyListeners();
      return false;
    }
  }
}
