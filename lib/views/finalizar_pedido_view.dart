import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/bag_controller.dart';
import 'package:thebutters_cardapio_mobile/models/item_model.dart';


class FinalizarPedidoView extends StatefulWidget {
  const FinalizarPedidoView({super.key});

  @override
  State<FinalizarPedidoView> createState() => _FinalizarPedidoViewState();
}

class _FinalizarPedidoViewState extends State<FinalizarPedidoView> {
  final ctrl = GetIt.I.get<BagController>();



  void _listener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ctrl.addListener(_listener);


      // 🔹 Adicionando dois itens de teste
    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Hambúrguer1",
      preco: 15.0,
      descricao: "Hambúrguer artesanal1",
      quantidade: 1,
    ));

    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Batata Frita1",
      preco: 8.0,
      descricao: "Porção média1",
      quantidade: 2,
    ));

          // 🔹 Adicionando dois itens de teste
    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Hambúrguer2",
      preco: 15.0,
      descricao: "Hambúrguer artesanal2",
      quantidade: 1,
    ));

    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Batata Frita2",
      preco: 8.0,
      descricao: "Porção média2",
      quantidade: 2,
    ));

          // 🔹 Adicionando dois itens de teste
    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Hambúrguer3",
      preco: 15.0,
      descricao: "Hambúrguer artesanal3",
      quantidade: 1,
    ));

    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Batata Frita3",
      preco: 8.0,
      descricao: "Porção média3",
      quantidade: 2,
    ));
    
          // 🔹 Adicionando dois itens de teste
    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Hambúrguer4",
      preco: 15.0,
      descricao: "Hambúrguer artesanal4",
      quantidade: 1,
    ));

    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Batata Frita4",
      preco: 8.0,
      descricao: "Porção média4",
      quantidade: 2,
    ));

          // 🔹 Adicionando dois itens de teste
    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Hambúrguer5",
      preco: 15.0,
      descricao: "Hambúrguer artesanal5",
      quantidade: 1,
    ));

    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Batata Frita5",
      preco: 8.0,
      descricao: "Porção média5",
      quantidade: 2,
    ));

          // 🔹 Adicionando dois itens de teste
    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Hambúrguer",
      preco: 15.0,
      descricao: "Hambúrguer artesanal",
      quantidade: 1,
    ));

    ctrl.adicionarItem(ItemModel(
      txtNomeProduto: "Batata Frita",
      preco: 8.0,
      descricao: "Porção média",
      quantidade: 2,
    ));
  }

  @override
  void dispose() {
    ctrl.removeListener(_listener); // ⚠️ MUITO IMPORTANTE
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

      // ✅ BODY CORRIGIDO
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
                    )
                  ],
                ),
                child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    const SizedBox(height: 15),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Seu carrinho: (${ctrl.totalItensCarrinho()})',
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
                                borderRadius: BorderRadius.circular(8)
                              )
                            ),
                            onPressed: () {
                              ctrl.limparCarrinho();
                            },
                            child: Text(
                              'Esvaziar carrinho',
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const Divider(color: Colors.black38),

                    ...ctrl.carrinho.map((item) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
                                      item.txtNomeProduto,
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
                                  ctrl.diminuirQuantidade(item);
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
                                  ctrl.aumentarQuantidade(item);
                                },
                              ),

                              // Botão remover item
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.redAccent),
                                onPressed: () {
                                  ctrl.removerItem(item);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                    //mostrar os itens do carrinho - chat a partir dessa parte

                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ✅ BOTTOM CORRIGIDO
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
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),                  
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // 💰 TOTAL DINÂMICO
              Text(
                'R\$ ${ctrl.totalCarrinho().toStringAsFixed(2)}',
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
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  onPressed: () {
                    ctrl.limparCarrinho();
                    final snackBar = SnackBar(
                      content: Text(
                        'Pagamento foi realizado com sucesso!',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                      backgroundColor: Colors.greenAccent,
                      duration: Duration(seconds: 5),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text(
                    'Pagar',
                    style: TextStyle(
                      color: Colors.black
                    ),
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