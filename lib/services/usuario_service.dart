import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Variáveis que vão guardar os dados na sessão
  String? uid;
  String? nome;
  String? email;
  String? telefone;

  // Getters para facilitar a leitura no app
  bool get estaLogado => uid != null;

  // Função para carregar os dados do Firestore para a memória
  Future<void> carregarSessao() async {
    User? userAtual = _auth.currentUser;

    if (userAtual != null) {
      //Verifica se tem alguma conta logada
      uid = userAtual.uid;
      email = userAtual.email;

      try {
        // Busca o documento do usuário usando o UID na coleção do Firestore
        DocumentSnapshot doc = await _firestore
            .collection('usuarios')
            .doc(uid)
            .get();

        if (doc.exists && doc.data() != null) {
          Map<String, dynamic> dados = doc.data() as Map<String, dynamic>;
          nome = dados['nome'];
          telefone = dados['telefone'];
        }
      } catch (e) {
        print("Erro ao carregar dados do usuário no Firestore: $e");
      }
      notifyListeners(); // Avisa o app que os dados mudaram
    }
  }

  // Função para limpar a sessão quando o usuário deslogar (Sair)
  Future<void> deslogar() async {
    await _auth.signOut();
    uid = null;
    nome = null;
    email = null;
    telefone = null;
    notifyListeners();
  }
}
