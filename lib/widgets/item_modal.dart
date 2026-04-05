import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/bag_controller.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_colors.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';

class ItemModal extends StatefulWidget {
  final ItemModel item;

  const ItemModal({super.key, required this.item});

  @override
  State<ItemModal> createState() => _ItemModalState();
}

class _ItemModalState extends State<ItemModal> {
  int quantidade = 1;

  @override
  Widget build(BuildContext context) {
    final total = widget.item.preco * quantidade;
    final bagController = GetIt.I<BagController>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // IMAGEM
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Text('IMAGEM'),
            ),

            const SizedBox(height: 12),

            // TÍTULO
            Text(
              widget.item.txtNomeProduto,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // DESCRIÇÃO
            Text(widget.item.descricao, textAlign: TextAlign.center),

            const SizedBox(height: 12),

            // PREÇO UNITÁRIO
            Text(
              'R\$ ${widget.item.preco.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),

            const SizedBox(height: 16),

            // STEPPER + BOTÃO
            Row(
              children: [
                // STEPPER
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: quantidade > 1
                            ? () {
                                setState(() => quantidade--);
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                      ),

                      Text(
                        quantidade.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),

                      IconButton(
                        onPressed: quantidade < 99
                            ? () {
                                setState(() => quantidade++);
                              }
                            : null,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // BOTÃO
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary, // cor de fundo
                      foregroundColor: Colors.white, // cor do texto
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      final itemComQuantidade = widget.item.copyWith(
                        quantidade: quantidade,
                      );

                      bagController.adicionarItem(itemComQuantidade);

                      Navigator.pop(context);
                    },
                    child: Text('Adicionar • R\$ ${total.toStringAsFixed(2)}'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
