"""Autenticação: admin, usuário e Apple."""

from __future__ import annotations

from copy import deepcopy


class AuthService:
    tabela_usuarios: list[dict[str, str]] = [
        {
            "usuario": "admin",
            "senha": "admin123",
            "nome": "Administrador",
            "papel": "admin",
            "provedor": "local",
        },
        {
            "usuario": "usuario",
            "senha": "usuario123",
            "nome": "Usuário Padrão",
            "papel": "usuario",
            "provedor": "local",
        },
    ]

    sessao_atual: dict[str, str] | None = None

    def login(self, usuario: str, senha: str) -> dict[str, str] | None:
        u = usuario.strip()
        for row in self.tabela_usuarios:
            if row["usuario"] == u and row["senha"] == senha:
                sessao = deepcopy(row)
                sessao.pop("senha", None)
                AuthService.sessao_atual = sessao
                return sessao
        return None

    def login_com_apple(
        self,
        *,
        user_id: str = "demo-apple-id",
        email: str = "",
        nome: str = "Usuário Apple (Demo)",
        demo: bool = True,
    ) -> dict[str, str]:
        papel = "admin" if email.lower() == "admin@local.dev" else "usuario"
        provedor = "apple_demo" if demo else "apple"
        sessao = {
            "usuario": email if email else f"apple_{user_id}",
            "nome": nome or (email if email else "Usuário Apple"),
            "papel": papel,
            "provedor": provedor,
            "appleUserId": user_id,
        }
        if email:
            sessao["email"] = email
        AuthService.sessao_atual = sessao
        return sessao

    def logout(self) -> None:
        AuthService.sessao_atual = None

    @property
    def esta_logado(self) -> bool:
        return AuthService.sessao_atual is not None

    @property
    def is_admin(self) -> bool:
        return (AuthService.sessao_atual or {}).get("papel") == "admin"

    @property
    def is_apple(self) -> bool:
        p = (AuthService.sessao_atual or {}).get("provedor") or ""
        return p in ("apple", "apple_demo")

    @property
    def nome_exibicao(self) -> str:
        s = AuthService.sessao_atual or {}
        return s.get("nome") or s.get("usuario") or "Convidado"

    @property
    def papel(self) -> str:
        return (AuthService.sessao_atual or {}).get("papel") or ""

    @property
    def provedor(self) -> str:
        return (AuthService.sessao_atual or {}).get("provedor") or "local"
