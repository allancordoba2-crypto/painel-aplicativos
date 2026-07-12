/// Serviço de autenticação em memória (simula tabela de usuários).
class AuthService {
  /// Tabela de usuários: login, senha e papel (admin | usuario).
  static final List<Map<String, String>> tabelaUsuarios = [
    {
      'usuario': 'admin',
      'senha': 'admin123',
      'nome': 'Administrador',
      'papel': 'admin',
    },
    {
      'usuario': 'usuario',
      'senha': 'usuario123',
      'nome': 'Usuário Padrão',
      'papel': 'usuario',
    },
  ];

  /// Sessão atual (após login bem-sucedido).
  static Map<String, String>? sessaoAtual;

  /// Tenta autenticar. Retorna o usuário se ok, senão null.
  Map<String, String>? login(String usuario, String senha) {
    final u = usuario.trim();
    final s = senha;
    for (final row in tabelaUsuarios) {
      if (row['usuario'] == u && row['senha'] == s) {
        sessaoAtual = Map<String, String>.from(row);
        // Não expõe a senha na sessão
        sessaoAtual!.remove('senha');
        return sessaoAtual;
      }
    }
    return null;
  }

  void logout() {
    sessaoAtual = null;
  }

  bool get estaLogado => sessaoAtual != null;

  bool get isAdmin => sessaoAtual?['papel'] == 'admin';

  bool get isUsuario => sessaoAtual?['papel'] == 'usuario';

  String get nomeExibicao =>
      sessaoAtual?['nome'] ?? sessaoAtual?['usuario'] ?? 'Convidado';

  String get papel => sessaoAtual?['papel'] ?? '';
}
