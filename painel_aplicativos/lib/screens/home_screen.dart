import 'package:flutter/material.dart';

import '../app_service.dart';
import '../auth_service.dart';

/// Listagem dinâmica dos aplicativos (dados vindos do AppService).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final service = AppService();
  final auth = AuthService();
  List<Map<String, dynamic>> dadosApps = [];

  @override
  void initState() {
    super.initState();
    if (!auth.estaLogado) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
      });
      return;
    }
    _recarregar();
  }

  void _recarregar() {
    setState(() {
      dadosApps = service.buscarTodos();
    });
  }

  void _sair() {
    auth.logout();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = auth.isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Aplicativos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                '${auth.nomeExibicao} (${auth.papel})',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Sair',
            onPressed: _sair,
            icon: const Icon(Icons.logout),
          ),
        ],
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
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () async {
                final atualizou =
                    await Navigator.pushNamed(context, '/cadastro');
                if (atualizou == true && mounted) {
                  _recarregar();
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
