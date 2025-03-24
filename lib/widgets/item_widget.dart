import 'package:flutter/material.dart';
import '../model/lista_de_compras.dart';

class ItemWidget extends StatefulWidget {
  final Item item;
  final Function atualizarItem;

  const ItemWidget({Key? key, required this.item, required this.atualizarItem}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final _formKey = GlobalKey<FormState>();
  final _precoUnitarioController = TextEditingController();
  final _quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _precoUnitarioController.text = widget.item.precoUnitario.toString();
    _quantidadeController.text = widget.item.quantidade.toString();
  }

  void _salvarItem() {
    if (_formKey.currentState!.validate()) {
      widget.atualizarItem(Item(
        nome: widget.item.nome,
        checked: true,
        precoUnitario: double.parse(_precoUnitarioController.text),
        quantidade: int.parse(_quantidadeController.text),
      ));
      Navigator.pop(context);
    }
  }

  void _visualizarFormulario() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Informar preço e quantidade'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _precoUnitarioController,
                  decoration: const InputDecoration(labelText: 'Preço unitário'),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Insira o preço unitário';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantidadeController,
                        decoration: const InputDecoration(labelText: 'Quantidade'),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'Insira a quantidade';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      onPressed: () {
                        setState(() {
                          final valor = int.parse(_quantidadeController.text);
                          _quantidadeController.text = (valor >= 0 ? valor + 1 : valor).toString();
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      onPressed: () {
                        setState(() {
                          final valor = int.parse(_quantidadeController.text);
                          _quantidadeController.text = (valor > 0 ? valor - 1 : valor).toString();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: _salvarItem,
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.item.nome,
            style: TextStyle(
              decoration: widget.item.checked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        widget.item.checked
            ? Row(
              children: [
                Text('Quantidade: ${widget.item.quantidade}'),
                const SizedBox(width: 20),
                Text('Total: R\$ ${widget.item.precoUnitario * widget.item.quantidade}'),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: _visualizarFormulario, child: const Text('Editar'))
              ]
            ) : ElevatedButton(
          onPressed: _visualizarFormulario, child: const Text('Informar preço e quantidade'),
        ),
      ],
    );
  }
}
