import 'package:aplicativo_anuncios/data/anuncio_dao.dart';
import 'package:aplicativo_anuncios/screens/shopping_cart.dart';
import 'package:flutter/material.dart';

import '../components/anuncio.dart';
import 'form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          'App Anúncios',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contextNew) => ShoppingCart(
                    shoppingContext: context,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<ShopCartAnuncio>>(
          future: AnuncioDao().findAll(),
          builder: (context, snapshot) {
            List<ShopCartAnuncio>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando'),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregado'),
                    ],
                  ),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ShopCartAnuncio anuncio = items[index];
                          return anuncio;
                        });
                  }
                  return Center(
                    child: Column(children: const [
                      Icon(
                        Icons.error_outline,
                        size: 128,
                      ),
                      Text(
                        'Não há nenhum Anúncio',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      )
                    ]),
                  );
                }
                return const Text('Erro ao carregar anuncios');
            }
            return const Text('Erro desconhecido');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                anuncioContext: context,
              ),
            ),
          ).then((value) => setState((() {})));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
