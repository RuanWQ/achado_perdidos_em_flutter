import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/filtro_bar.dart';
import '../widgets/categoria_card.dart';
import '../widgets/item_card.dart';
import '../widgets/resumo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TAREFA 2 (Aulas 02 e 05): coloque os 5 itens iniciais nesta lista.
  List<Item> itens = [
    Item(
      nome: 'Mochila preta',
      local: 'Biblioteca',
      data: '05/11/2026',
      categoria: Categoria.roupa,
    ),
    Item(
      nome: 'Carregador de celular',
      local: 'Sala 02',
      data: '04/11/2026',
      categoria: Categoria.eletronico,
    ),
    Item(
      nome: 'Caderno azul',
      local: 'Pátio',
      data: '03/11/2026',
      categoria: Categoria.material,
    ),
    Item(
      nome: 'Documento de identidade',
      local: 'Secretaria',
      data: '02/11/2026',
      categoria: Categoria.documento,
      devolvido: true,
    ),
    Item(
      nome: 'Chave',
      local: 'Laboratório',
      data: '01/11/2026',
      categoria: Categoria.outro,
    ),
  ];

  String filtro = 'Todos';

  // TAREFA 3 (Aula 04): calcule os três números com where() e length.
  int get total => itens.length;
  int get aguardando => itens.where((item) => !item.devolvido).length;
  int get devolvidos => itens.where((item) => item.devolvido).length;

  // TAREFA 5 (Aula 03): retorne o ícone de cada categoria usando switch.
  IconData iconeDaCategoria(Categoria categoria) {
    switch (categoria) {
      case Categoria.eletronico:
        return Icons.devices;
      case Categoria.material:
        return Icons.menu_book;
      case Categoria.roupa:
        return Icons.checkroom;
      case Categoria.documento:
        return Icons.description;
      case Categoria.outro:
        return Icons.inventory_2;
    }
  }

  String nomeDaCategoria(Categoria categoria) {
    switch (categoria) {
      case Categoria.eletronico:
        return 'Eletrônico';
      case Categoria.material:
        return 'Material';
      case Categoria.roupa:
        return 'Roupa';
      case Categoria.documento:
        return 'Documento';
      case Categoria.outro:
        return 'Outro';
    }
  }

  // TAREFA 6 (Aula 08): adicione um item de exemplo dentro do setState().
  void adicionarItem() {
    setState(() {
      itens.add(
        Item(
          nome: 'Objeto 6',
          local: 'Pátio',
          data: '05/11/2026',
          categoria: Categoria.outro,
        ),
      );
    });
  }

  // TAREFA 7 (Aulas 05 e 08): alterne o status do item dentro do setState().
  void alternarItem(Item item) {}

  // TAREFA 8, DESAFIO (Aulas 03 e 04): devolva só os itens do filtro escolhido.
  List<Item> get itensVisiveis {
    switch (filtro) {
      case 'Aguardando':
        return itens.where((item) => !item.devolvido).toList();
      case 'Devolvidos':
        return itens.where((item) => item.devolvido).toList();
      default:
        return itens;
    }
  }

  // TAREFA 9, DESAFIO (Aula 08): remova o item da lista dentro do setState().
  void removerItem(Item item) {}

  // Daqui para baixo está o layout pronto. Só é preciso mexer na TAREFA 4.
  @override
  Widget build(BuildContext context) {
    final lista = itensVisiveis;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achados e Perdidos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ResumoCard(
            total: total,
            aguardando: aguardando,
            devolvidos: devolvidos,
          ),
          FiltroBar(
            selecionado: filtro,
            onSelecionar: (opcao) {
              setState(() {
                filtro = opcao;
              });
            },
          ),
          SizedBox(
            height: 90,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
              scrollDirection: Axis.horizontal,
              itemCount: Categoria.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final categoria = Categoria.values[index];
                final quantidade = itens
                    .where((item) => item.categoria == categoria)
                    .length;
                return CategoriaCard(
                  nome: nomeDaCategoria(categoria),
                  quantidade: quantidade,
                  icone: iconeDaCategoria(categoria),
                );
              },
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inventory_2, size: 56, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'Nenhum item por aqui',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Toque em + para adicionar'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 8, 14, 80),
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      final item = lista[index];
                      // TAREFA 4 (Aulas 02 e 05): troque os valores fixos
                      // abaixo pelos dados do item.
                      return ItemCard(
                        nome: item.nome,
                        detalhe: '${item.local} · ${item.data}',
                        icone: iconeDaCategoria(item.categoria),
                        status: item.status,
                        devolvido: item.devolvido,
                        onTap: () => alternarItem(item),
                        onLongPress: () => removerItem(item),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
