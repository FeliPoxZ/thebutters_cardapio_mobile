import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/bag_controller.dart';

class FinalizarPedidoView extends StatefulWidget {
  const FinalizarPedidoView({super.key});

  @override
  State<FinalizarPedidoView> createState() => _FinalizarPedidoViewState();
}

class _FinalizarPedidoViewState extends State<FinalizarPedidoView> {
  final ctrl = GetIt.I.get<BagController>();

  bool carregando = false;

  void _listener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ctrl.addListener(_listener);
  }

  @override
  void dispose() {
    ctrl.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(243, 236, 222, 1),
        scrolledUnderElevation: 0,
        toolbarHeight: 30,
      ),
      backgroundColor: const Color.fromRGBO(243, 236, 222, 1),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(253, 247, 237, 1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    const SizedBox(height: 15),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Seu carrinho: (${ctrl.totalItensCarrinho})',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 20),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              ctrl.limparCarrinho();
                            },
                            child: Text(
                              'Esvaziar carrinho',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(color: Colors.black38),

                    ...ctrl.carrinho.map((item) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Nome e preço do produto
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.nome,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'R\$ ${item.preco.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Botão diminuir quantidade
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  ctrl.decrementar(item);
                                },
                              ),

                              // Quantidade
                              Text(
                                '${item.quantidade}',
                                style: const TextStyle(fontSize: 16),
                              ),

                              // Botão aumentar quantidade
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  ctrl.incrementar(item);
                                },
                              ),

                              // Botão remover item
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  ctrl.removerItem(item);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    //mostrar os itens do carrinho - chat a partir dessa parte
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(243, 236, 222, 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 139, 47, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Text(
                'R\$ ${ctrl.totalGeral.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: carregando
                      ? null
                      : () async {
                          try {
                            setState(() {
                              carregando = true;
                            });

                            await ctrl.realizarPedido();

                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Pagamento foi realizado com sucesso!',
                                  style: TextStyle(color: Colors.black),
                                ),
                                backgroundColor: Colors.greenAccent,
                                duration: Duration(seconds: 5),
                              ),
                            );

                            Navigator.pop(context);
                          } catch (e) {
                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erro ao realizar pedido: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                carregando = false;
                              });
                            }
                          }
                        },
                  child: carregando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Pagar',
                          style: TextStyle(color: Colors.black),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
