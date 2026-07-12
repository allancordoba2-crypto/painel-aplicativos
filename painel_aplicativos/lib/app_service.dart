/// Serviço de dados (API simulação).
/// Centraliza busca e gravação em memória, espelhando a tabela do banco.
class AppService {
  /// Lista em memória simulando as linhas da tabela do banco de dados.
  static List<Map<String, dynamic>> tabelaAplicativos = [
    {
      'nome': 'MeuAppExemplo',
      'plataforma': 'Android Nativo',
      'versao': '1.0.0',
      'componentes': [
        {'tipo': 'Activity', 'nome': 'MainActivity'},
      ],
    },
  ];

  /// Retorna todos os aplicativos (SELECT *).
  List<Map<String, dynamic>> buscarTodos() {
    return List<Map<String, dynamic>>.from(tabelaAplicativos);
  }

  /// Insere um novo aplicativo (INSERT).
  void inserirNovo(Map<String, dynamic> novoApp) {
    tabelaAplicativos.add(Map<String, dynamic>.from(novoApp));
  }

  /// Remove por índice (DELETE) — base para exclusão por swipe.
  bool excluirPorIndice(int index) {
    if (index < 0 || index >= tabelaAplicativos.length) return false;
    tabelaAplicativos.removeAt(index);
    return true;
  }

  /// Filtra por nome (barra de pesquisa).
  List<Map<String, dynamic>> buscarPorNome(String termo) {
    final q = termo.trim().toLowerCase();
    if (q.isEmpty) return buscarTodos();
    return tabelaAplicativos
        .where((app) => (app['nome'] as String).toLowerCase().contains(q))
        .map((app) => Map<String, dynamic>.from(app))
        .toList();
  }
}
