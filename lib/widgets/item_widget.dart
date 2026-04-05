import 'package:flutter/material.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_colors.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';
import 'package:thebutters_cardapio_mobile/widgets/item_modal.dart';

// WIDGET
class ItemWidget extends StatelessWidget {
  final ItemModel item;

  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: AppColors.item,
            builder: (_) => ItemModal(item: item),
          );
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
                // TEXTO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TÍTULO
                      Text(
                        item.txtNomeProduto,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.foreground.withValues(alpha: 0.6),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // DESCRIÇÃO
                      Text(
                        item.descricao,
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // PREÇO
                      Text(
                        'R\$ ${item.preco.toStringAsFixed(2)}',
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

                // TODO: IMAGEM
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
