import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thebutters_cardapio_mobile/models/secao_model.dart';

class SecaoService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<SecaoModel>> buscarSecoes() async {
    final snapshot = await _firestore
        .collection('secoes')
        .orderBy('ordem')
        .get();

    return snapshot.docs.map((doc) {
      return SecaoModel.fromMap(
        doc.id,
        doc.data(),
      );
    }).toList();
  }
}