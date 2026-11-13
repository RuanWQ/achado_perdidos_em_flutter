enum Categoria { eletronico, material, roupa, documento, outro }

// TAREFA 1 (Aulas 04 e 05): complete a classe Item.
class Item {
  // a) Atributos: nome, local e data (String), categoria (Categoria)
  //    e devolvido (bool).
  final String nome;
  final String local;
  final String data;
  final Categoria categoria;
  bool devolvido;

  // b) Construtor: nome, local, data e categoria obrigatórios e
  //    devolvido como parâmetro nomeado, começando em false.
  Item({
    required this.nome,
    required this.local,
    required this.data,
    required this.categoria,
    this.devolvido = false,
  });

  // c) Getter status: retorna 'Devolvido' ou 'Aguardando'.
  String get status => devolvido ? 'Devolvido' : 'Aguardando';

  // d) Método alternarStatus(): inverte o valor de devolvido.
  void alternarStatus() {
    devolvido = !devolvido;
  }
}
