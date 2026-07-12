"""Serviço de dados (API simulação) — equivalente Python de app_service.dart."""

from __future__ import annotations

from copy import deepcopy
from typing import Any


class AppService:
    """Centraliza busca e gravação em memória (simula tabela do banco)."""

    tabela_aplicativos: list[dict[str, Any]] = [
        {
            "nome": "MeuAppExemplo",
            "plataforma": "Android Nativo",
            "versao": "1.0.0",
            "componentes": [{"tipo": "Activity", "nome": "MainActivity"}],
        }
    ]

    def buscar_todos(self) -> list[dict[str, Any]]:
        return deepcopy(self.tabela_aplicativos)

    def inserir_novo(self, novo_app: dict[str, Any]) -> None:
        self.tabela_aplicativos.append(deepcopy(novo_app))

    def excluir_por_indice(self, index: int) -> bool:
        if index < 0 or index >= len(self.tabela_aplicativos):
            return False
        self.tabela_aplicativos.pop(index)
        return True

    def buscar_por_nome(self, termo: str) -> list[dict[str, Any]]:
        q = termo.strip().lower()
        if not q:
            return self.buscar_todos()
        return [
            deepcopy(app)
            for app in self.tabela_aplicativos
            if q in str(app.get("nome", "")).lower()
        ]


if __name__ == "__main__":
    svc = AppService()
    print(svc.buscar_todos())
