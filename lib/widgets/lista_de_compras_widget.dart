import 'package:flutter/material.dart';
import '../model/lista_de_compras.dart';
import './item_widget.dart';
import '../pages/home_page.dart';

class ListaDeComprasWidget extends StatefulWidget {
  final ListaDeCompras listaDeCompras;
  final Function atualizarListaDeCompras;

  const ListaDeComprasWidget({
    Key? key,
    required this.listaDeCompras,
    required this.atualizarListaDeCompras,
  }) : super(key: key);

  @override
  State<ListaDeComprasWidget> createState() => _ListaDeComprasWidgetState();
}

class _ListaDeComprasWidgetState extends State<ListaDeComprasWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
              ),
            );
          },
          child: const Text('Finalizar compra'),
        ),
      ],
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