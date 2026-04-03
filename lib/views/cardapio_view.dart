import 'package:flutter/material.dart';

class CardapioView extends StatefulWidget {
  const CardapioView({super.key});

  @override
  State<CardapioView> createState() => _CardapioViewState();
}

class _CardapioViewState extends State<CardapioView> {
  final ScrollController _controller = ScrollController();

  static const double headerHeight = 150;
  static const double navbarHeight = 100;

  double scrollOffset = 0;

  // TODO: Keys dinamicas via API
  // keys das seções
  final List<GlobalKey> sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        scrollOffset = _controller.offset;
      });
    });
  }

  /* Scroll para seção do cardápio */
  void scrollToSection(int index) {
    final context = sectionKeys[index].currentContext;

    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;

    final position = box.localToGlobal(Offset.zero);

    final offset = position.dy + _controller.offset;

    // compensa header + navbar overlay
    final target = offset - headerHeight - navbarHeight;

    _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;

    final navbarTopPosition = headerHeight - scrollOffset;

    final top = navbarTopPosition
        .clamp(statusBar, double.infinity)
        .roundToDouble();

    final isSticky = top == statusBar;

    return Scaffold(
      body: Stack(
        children: [
          // SCROLL PRINCIPAL
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                // HEADER
                Container(
                  height: headerHeight,
                  color: Colors.red.shade200,
                  alignment: Alignment.center,
                  child: const Text('HEADER', style: TextStyle(fontSize: 24)),
                ),

                // BODY com padding
                Padding(
                  padding: const EdgeInsets.only(top: navbarHeight),
                  child: Column(
                    children: List.generate(5, (sectionIndex) {
                      return Container(
                        key: sectionKeys[sectionIndex],
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // título da seção
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Seção $sectionIndex',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // 4 itens
                            ...List.generate(
                              4,
                              (i) => Container(
                                height: 80,
                                margin: const EdgeInsets.all(8),
                                color: Colors.orange.shade200,
                                alignment: Alignment.center,
                                child: Text(
                                  'Item $sectionIndex - $i',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // NAVBAR
          Positioned(
            top: top - 1,
            left: 0,
            right: 0,
            child: Container(
              height: navbarHeight,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                boxShadow: isSticky
                    ? [
                        const BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 2),
                          color: Colors.black26,
                        ),
                      ]
                    : [],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => scrollToSection(index),
                    child: Container(
                      width: 120,
                      margin: const EdgeInsets.all(8),
                      color: Colors.blue.shade400,
                      alignment: Alignment.center,
                      child: Text(
                        'Seção $index',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // STATUS BAR
          Container(
            height: statusBar,
            color: isSticky ? Colors.blue.shade200 : Colors.red.shade200,
          ),
        ],
      ),
    );
  }
}
