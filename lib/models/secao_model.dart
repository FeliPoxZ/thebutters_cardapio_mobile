import 'package:thebutters_cardapio_mobile/models/item_model.dart';

class SecaoModel {
  final String id;
  final String nome;
  final String descricao;
  final int ordem;
  List<ItemModel> itens;

  SecaoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.ordem,
    this.itens = const [],
  });

  factory SecaoModel.fromMap(String id, Map<String, dynamic> map) {
    return SecaoModel(
      id: id,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      ordem: map['ordem'] ?? 0,
    );
  }
}
