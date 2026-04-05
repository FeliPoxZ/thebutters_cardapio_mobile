import 'package:flutter/material.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';

class BagController extends ChangeNotifier {

  List<ItemModel> carrinho = [];

  void adicionarItem(ItemModel item) {
    carrinho.add(item);
    notifyListeners(); // atualiza a UI
  }

  void removerItem(ItemModel item) {
    carrinho.remove(item);
    notifyListeners();
  }

  void limparCarrinho(){
    carrinho.clear();
    notifyListeners();
  }

}