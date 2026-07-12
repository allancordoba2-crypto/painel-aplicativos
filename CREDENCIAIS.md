# Credenciais de login (demonstração)

| Papel | Usuário | Senha | Permissões |
|-------|---------|-------|------------|
| **Admin** | `admin` | `admin123` | Ver lista, detalhes, **cadastrar apps**, sair |
| **Usuário** | `usuario` | `usuario123` | Ver lista e detalhes (**sem** cadastro) |

## Arquivos

- Flutter: `painel_aplicativos/lib/auth_service.dart`
- Python: `modules/auth_service.py`

## Importante

Estas senhas são **apenas para demo local**. Em produção use hash (bcrypt/argon2), HTTPS e backend real.
