import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/login_controller.dart';
import 'package:thebutters_cardapio_mobile/views/cadastro_view.dart';
import 'package:thebutters_cardapio_mobile/views/login_view.dart';

final g = GetIt.instance;


void main() {

  g.registerSingleton<LoginController>(LoginController());
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
      debugShowCheckedModeBanner: false,
      title: 'TheButters',

      //
      //Tabela de rotas
      //
      initialRoute: 'Login',
      routes: {
        'Login': (context) => LoginView(),
        'Cadastro': (context) => CadastroView()
      },
    );
  }
}

//teste1
