"""
Autenticação em memória — admin e usuário.

Credenciais demo:
  admin   / admin123    (papel: admin)
  usuario / usuario123  (papel: usuario)
"""

from __future__ import annotations

from copy import deepcopy


class AuthService:
    """Simula tabela de usuários e sessão atual."""

    tabela_usuarios: list[dict[str, str]] = [
        {
            "usuario": "admin",
            "senha": "admin123",
            "nome": "Administrador",
            "papel": "admin",
        },
        {
            "usuario": "usuario",
            "senha": "usuario123",
            "nome": "Usuário Padrão",
            "papel": "usuario",
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

    def logout(self) -> None:
        AuthService.sessao_atual = None

    @property
    def esta_logado(self) -> bool:
        return AuthService.sessao_atual is not None

    @property
    def is_admin(self) -> bool:
        return (AuthService.sessao_atual or {}).get("papel") == "admin"

    @property
    def is_usuario(self) -> bool:
        return (AuthService.sessao_atual or {}).get("papel") == "usuario"

    @property
    def nome_exibicao(self) -> str:
        s = AuthService.sessao_atual or {}
        return s.get("nome") or s.get("usuario") or "Convidado"

    @property
    def papel(self) -> str:
        return (AuthService.sessao_atual or {}).get("papel") or ""


if __name__ == "__main__":
    auth = AuthService()
    print("admin:", auth.login("admin", "admin123"))
    print("is_admin:", auth.is_admin)
    auth.logout()
    print("usuario:", auth.login("usuario", "usuario123"))
    print("is_usuario:", auth.is_usuario)
