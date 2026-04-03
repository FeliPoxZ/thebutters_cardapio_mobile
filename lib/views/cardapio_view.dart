import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/cardapio_controller.dart';


class CardapioView extends StatefulWidget {
  const CardapioView({super.key});

  @override
  State<CardapioView> createState() => _CardapioViewState();
}

class _CardapioViewState extends State<CardapioView> {
  final controller = GetIt.I<CardapioController>();

  @override
  void initState() {
    super.initState();

    controller.init(5); // quantidade de seções (simula API)

    controller.scrollController.addListener(() {
      setState(() {}); 
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;

    final top = controller.getNavbarTop(statusBar);
    final isSticky = controller.isSticky(statusBar);

    return Scaffold(
      body: Stack(
        children: [
          // SCROLL PRINCIPAL
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  // HEADER
                  Container(
                    height: controller.headerHeight,
                    color: Colors.red.shade200,
                    alignment: Alignment.center,
                    child: const Text(
                      'HEADER',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),

                  // BODY
                  Padding(
                    padding: EdgeInsets.only(
                      top: controller.navbarHeight,
                    ),
                    child: Column(
                      children: List.generate(5, (sectionIndex) {
                        return Container(
                          key: controller.sectionKeys[sectionIndex],
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // título
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
          ),

          // NAVBAR
          Positioned(
            top: top - 1,
            left: 0,
            right: 0,
            child: Container(
              height: controller.navbarHeight,
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
                    onTap: () => controller.scrollToSection(index),
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
            color: isSticky
                ? Colors.blue.shade200
                : Colors.red.shade200,
          ),
        ],
      ),
    );
  }
}