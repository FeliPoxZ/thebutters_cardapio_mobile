import 'package:flutter/material.dart';

class CardapioController {
  final ScrollController scrollController = ScrollController();

  final double headerHeight;
  final double navbarHeight;

  double scrollOffset = 0;

  late List<GlobalKey> sectionKeys;

  CardapioController({
    required this.headerHeight,
    required this.navbarHeight,
  });

  // inicializa com quantidade de seções (API futuramente)
  //TODO: Seções vindas da API
  void init(int sectionCount) {
    sectionKeys = List.generate(sectionCount, (_) => GlobalKey());

    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
    });
  }

  // posição da navbar
  double getNavbarTop(double statusBar) {
    final navbarTopPosition = headerHeight - scrollOffset;

    return navbarTopPosition
        .clamp(statusBar, double.infinity)
        .roundToDouble();
  }

  // se está fixa
  bool isSticky(double statusBar) {
    return getNavbarTop(statusBar) == statusBar;
  }

  // scroll para seção
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