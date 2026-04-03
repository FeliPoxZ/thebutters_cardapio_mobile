import 'package:flutter/material.dart';

class CardapioView extends StatelessWidget {
  const CardapioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // HEADER
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              color: Colors.red.shade200,
              alignment: Alignment.center,
              child: const Text('HEADER', style: TextStyle(fontSize: 24)),
            ),
          ),

          // NAVBAR STICKY
          SliverPersistentHeader(pinned: true, delegate: _NavbarDelegate()),

          // BODY DINÂMICO
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.orange.shade200,
                alignment: Alignment.center,
                child: Text(
                  'Item $index',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }, childCount: 30),
          ),
        ],
      ),
    );
  }
}

// DELEGATE DA NAVBAR
class _NavbarDelegate extends SliverPersistentHeaderDelegate {
  static const double navbarHeight = 100;

  @override
  double get minExtent => navbarHeight;

  @override
  double get maxExtent =>
      navbarHeight + WidgetsBinding.instance.window.padding.top;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final topPadding = MediaQuery.of(context).padding.top;

    // progresso (0 → 1)
    final t = (shrinkOffset / topPadding).clamp(0.0, 1.0);

    final extraTop = topPadding * t;

    return Stack(
      children: [
        // 🔵 FUNDO (cresce pra cima)
        Container(
          color: Colors.blue.shade200,
        ),

        // 🔥 NAVBAR FIXA (não é empurrada)
        Positioned(
          top: extraTop,
          left: 0,
          right: 0,
          child: SizedBox(
            height: navbarHeight + extraTop,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.all(8),
                  color: Colors.blue.shade400,
                  alignment: Alignment.center,
                  child: Text(
                    'Tab $index',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}