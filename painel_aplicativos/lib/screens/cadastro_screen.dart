import 'package:flutter/material.dart';
import '../app_service.dart';
import '../auth_service.dart';

/// Formulário de cadastro de novo aplicativo (somente admin).
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final nomeController = TextEditingController();
  final plataformaController = TextEditingController();
  final versaoController = TextEditingController();
  final service = AppService();
  final auth = AuthService();

  @override
  void initState() {
    super.initState();
    if (!auth.isAdmin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    plataformaController.dispose();
    versaoController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!auth.isAdmin) return;
    if (nomeController.text.trim().isEmpty) return;

    final novo = {
      'nome': nomeController.text.trim(),
      'plataforma': plataformaController.text.trim().isEmpty
          ? 'Flutter'
          : plataformaController.text.trim(),
      'versao': versaoController.text.trim().isEmpty
          ? '1.0.0'
          : versaoController.text.trim(),
      'componentes': [
        {'tipo': 'Activity', 'nome': 'MainActivity'},
      ],
    };

    service.inserirNovo(novo);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Aplicativo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do App',
                hintText: 'Nome do App',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: plataformaController,
              decoration: const InputDecoration(
                labelText: 'Plataforma',
                hintText: 'Plataforma (Ex: Flutter)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: versaoController,
              decoration: const InputDecoration(
                labelText: 'Versão',
                hintText: 'Versão Inicial',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'SALVAR NO BANCO',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
