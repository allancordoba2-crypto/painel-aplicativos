# Apple Intelligence — fundações nativas

| Arquivo | Função |
|---------|--------|
| `AppleIntelligenceKernel.swift` | Kernel: contexto, logs, pipeline privado |
| `AppleIntelligenceConfig.plist` | Modelo, tokens, Secure Enclave, PCC |
| `AppleIntelligencePlugin.swift` | MethodChannel Flutter |
| `ContentView+AppleIntelligence.swift` | Exemplo SwiftUI |

## Plist

- LocalModelIdentifier: `com.apple.intelligence.foundation.3b`
- MaxTokenContextLimit: `2048`
- SecureEnclaveEnforcement: `YES`
- AllowPrivateCloudComputeFallbacks: `YES`

## Xcode + Flutter

```bash
flutter create . --platforms=ios
# Arraste native/apple_intelligence no target Runner
# Registrar AppleIntelligencePlugin no AppDelegate
flutter run
```

Flutter: rota `/apple-intelligence` · serviço `lib/services/apple_intelligence_service.dart`
