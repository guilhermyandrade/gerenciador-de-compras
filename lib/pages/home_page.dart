import 'package:flutter/material.dart';
import '../model/lista_de_compras.dart';
import '../widgets/lista_de_compras_widget.dart';
import './cria_lista_de_compras_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListaDeCompras> _listasDeCompras = [];

  void _adicionarListaDeCompras(ListaDeCompras listaDeCompras) {
    setState(() {
      _listasDeCompras.add(listaDeCompras);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Compras'),
        backgroundColor: Colors.pink[50],
        centerTitle: true,
      ),
      body: _listasDeCompras.isEmpty
          ? const Center(child: Text('Crie uma lista e monitore sua sessão de compras'))
          : ListView.builder(
        itemCount: _listasDeCompras.length,
        itemBuilder: (context, index) {
          if (index < _listasDeCompras.length) {
           return ListaDeComprasWidget(
              listaDeCompras: _listasDeCompras[index],
              atualizarListaDeCompras: (listaDeCompras) {
                setState(() {
                  _listasDeCompras[index] = listaDeCompras;
                });
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CriaListaDeComprasPage(_adicionarListaDeCompras),
            ),
          );
        },
        tooltip: 'Adicionar lista de compras',
        child: const Icon(Icons.add),
      ),
    );
  }
}