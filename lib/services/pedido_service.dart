import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';

class PedidoService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> criarPedido({
    required String usuarioId,
    required String usuarioNome,
    required List<ItemModel> itens,
    required double precoTotal,
  }) async {
    await _firestore.collection('pedidos').add({
      'usuario': {'id': usuarioId, 'nome': usuarioNome},
      'itens': itens.map((item) {
        return {
          'id': item.id,
          'nome': item.nome,
          'descricao': item.descricao,
          'preco': item.preco,
          'quantidade': item.quantidade ?? 1,
        };
      }).toList(),
      'preco': precoTotal,
      'status': 'Em Preparação',
      'dataCriacao': FieldValue.serverTimestamp(),
    });
  }
}
