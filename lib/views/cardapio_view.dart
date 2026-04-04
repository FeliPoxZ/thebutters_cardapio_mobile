import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/cardapio_controller.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_colors.dart';
import 'package:thebutters_cardapio_mobile/widgets/item_widget.dart';
import 'package:thebutters_cardapio_mobile/widgets/round_button_widget.dart';

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
    final width = MediaQuery.sizeOf(context).width;

    final top = controller.getNavbarTop(statusBar);
    final isSticky = controller.isSticky(statusBar);

    return Scaffold(
      body: Stack(
        children: [
          // SCROLL PRINCIPAL
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  // HEADER
                  Container(
                    height: controller.headerHeight,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          height: controller.headerHeight * 0.55,
                          color: AppColors.banner,
                        ),
                        Divider(
                          thickness: 4,
                          height: 4,
                          color: AppColors.secondary,
                        ),
                        SizedBox(
                          height: controller.headerHeight * 0.2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(0, -20),
                                      child: Container(
                                        padding: const EdgeInsets.all(1),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "The Butters",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.foreground.withValues(
                                          alpha: 0.75,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    RoundButtonWidget(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "Sobre");
                                      },
                                      icon: const Icon(
                                        Icons.account_circle_outlined,
                                        color: AppColors.extraOrange,
                                        size: 30,
                                      ),
                                    ),
                                    RoundButtonWidget(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "Sobre");
                                      },
                                      icon: const Icon(
                                        Icons.info_outline,
                                        color: AppColors.extraOrange,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: Color.fromARGB(255, 190, 190, 190),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // BODY
                  Padding(
                    padding: EdgeInsets.only(top: controller.navbarHeight),
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Seção $sectionIndex',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.foreground.withValues(
                                          alpha: 0.75,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsGeometry.only(
                                        top: 6,
                                      ),
                                      child: Divider(
                                        thickness: 1,
                                        height: 1,
                                        color: Color.fromARGB(
                                          255,
                                          190,
                                          190,
                                          190,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 4 itens
                              ...List.generate(
                                4,
                                (i) => ItemWidget(
                                  title: 'Item ${i + 1}',
                                  description:
                                      'Descrição do item ${i + 1} da seção $sectionIndex',
                                  price: 10,
                                  onTap: () {
                                    debugPrint(
                                      'Clicou no Item ${i + 1} da seção $sectionIndex',
                                    );
                                  },
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
                color: AppColors.primary,
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
                      alignment: Alignment.center,
                      child: Text(
                        'Seção $index',
                        style: TextStyle(
                          color: AppColors.lightForeground,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
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
            color: isSticky ? AppColors.primary : AppColors.banner,
          ),
        ],
      ),
    );
  }
}
