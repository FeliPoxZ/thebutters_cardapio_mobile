import 'package:flutter/material.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';

class BagController extends ChangeNotifier {

  
  List<ItemModel> carrinho = [];

  /// Adiciona um item ao carrinho
  /// Se já existir, aumenta a quantidade
  void adicionarItem(ItemModel item) {
    final index = carrinho.indexWhere((i) => i.txtNomeProduto == item.txtNomeProduto);
    if (index != -1) {
      carrinho[index].quantidade += item.quantidade > 0 ? item.quantidade : 1;
    } else {
      carrinho.add(ItemModel(
        txtNomeProduto: item.txtNomeProduto,
        preco: item.preco,
        descricao: item.descricao,
        quantidade: item.quantidade > 0 ? item.quantidade : 1,
      ));
    }
    notifyListeners();
  }

  /// Remove completamente um item do carrinho
  void removerItem(ItemModel item) {
    carrinho.removeWhere((i) => i.txtNomeProduto == item.txtNomeProduto);
    notifyListeners();
  }

  /// Limpa todo o carrinho
  void limparCarrinho() {
    carrinho.clear();
    notifyListeners();
  }

  /// Aumenta a quantidade de um item
  void aumentarQuantidade(ItemModel item) {
    final index = carrinho.indexWhere((i) => i.txtNomeProduto == item.txtNomeProduto);
    if (index != -1) {
      carrinho[index].quantidade += 1;
      notifyListeners();
    }
  }

  /// Diminui a quantidade de um item
  /// Se a quantidade chegar a 0, remove o item
  void diminuirQuantidade(ItemModel item) {
    final index = carrinho.indexWhere((i) => i.txtNomeProduto == item.txtNomeProduto);
    if (index != -1) {
      if (carrinho[index].quantidade > 1) {
        carrinho[index].quantidade -= 1;
      } else {
        carrinho.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Retorna a quantidade total de itens (somando todas as quantidades)
  int totalItensCarrinho() {
    return carrinho.fold(0, (sum, i) => sum + i.quantidade);
  }

  /// Retorna o total do carrinho considerando preço * quantidade
  double totalCarrinho() {
    return carrinho.fold(0, (sum, i) => sum + (i.preco * i.quantidade));
  }
}