# Hardening do repositório (checklist)

## 1. Tornar privado (agora)

GitHub → **Settings** → **General** → **Danger Zone** → **Change repository visibility** → **Private**

Ou via API (com token `repo`):

```bash
curl -X PATCH \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/allancordoba2-crypto/painel-aplicativos \
  -d '{"private":true}'
```

## 2. Ativar segurança automática (Settings → Code security)

- [x] Dependabot alerts
- [x] Dependabot security updates
- [x] Dependabot version updates (via `.github/dependabot.yml`)
- [ ] Secret scanning
- [ ] Push protection
- [x] Code scanning (CodeQL workflow)

## 3. Branch protection (`main`)

Settings → Branches → Add rule:

- Require a pull request before merging
- Require status checks: `Security Continuous`, `CodeQL`
- Do not allow bypassing (se possível)
- Restrict who can push

## 4. O que já está automatizado no repo

Arquivos em `.github/`:

- `dependabot.yml` — PRs diários de update
- `workflows/security-continuous.yml` — scan a cada push + cron diário
- `workflows/codeql.yml` — análise estática
- `workflows/dependency-review.yml` — bloqueia deps vulneráveis em PRs

## 5. Após tornar privado

O link público deixa de funcionar para terceiros. Compartilhe apenas com colaboradores convidados.
