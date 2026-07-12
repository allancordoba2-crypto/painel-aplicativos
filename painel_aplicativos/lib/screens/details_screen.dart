import 'package:flutter/material.dart';

/// Detalhes da estrutura interna do aplicativo (componentes).
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final app = (args is Map<String, dynamic>)
        ? args
        : <String, dynamic>{
            'nome': 'Desconhecido',
            'plataforma': '-',
            'versao': '-',
            'componentes': <Map<String, dynamic>>[],
          };

    final componentes = (app['componentes'] as List?) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(app['nome']?.toString() ?? 'Detalhes'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plataforma: ${app['plataforma']}'),
            Text('Versão: ${app['versao']}'),
            const SizedBox(height: 16),
            const Text(
              'Componentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: componentes.length,
                itemBuilder: (context, index) {
                  final c = componentes[index] as Map;
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.widgets),
                      title: Text(c['nome']?.toString() ?? ''),
                      subtitle: Text(c['tipo']?.toString() ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
