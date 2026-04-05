import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/bag_controller.dart';
import 'package:thebutters_cardapio_mobile/controllers/cardapio_controller.dart';
import 'package:thebutters_cardapio_mobile/controllers/login_controller.dart';
import 'package:thebutters_cardapio_mobile/controllers/cadastro_controller.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_theme.dart';
import 'package:thebutters_cardapio_mobile/views/cadastro_view.dart';
import 'package:thebutters_cardapio_mobile/views/cardapio_view.dart';
import 'package:thebutters_cardapio_mobile/views/esqueceu_senha_view.dart';
import 'package:thebutters_cardapio_mobile/views/finalizar_pedido_view.dart';
import 'package:thebutters_cardapio_mobile/views/login_view.dart';
import 'package:thebutters_cardapio_mobile/views/sobre_view.dart';

final g = GetIt.instance;


void main() {

  g.registerSingleton<LoginController>(LoginController());
  g.registerSingleton<CadastroController>(CadastroController());
  g.registerSingleton<CardapioController>(CardapioController(headerHeight: 300, navbarHeight: 50));
  g.registerSingleton<BagController>(BagController());
  
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      title: 'TheButters',

      //
      //Tabela de rotas
      //
      initialRoute: 'Login',
      routes: {
        'Login': (context) => LoginView(),
        'Cadastro': (context) => CadastroView(),
        'Cardapio': (context) => CardapioView(),
        'Sobre': (context) => SobreView(),
        'EsqueceuSenha': (context) => EsqueceuSenhaView(),
        'FinalizarPedido': (context) => FinalizarPedidoView()
      },
    );
  }
}
