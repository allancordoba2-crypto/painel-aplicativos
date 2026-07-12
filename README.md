# Painel de Aplicativos

**Link para compartilhar:** https://github.com/allancordoba2-crypto/painel-aplicativos

Fluxo sem “mágicas”: **Login → Listagem → Cadastro → Detalhes**, com dados no `AppService` (memória = simulação de banco).

## Estrutura

```
painel_aplicativos/          # Flutter
  lib/
    main.dart
    app_service.dart
    screens/
modules/                    # Python (mesmo modelo)
  app_service.py
```

## Rotas Flutter

| Rota | Tela |
|------|------|
| `/` | Login |
| `/home` | Listagem |
| `/cadastro` | Formulário INSERT |
| `/detalhes` | Componentes |

## Login demo

- usuário: `admin`
- senha: `admin`

## Rodar Flutter

```bash
cd painel_aplicativos
flutter pub get
flutter run
```

## Import Python

```python
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from modules.app_service import AppService

svc = AppService()
print(svc.buscar_todos())
```

## Clone

```bash
git clone https://github.com/allancordoba2-crypto/painel-aplicativos.git
```
