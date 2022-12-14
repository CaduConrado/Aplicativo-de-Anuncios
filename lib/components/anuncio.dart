// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:aplicativo_anuncios/components/shopp_cart_anuncio.dart';
import 'package:aplicativo_anuncios/data/anuncio_dao.dart';
import 'package:aplicativo_anuncios/data/shopping_cart_dao.dart';
import 'package:flutter/material.dart';

class ShopCartAnuncio extends StatefulWidget {
  final String nomeProduto;
  final String foto;
  final String detalhes;
  final double preco;
  const ShopCartAnuncio({
    Key? key,
    required this.foto,
    required this.detalhes,
    required this.preco,
    required this.nomeProduto,
  }) : super(key: key);

  @override
  State<ShopCartAnuncio> createState() => _ShopCartAnuncioState();
}

class _ShopCartAnuncioState extends State<ShopCartAnuncio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 2,
                color: Colors.black38,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    width: 80,
                    height: 90,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          widget.foto,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.nomeProduto,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          widget.detalhes,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'R\$ ${widget.preco.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onLongPress: () {
                      AnuncioDao().delete(widget.nomeProduto);
                    },
                    onPressed: () {
                      ShoppingCartDao().save(ShoppCartAnuncio(
                          foto: widget.foto,
                          detalhes: widget.detalhes,
                          preco: widget.preco,
                          nomeProduto: widget.nomeProduto));
                    },
                    child: const Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}


// Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4),
//                 border: Border.all(width: 3, color: Colors.black45),
//                 color: Colors.white),
//             height: 100,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     width: 80,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(4),
//                       child: Image.network(
//                         widget.foto,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       widget.nomeProduto,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child:  Text(
//                               'Controle Gamer',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {},
//                             child: const Icon(
//                               Icons.add_shopping_cart_rounded,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )
