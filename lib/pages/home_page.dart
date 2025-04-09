import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas_si7/pages/lista_de_compras_page.dart';
import '../model/lista_de_compras.dart';
// import '../widgets/lista_de_compras_widget.dart';
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
        title: const Text('L I S T I F Y',  style: TextStyle(color: Color(0xFFFFFFFF))),//, style: TextStyle(fontFamily: 'Jura')),
        backgroundColor: const Color(0xffFFA800),//.pink[50],
        centerTitle: true,
      ),
      body: _listasDeCompras.isEmpty
          ? const Center(child: Text('Crie uma lista e monitore sua sessão de compras'))
          : ListView.builder(
        itemCount: _listasDeCompras.length,
        itemBuilder: (context, index) {
          if (index < _listasDeCompras.length) {
           return TextButton(
                 style: TextButton.styleFrom(
                   padding: const EdgeInsets.symmetric(vertical: 16),
                   minimumSize: const Size(double.infinity, 50)
                 ),
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => ListaDeComprasPage(
                           listaDeCompras: _listasDeCompras[index],
                           atualizarListaDeCompras: () {}
                           // atualizarListaDeCompras: (listaDeCompras) {
                           //   setState(() {
                           //     _listasDeCompras[index] = listaDeCompras;
                           //   });
                           // }
                       ),
                     ),
                   );
                 },
                 child: Text(_listasDeCompras[index].nome, style: const TextStyle(fontSize: 18)),
               );


            // return
            // ListaDeComprasWidget(
            //  listaDeCompras: _listasDeCompras[index],
            //  atualizarListaDeCompras: (listaDeCompras) {
            //    setState(() {
            //      _listasDeCompras[index] = listaDeCompras;
            //    });
            //  },
            // );

          } else {
            return const SizedBox();
          }
        },
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFFA800),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CriaListaDeComprasPage(_adicionarListaDeCompras),
            ),
          );
        },
        tooltip: 'Adicionar lista de compras',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}