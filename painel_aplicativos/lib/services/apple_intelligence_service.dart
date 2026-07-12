import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppleIntelligenceService {
  static const MethodChannel _channel = MethodChannel(
    'painel_aplicativos/apple_intelligence',
  );

  Future<Map<String, dynamic>> getStatus() async {
    try {
      final raw = await _channel.invokeMethod<dynamic>('getStatus');
      if (raw is Map) return Map<String, dynamic>.from(raw);
    } on MissingPluginException {
      debugPrint('AppleIntelligence: plugin nativo ausente — fallback.');
    } on PlatformException catch (e) {
      debugPrint('AppleIntelligence getStatus: ${e.message}');
    }
    return _fallbackStatus();
  }

  Future<Map<String, dynamic>> processarComando(String prompt) async {
    final texto = prompt.trim();
    if (texto.isEmpty) {
      return {
        'resposta': '⚠️ Prompt vazio.',
        'snapshot': await getStatus(),
        'fonte': 'local',
      };
    }
    try {
      final raw = await _channel.invokeMethod<dynamic>(
        'processarComando',
        {'prompt': texto},
      );
      if (raw is Map) {
        final map = Map<String, dynamic>.from(raw);
        map['fonte'] = 'nativo';
        return map;
      }
    } on MissingPluginException {
      debugPrint('AppleIntelligence: fallback Dart');
    } on PlatformException catch (e) {
      debugPrint('AppleIntelligence processar: ${e.message}');
    }
    return _fallbackProcessar(texto);
  }

  Map<String, dynamic> _fallbackStatus() => {
        'statusSeguranca':
            '🛡️ Privado (simulado Flutter): Aguardando requisição',
        'modeloLocalAtivo': 'com.apple.intelligence.foundation.3b',
        'versaoKernel': 'v1.2.0-SecureCore-dart-fallback',
        'compatibilidadeHardware': false,
        'maxTokenContextLimit': 2048,
        'secureEnclaveEnforcement': true,
        'allowPrivateCloudComputeFallbacks': true,
        'logs': <String>[
          '[fallback] Kernel nativo não ligado — iOS + plugin.',
        ],
        'ultimoResultado': '',
        'fonte': 'local',
      };

  Future<Map<String, dynamic>> _fallbackProcessar(String texto) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final resumo = texto.length > 120 ? texto.substring(0, 120) : texto;
    final resposta =
        '🤖 [Apple Intelligence Local Engine — fallback Dart]: '
        'Processamento simulado. Resumo: $resumo';
    final snap = _fallbackStatus();
    snap['statusSeguranca'] = '🛡️ Privado: memória limpa (simulado).';
    snap['ultimoResultado'] = resposta;
    (snap['logs'] as List).add('[fallback] Ciclo encerrado.');
    return {'resposta': resposta, 'snapshot': snap, 'fonte': 'local'};
  }
}
