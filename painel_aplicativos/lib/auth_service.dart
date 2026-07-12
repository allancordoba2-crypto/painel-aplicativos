import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Serviço de autenticação em memória (usuário/senha + Apple).
class AuthService {
  static final List<Map<String, String>> tabelaUsuarios = [
    {
      'usuario': 'admin',
      'senha': 'admin123',
      'nome': 'Administrador',
      'papel': 'admin',
      'provedor': 'local',
    },
    {
      'usuario': 'usuario',
      'senha': 'usuario123',
      'nome': 'Usuário Padrão',
      'papel': 'usuario',
      'provedor': 'local',
    },
  ];

  static Map<String, String>? sessaoAtual;

  Map<String, String>? login(String usuario, String senha) {
    final u = usuario.trim();
    final s = senha;
    for (final row in tabelaUsuarios) {
      if (row['usuario'] == u && row['senha'] == s) {
        sessaoAtual = Map<String, String>.from(row);
        sessaoAtual!.remove('senha');
        return sessaoAtual;
      }
    }
    return null;
  }

  /// Login com Apple (Sign in with Apple).
  Future<Map<String, String>?> loginComApple({bool permitirDemo = true}) async {
    try {
      final disponivel = await SignInWithApple.isAvailable();
      if (!disponivel) {
        if (permitirDemo) {
          return _criarSessaoAppleDemo(
            motivo: 'Sign in with Apple indisponível neste dispositivo',
          );
        }
        return null;
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final userId = credential.userIdentifier ?? 'apple_user';
      final email = credential.email ?? '';
      final given = credential.givenName ?? '';
      final family = credential.familyName ?? '';
      final nomeCompleto = [given, family].where((p) => p.isNotEmpty).join(' ');

      final papel =
          (email.toLowerCase() == 'admin@local.dev') ? 'admin' : 'usuario';

      sessaoAtual = {
        'usuario': email.isNotEmpty ? email : 'apple_$userId',
        'nome': nomeCompleto.isNotEmpty
            ? nomeCompleto
            : (email.isNotEmpty ? email : 'Usuário Apple'),
        'papel': papel,
        'provedor': 'apple',
        'appleUserId': userId,
        if (email.isNotEmpty) 'email': email,
      };
      return sessaoAtual;
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return null;
      }
      if (permitirDemo) {
        debugPrint('Apple auth falhou (${e.code}): ${e.message}');
        return _criarSessaoAppleDemo(motivo: e.message);
      }
      rethrow;
    } catch (e) {
      if (permitirDemo) {
        debugPrint('Apple auth erro: $e');
        return _criarSessaoAppleDemo(motivo: e.toString());
      }
      rethrow;
    }
  }

  Map<String, String> _criarSessaoAppleDemo({String? motivo}) {
    sessaoAtual = {
      'usuario': 'apple_demo',
      'nome': 'Usuário Apple (Demo)',
      'papel': 'usuario',
      'provedor': 'apple_demo',
      'appleUserId': 'demo-apple-id',
      if (motivo != null) 'nota': motivo,
    };
    return sessaoAtual!;
  }

  void logout() {
    sessaoAtual = null;
  }

  bool get estaLogado => sessaoAtual != null;

  bool get isAdmin => sessaoAtual?['papel'] == 'admin';

  bool get isUsuario =>
      sessaoAtual?['papel'] == 'usuario' ||
      sessaoAtual?['provedor']?.startsWith('apple') == true;

  bool get isApple =>
      sessaoAtual?['provedor'] == 'apple' ||
      sessaoAtual?['provedor'] == 'apple_demo';

  String get nomeExibicao =>
      sessaoAtual?['nome'] ?? sessaoAtual?['usuario'] ?? 'Convidado';

  String get papel => sessaoAtual?['papel'] ?? '';

  String get provedor => sessaoAtual?['provedor'] ?? 'local';
}
