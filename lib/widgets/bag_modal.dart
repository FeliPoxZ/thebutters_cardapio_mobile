import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/bag_controller.dart';

class BagModal extends StatefulWidget {
  const BagModal({super.key});

  @override
  State<BagModal> createState() => _BagModalState();
}

class _BagModalState extends State<BagModal> {
  final bag = GetIt.I<BagController>();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bag,
      builder: (_, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sua sacola",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  if (bag.carrinho.isNotEmpty)
                    TextButton.icon(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Limpar sacola"),
                            content: const Text(
                              "Tem certeza que deseja remover todos os itens?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  "Limpar",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          bag.limparCarrinho();
                        }
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text(
                        "Limpar",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // LISTA
              Expanded(
                child: bag.carrinho.isEmpty
                    ? const Center(child: Text("Sacola vazia"))
                    : ListView.builder(
                        itemCount: bag.carrinho.length,
                        itemBuilder: (_, index) {
                          final item = bag.carrinho[index];
                          final qtd = item.quantidade ?? 1;
                          final totalItem = item.preco * qtd;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                // TEXTO
                                Expanded(
                                  child: Text(
                                    "$qtd x ${item.txtNomeProduto}  •  R\$ ${totalItem.toStringAsFixed(2)}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                // STEPPER
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => bag.decrementar(item),
                                      icon: const Icon(Icons.remove),
                                    ),

                                    Text(qtd.toString()),

                                    IconButton(
                                      onPressed: () => bag.incrementar(item),
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),

                                // REMOVER
                                IconButton(
                                  onPressed: () => bag.removerItem(item),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 12),

              // TOTAL + FINALIZAR
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total: R\$ ${bag.totalGeral.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: bag.carrinho.isEmpty
                        ? null
                        : () {
                            debugPrint("Finalizar pedido");
                          },
                    child: const Text("Finalizar"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
