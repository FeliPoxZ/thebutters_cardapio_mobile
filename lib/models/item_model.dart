class ItemModel {
  final String id;
  final String nome;
  final double preco;
  final String descricao;
  final int? quantidade;

  ItemModel({
    required this.id,
    required this.nome,
    required this.preco,
    required this.descricao,
    this.quantidade,
  });

  factory ItemModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return ItemModel(
      id: id,
      nome: map['nome'] ?? '',
      preco: (map['preco'] ?? 0).toDouble(),
      descricao: map['descricao'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'preco': preco,
      'descricao': descricao,
    };
  }

  ItemModel copyWith({
    int? quantidade,
  }) {
    return ItemModel(
      id: id,
      nome: nome,
      preco: preco,
      descricao: descricao,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}