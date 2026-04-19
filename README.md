# Laborator 14 — Prolog + Python (pyswip)

Interoperabilitate între SWI-Prolog și Python folosind biblioteca **pyswip**.

## Descriere

Laboratorul acoperă două teme:
- **Tema 1**: Extinderea unei baze de cunoștințe despre relații de familie în Prolog și accesarea ei din Python.
- **Tema 2**: Rezolvarea problemei lui Einstein (Zebra Puzzle) în Prolog și expunerea soluției prin Python.

## Instalare SWI-Prolog

```bash
# Ubuntu / Debian
sudo apt install swi-prolog

# macOS
brew install swi-prolog
```

## Instalare dependențe Python

```bash
uv sync --dev
```

## Rulare teste

```bash
uv run pytest
```

## Structura temelor

- `prolog/family.pl` — Baza de cunoștințe despre familie. **Tema 1**: adăugați reguli noi (văr, nepot, strănepot etc.) în secțiunea marcată cu `TODO`.
- `prolog/einstein.pl` — Schelet pentru problema Einstein. **Tema 2**: implementați `next_to/3`, `solution/1` și `einstein/1`.
- `lab14/family.py` — Completați metodele `query_matusa`, `query_bunic`, `query_sora_lui`, `query_var`.
- `lab14/einstein.py` — Completați metodele `solve` și `get_solution`.

Consultați [ASSIGNMENT.md](ASSIGNMENT.md) pentru instrucțiuni detaliate, hint-uri și tabelul de evaluare.
