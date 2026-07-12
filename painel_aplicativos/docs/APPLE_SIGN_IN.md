# Login com Apple (Sign in with Apple)

## No app

- Botão **Continuar com a Apple** na tela de login
- Pacote: `sign_in_with_apple`
- Sessão grava `provedor: apple` (ou `apple_demo` se o device não tiver o serviço)

## Credenciais locais

| Papel | Usuário | Senha |
|-------|---------|-------|
| Admin | `admin` | `admin123` |
| Usuário | `usuario` | `usuario123` |
| Apple | (conta Apple do device) | — |

## Configurar no Xcode (login real no iPhone)

```bash
cd painel_aplicativos
flutter create . --platforms=ios
flutter pub get
open ios/Runner.xcworkspace
```

1. Signing & Capabilities → **+ Capability** → **Sign in with Apple**
2. Team da Apple Developer
3. App ID com Sign In with Apple no developer.apple.com
4. `flutter run` no device físico

## Modo demo

Se indisponível: sessão `apple_demo` / Usuário Apple (Demo). Apenas desenvolvimento.
