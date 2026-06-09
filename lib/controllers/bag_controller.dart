import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';
import 'package:thebutters_cardapio_mobile/services/pedido_service.dart';
import 'package:thebutters_cardapio_mobile/services/usuario_service.dart';

class BagController extends ChangeNotifier {
  List<ItemModel> carrinho = [];

  final _pedidoService = GetIt.I<PedidoService>();
  final _usuarioService = GetIt.I<UsuarioService>();

  /// Adiciona um item ao carrinho
  /// Se já existir, aumenta a quantidade
  void adicionarItem(ItemModel item) {
    final index = carrinho.indexWhere((i) => i.nome == item.nome);

    if (index != -1) {
      final existente = carrinho[index];
      final novaQuantidade =
          (existente.quantidade ?? 1) + (item.quantidade ?? 1);

      carrinho[index] = existente.copyWith(quantidade: novaQuantidade);
    } else {
      carrinho.add(item);
    }

    notifyListeners();
  }

  void removerItem(ItemModel item) {
    carrinho.removeWhere((i) => i.nome == item.nome);
    notifyListeners();
  }

  void incrementar(ItemModel item) {
    final index = carrinho.indexOf(item);
    if (index != -1) {
      final atual = carrinho[index];
      final novaQtd = (atual.quantidade ?? 1) + 1;

      carrinho[index] = atual.copyWith(quantidade: novaQtd);
      notifyListeners();
    }
  }

  void decrementar(ItemModel item) {
    final index = carrinho.indexOf(item);
    if (index != -1) {
      final atual = carrinho[index];
      final qtdAtual = atual.quantidade ?? 1;

      if (qtdAtual > 1) {
        carrinho[index] = atual.copyWith(quantidade: qtdAtual - 1);
      } else {
        carrinho.removeAt(index);
      }

      notifyListeners();
    }
  }

  void limparCarrinho() {
    carrinho.clear();
    notifyListeners();
  }

  Future<void> realizarPedido() async {
    if (carrinho.isEmpty) {
      throw Exception('Carrinho vazio');
    }

    final uid = _usuarioService.uid;
    final nome = _usuarioService.nome;

    if (uid == null || nome == null) {
      throw Exception('Usuário não autenticado');
    }

    await _pedidoService.criarPedido(
      usuarioId: uid,
      usuarioNome: nome,
      itens: carrinho,
      precoTotal: totalGeral,
    );

    limparCarrinho();
  }

  /// Retorna a quantidade total de itens (somando todas as quantidades)
  int get totalItensCarrinho {
    return carrinho.fold(0, (sum, i) => sum + (i.quantidade ?? 1));
  }

  double get totalGeral {
    double total = 0;
    for (var item in carrinho) {
      total += item.preco * (item.quantidade ?? 1);
    }
    return total;
  }
}
