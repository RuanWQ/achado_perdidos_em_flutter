import 'package:flutter/material.dart';

class CategoriaCard extends StatelessWidget {
  final String nome;
  final int quantidade;
  final IconData icone;

  const CategoriaCard({
    super.key,
    required this.nome,
    required this.quantidade,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, color: Colors.green.shade800, size: 21),
          const SizedBox(height: 4),
          Text(
            nome,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10),
          ),
          Text(
            '$quantidade',
            style: TextStyle(
              color: Colors.green.shade800,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
