import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';

class ItemService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<ItemModel>> buscarItensDaSecao(
    String secaoId,
  ) async {
    final snapshot = await _firestore
        .collection('secoes')
        .doc(secaoId)
        .collection('itens')
        .get();

    return snapshot.docs.map((doc) {
      return ItemModel.fromMap(
        doc.id,
        doc.data(),
      );
    }).toList();
  }
}