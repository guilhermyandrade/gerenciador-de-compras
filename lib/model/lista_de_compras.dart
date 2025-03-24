class ListaDeCompras {
  String nome;
  List<Item> itens;

  ListaDeCompras({required this.nome, required this.itens});
}

class Item {
  String nome;
  bool checked;
  double precoUnitario;
  int quantidade;

  Item({required this.nome, this.checked = false, this.precoUnitario = 0, this.quantidade = 0});
}
