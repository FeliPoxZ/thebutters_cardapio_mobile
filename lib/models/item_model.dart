//TODO: adaptar para api
class ItemModel {
  final String txtNomeProduto;
  final double preco;
  final String descricao;
  final int? quantidade;

  ItemModel({
    required this.txtNomeProduto,
    required this.preco,
    required this.descricao,
    this.quantidade,
  });

  ItemModel copyWith({int? quantidade}) {
    return ItemModel(
      txtNomeProduto: txtNomeProduto,
      preco: preco,
      descricao: descricao,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}
