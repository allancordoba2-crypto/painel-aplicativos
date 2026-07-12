import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../auth_service.dart';

/// Tela de login — admin, usuário e Apple.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();
  final auth = AuthService();
  String? erro;
  bool _mostrarSenha = false;
  bool _carregandoApple = false;

  @override
  void dispose() {
    usuarioController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void _entrar() {
    final user = usuarioController.text.trim();
    final pass = senhaController.text;

    if (user.isEmpty || pass.isEmpty) {
      setState(() => erro = 'Preencha usuário e senha.');
      return;
    }

    final sessao = auth.login(user, pass);
    if (sessao == null) {
      setState(() => erro = 'Usuário ou senha inválidos.');
      return;
    }

    setState(() => erro = null);
    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> _entrarComApple() async {
    setState(() {
      _carregandoApple = true;
      erro = null;
    });

    try {
      final sessao = await auth.loginComApple(permitirDemo: true);
      if (!mounted) return;

      if (sessao == null) {
        setState(() {
          erro = 'Login Apple cancelado.';
          _carregandoApple = false;
        });
        return;
      }

      if (sessao['provedor'] == 'apple_demo' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Apple demo: configure Sign in with Apple no Xcode para o login real.',
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        erro = 'Falha no login Apple: $e';
        _carregandoApple = false;
      });
    }
  }

  void _preencherDemo(String usuario, String senha) {
    setState(() {
      usuarioController.text = usuario;
      senhaController.text = senha;
      erro = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.lock_outline, size: 56, color: Colors.blue),
            const SizedBox(height: 12),
            const Text(
              'Painel de Aplicativos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Admin, usuário ou Continuar com a Apple',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            TextField(
              controller: usuarioController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Usuário',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: senhaController,
              obscureText: !_mostrarSenha,
              onSubmitted: (_) => _entrar(),
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _mostrarSenha ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() => _mostrarSenha = !_mostrarSenha);
                  },
                ),
              ),
            ),
            if (erro != null) ...[
              const SizedBox(height: 12),
              Text(
                erro!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _carregandoApple ? null : _entrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('ENTRAR'),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('ou', style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            if (_carregandoApple)
              const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 48,
                child: SignInWithAppleButton(
                  onPressed: _entrarComApple,
                  text: 'Continuar com a Apple',
                  style: SignInWithAppleButtonStyle.black,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _carregandoApple ? null : _entrarComApple,
              icon: const Icon(Icons.apple, size: 22, color: Colors.black),
              label: const Text(
                'Entrar com Apple (alternativo)',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contas locais de demonstração',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.blue,
                ),
                title: const Text('Admin'),
                subtitle: const Text('admin  /  admin123'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _preencherDemo('admin', 'admin123'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: const Text('Usuário'),
                subtitle: const Text('usuario  /  usuario123'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _preencherDemo('usuario', 'usuario123'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
