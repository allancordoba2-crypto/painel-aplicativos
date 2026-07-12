# Painel de Aplicativos

Fluxo: **Login → Listagem → Cadastro → Detalhes**, com `AppService` em memória (simulação de banco).

## Segurança contínua (auto-updating)

Este repositório inclui **segurança automática contínua**:

| Recurso | Quando roda |
|---------|-------------|
| Dependabot | **Todo dia** (pub, pip, Actions) |
| Secret pattern scan | Todo push/PR + **diário** |
| CodeQL | Todo push/PR + **semanal** |
| Dependency Review | Em todo PR |

Veja [SECURITY.md](SECURITY.md) e [docs/SECURITY_HARDENING.md](docs/SECURITY_HARDENING.md).

> **Recomendado:** tornar o repositório **Private** em Settings → General → Change visibility.

## Estrutura

```
painel_aplicativos/          # Flutter
  lib/
    main.dart
    app_service.dart
    screens/
modules/                    # Python
  app_service.py
.github/
  dependabot.yml
  workflows/
```

## Login demo (apenas desenvolvimento)

- usuário: `admin`
- senha: `admin`

**Troque em produção.** Não use estas credenciais em ambientes reais.

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
