import 'package:cloud_firestore/cloud_firestore.dart';

class SeedFirestore {
  static Future<void> popularBanco() async {
    final firestore = FirebaseFirestore.instance;

    // =========================
    // Seção: Cookies Clássicos
    // =========================

    final classicosRef =
        firestore.collection('secoes').doc('classicos');

    await classicosRef.set({
      'nome': 'Cookies Clássicos',
      'descricao': 'Cookies tradicionais assados diariamente.',
      'ordem': 1,
    });

    final classicos = [
      {
        'nome': 'Cookie Tradicional',
        'descricao':
            'Cookie amanteigado com gotas de chocolate ao leite.',
        'preco': 8.00,
      },
      {
        'nome': 'Cookie Triplo Chocolate',
        'descricao':
            'Chocolate branco, ao leite e meio amargo.',
        'preco': 10.00,
      },
      {
        'nome': 'Cookie de Ovomaltine',
        'descricao':
            'Massa crocante com pedaços de Ovomaltine.',
        'preco': 10.50,
      },
      {
        'nome': 'Cookie de Chocolate Branco',
        'descricao':
            'Massa de baunilha com gotas de chocolate branco.',
        'preco': 9.00,
      },
      {
        'nome': 'Cookie de Nutella',
        'descricao':
            'Cookie tradicional com pedaços de Nutella.',
        'preco': 11.00,
      },
    ];

    for (final item in classicos) {
      await classicosRef.collection('itens').add(item);
    }

    // =========================
    // Seção: Cookies Recheados
    // =========================

    final recheadosRef =
        firestore.collection('secoes').doc('recheados');

    await recheadosRef.set({
      'nome': 'Cookies Recheados',
      'descricao': 'Cookies com recheios cremosos.',
      'ordem': 2,
    });

    final recheados = [
      {
        'nome': 'Cookie Recheado de Nutella',
        'descricao':
            'Cookie gigante recheado com Nutella cremosa.',
        'preco': 15.00,
      },
      {
        'nome': 'Cookie Recheado de Brigadeiro',
        'descricao':
            'Recheio cremoso de brigadeiro artesanal.',
        'preco': 15.00,
      },
      {
        'nome': 'Cookie Recheado de Ninho',
        'descricao':
            'Recheio cremoso de leite em pó.',
        'preco': 16.00,
      },
      {
        'nome': 'Cookie Recheado de Doce de Leite',
        'descricao':
            'Doce de leite cremoso e massa amanteigada.',
        'preco': 16.00,
      },
      {
        'nome': 'Cookie Recheado de Pistache',
        'descricao':
            'Creme de pistache premium.',
        'preco': 18.00,
      },
    ];

    for (final item in recheados) {
      await recheadosRef.collection('itens').add(item);
    }

    print('Banco populado com sucesso!');
  }
}