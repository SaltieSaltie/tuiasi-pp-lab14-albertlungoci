"""
family.py — Wrapper Python pentru baza de cunoștințe family.pl.

Folosește biblioteca pyswip pentru a interoga motorul SWI-Prolog
din cod Python.
"""

from pyswip import Prolog
from pathlib import Path

# Calea absolută către fișierul Prolog
PROLOG_FILE = Path(__file__).parent.parent / "prolog" / "family.pl"


class FamilyKnowledgeBase:
    """Interfață Python pentru baza de cunoștințe despre relații de familie."""

    def __init__(self):
        self._prolog = Prolog()
        self._prolog.consult(str(PROLOG_FILE))

    # TODO: Implementează query_matusa() — returnează lista de perechi (copil, mătușă).
    # Hint: folosește list(self._prolog.query("matusa(X,Y)"))
    #       și extrage valorile X și Y din fiecare dicționar rezultat.
    def query_matusa(self) -> list[tuple[str, str]]:
        """Returnează lista de perechi (copil, mătușă)."""
        raise NotImplementedError("De implementat")

    # TODO: Implementează query_bunic() — returnează lista de perechi (nepot, bunic).
    # Hint: interogează predicatul bunicul/2 din Prolog.
    def query_bunic(self) -> list[tuple[str, str]]:
        """Returnează lista de perechi (nepot, bunic)."""
        raise NotImplementedError("De implementat")

    # TODO: Implementează query_sora_lui(name) — returnează lista surorilor persoanei date.
    # Hint: folosește f-string pentru a construi interogarea cu numele dat.
    #       Atenție: name trebuie să fie în litere mici (atom Prolog).
    def query_sora_lui(self, name: str) -> list[str]:
        """Returnează lista surorilor persoanei cu numele dat."""
        raise NotImplementedError("De implementat")

    # TODO (Tema 1): Implementează query_var() după ce ai adăugat regula var/2
    # în family.pl. Returnează lista de perechi (văr1, văr2).
    def query_var(self) -> list[tuple[str, str]]:
        """Returnează lista de perechi de veri."""
        raise NotImplementedError("De implementat")
