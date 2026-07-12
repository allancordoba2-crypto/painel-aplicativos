import 'package:flutter/material.dart';
import '../app_service.dart';

/// Listagem dinâmica dos aplicativos (dados vindos do AppService).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final service = AppService();
  List<Map<String, dynamic>> dadosApps = [];

  @override
  void initState() {
    super.initState();
    _recarregar();
  }

  void _recarregar() {
    setState(() {
      dadosApps = service.buscarTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Aplicativos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: dadosApps.isEmpty
          ? const Center(child: Text('Nenhum aplicativo cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dadosApps.length,
              itemBuilder: (context, index) {
                final app = dadosApps[index];
                return Card(
                  child: ListTile(
                    title: Text(app['nome']?.toString() ?? ''),
                    subtitle: Text(
                      '${app['plataforma']} | ${app['versao']}',
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detalhes',
                        arguments: app,
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          final atualizou = await Navigator.pushNamed(context, '/cadastro');
          if (atualizou == true && mounted) {
            _recarregar();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
