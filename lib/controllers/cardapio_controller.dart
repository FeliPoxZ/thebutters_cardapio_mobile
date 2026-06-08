import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/models/secao_model.dart';
import 'package:thebutters_cardapio_mobile/services/item_service.dart';
import 'package:thebutters_cardapio_mobile/services/secao_service.dart';

class CardapioController {
  final ScrollController scrollController = ScrollController();

  final double headerHeight;
  final double navbarHeight;

  double scrollOffset = 0;

  late List<GlobalKey> sectionKeys;

  List<SecaoModel> secoes = [];

  final _secaoService = GetIt.I<SecaoService>();
  final _itemService = GetIt.I<ItemService>();

  CardapioController({
    required this.headerHeight,
    required this.navbarHeight,
  });

  Future<void> init() async {
    // Busca todas as seções
    secoes = await _secaoService.buscarSecoes();

    // Busca os itens de cada seção
    for (final secao in secoes) {
      secao.itens = await _itemService.buscarItensDaSecao(
        secao.id,
      );
    }

    // Cria as chaves para scroll
    sectionKeys = List.generate(
      secoes.length,
      (_) => GlobalKey(),
    );

    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
    });
  }

  double getNavbarTop(double statusBar) {
    final navbarTopPosition = headerHeight - scrollOffset;

    return navbarTopPosition
        .clamp(statusBar, double.infinity)
        .roundToDouble();
  }

  bool isSticky(double statusBar) {
    return getNavbarTop(statusBar) == statusBar;
  }

  void scrollToSection(int index) {
    final context = sectionKeys[index].currentContext;

    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;

    final position = box.localToGlobal(Offset.zero);

    final offset = position.dy + scrollController.offset;

    final target = offset - headerHeight - navbarHeight;

    scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void dispose() {
    scrollController.dispose();
  }
}