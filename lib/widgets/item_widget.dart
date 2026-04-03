import 'package:flutter/material.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_colors.dart';

class ItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final VoidCallback? onTap;

  const ItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          debugPrint('Clicou em $title');
          if (onTap != null) onTap!();
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: AppColors.item,
            padding: const EdgeInsets.all(12),
            height: 120,
            child: Row(
              children: [
                // TEXTO (EXPANDE)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TÍTULO
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.foreground.withValues(alpha: 0.6)
                        ),
                      ),

                      const SizedBox(height: 6),

                      // DESCRIÇÃO
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // PREÇO
                      Text(
                        'R\$ ${price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // IMAGEM 
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text('IMAGEM'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}