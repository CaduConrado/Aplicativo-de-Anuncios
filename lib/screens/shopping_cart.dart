import 'package:aplicativo_anuncios/components/shopp_cart_anuncio.dart';
import 'package:aplicativo_anuncios/data/shopping_cart_dao.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key, required this.shoppingContext});
  final BuildContext shoppingContext;
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<ShoppCartAnuncio>>(
          future: ShoppingCartDao().findAll(),
          builder: (context, snapshot) {
            List<ShoppCartAnuncio>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregado'),
                    ],
                  ),
                );
                break;
              case ConnectionState.waiting:
                Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregado'),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregado')
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
                        final ShoppCartAnuncio anuncio = items[index];
                        return anuncio;
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                        ),
                        Text(
                          'Não há nenhum Anuncio no Carrinho',
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const Text('Erro ao carregar carrinho');
            }
            return const Text('Erro desconhecido');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
