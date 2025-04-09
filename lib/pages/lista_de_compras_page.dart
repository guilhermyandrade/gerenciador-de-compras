import 'package:flutter/material.dart';
import '../model/lista_de_compras.dart';
import '../widgets/item_widget.dart';

import '../pages/home_page.dart';

class ListaDeComprasPage extends StatefulWidget {
  final ListaDeCompras listaDeCompras;
  final Function atualizarListaDeCompras;

  const ListaDeComprasPage({
    Key? key,
    required this.listaDeCompras,
    required this.atualizarListaDeCompras,
  }) : super(key: key);

  @override
  State<ListaDeComprasPage> createState() => _ListaDeComprasPageState();
}

class _ListaDeComprasPageState extends State<ListaDeComprasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('L I S T I F Y',  style: TextStyle(color: Color(0xFFFFFFFF))),//, style: TextStyle(fontFamily: 'Jura')),
        backgroundColor: const Color(0xffFFA800),//.pink[50],
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(widget.listaDeCompras.nome),
          ),
          const Divider(),
          widget.listaDeCompras.itens.isNotEmpty
              ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.listaDeCompras.itens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ItemWidget(
                      item: widget.listaDeCompras.itens[index],
                      atualizarItem: (item) {
                        setState(() {
                          widget.listaDeCompras.itens[index] = item;
                        });
                      },
                    ),
                  ),
                  if (index < widget.listaDeCompras.itens.length - 1)
                    const Divider(),
                ],
              );
            },
          )
              : const Center(child: Text('Nenhum item na lista')),
          const Divider(),
          Text(
            'Total: R\$ ${_calcularTotal().toStringAsFixed(2)}',
          ),
          ElevatedButton(
            onPressed: () {
              for (int i = 0; i < widget.listaDeCompras.itens.length; i++) {
                // print(widget.listaDeCompras.itens[i].nome);
                widget.listaDeCompras.itens[i].quantidade = 0;
                widget.listaDeCompras.itens[i].precoUnitario = 0;
                widget.listaDeCompras.itens[i].checked = false;
              }
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.amber), //Colors.amber//Color(0xffFFA800),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Finalizar compra'),
          ),
        ],
      )
    );
  }

  double _calcularTotal() {
    if (widget.listaDeCompras.itens.isEmpty) {
      return 0.0;
    }
    return widget.listaDeCompras.itens
        .where((item) => item.checked)
        .map((item) => item.precoUnitario * item.quantidade)
        .fold(0.0, (a, b) => a + b);
  }
}