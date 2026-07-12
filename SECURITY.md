# Security Policy

## Continuous security (auto-updating)

Este repositório mantém segurança **contínua e automática**:

| Mecanismo | Frequência | O que faz |
|-----------|------------|-----------|
| **Dependabot** | Diário | Abre PRs de atualização (pub, pip, Actions) |
| **Security Continuous** | Todo push/PR + diário | Scan de segredos + higiene de dependências |
| **CodeQL** | Todo push/PR + semanal | Análise estática de código |
| **Dependency Review** | Cada PR | Bloqueia deps com vulnerabilidades high+ |

## Reporting a vulnerability

1. **Não** abra issue pública com detalhes exploráveis.
2. Use [GitHub Security Advisories](https://github.com/allancordoba2-crypto/painel-aplicativos/security/advisories/new) (privado) ou contate o dono do repo.
3. Inclua: impacto, passos de reprodução, versão/commit.

## Secrets policy

- Nunca commitar tokens, chaves, `.env`, keystores.
- Credenciais de demo (`admin`/`admin`) são **apenas locais de exemplo** — troque em produção.
- Rotacione qualquer credencial exposta imediatamente.

## Recommended GitHub settings (owner)

Ative em **Settings → Security**:

1. **Private repository** (recomendado)
2. Dependabot alerts + security updates
3. Secret scanning (+ push protection se disponível)
4. Code scanning (CodeQL)
5. Branch protection em `main` (require PR + status checks)

## Supported versions

| Branch | Suporte de segurança |
|--------|----------------------|
| `main` | Ativo (updates diários) |
