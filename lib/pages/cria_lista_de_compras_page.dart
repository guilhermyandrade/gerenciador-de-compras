import 'package:flutter/material.dart';
import '../model/lista_de_compras.dart';

class CriaListaDeComprasPage extends StatefulWidget {
  final Function adicionarListaDeCompras;

  const CriaListaDeComprasPage(this.adicionarListaDeCompras, {Key? key}) : super(key: key);

  @override
  State<CriaListaDeComprasPage> createState() => _CriaListaDeComprasPageState();
}

class _CriaListaDeComprasPageState extends State<CriaListaDeComprasPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _itemController = TextEditingController();
  List<Item> _itens = [];

  void _adicionarItem() {
    setState(() {
      if (_itemController.text.isNotEmpty) {
        _itens.add(Item(nome: _itemController.text));
        _itemController.clear();
      }
    });
  }

  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  void _criarListaDeCompras() {
    if (_formKey.currentState!.validate() && _itens.isNotEmpty) {
      widget.adicionarListaDeCompras(ListaDeCompras(nome: _nomeController.text, itens: _itens));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Lista de Compras'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da lista'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'teste';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _itemController,
                      decoration: const InputDecoration(labelText: 'Item'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _adicionarItem,
                    child: const Text('Adicionar item'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _itens.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_itens[index].nome),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removerItem(index),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _criarListaDeCompras,
                child: const Text('Criar lista de compras'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
