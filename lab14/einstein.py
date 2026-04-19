"""
einstein.py — Wrapper Python pentru rezolvarea problemei Einstein.

Folosește biblioteca pyswip pentru a apela motorul SWI-Prolog
și a obține soluția problemei Zebra Puzzle.
"""

from pyswip import Prolog
from pathlib import Path

# Calea absolută către fișierul Prolog
PROLOG_FILE = Path(__file__).parent.parent / "prolog" / "einstein.pl"


class EinsteinSolver:
    """Interfață Python pentru rezolvarea problemei lui Einstein via Prolog."""

    def __init__(self):
        self._prolog = Prolog()
        self._prolog.consult(str(PROLOG_FILE))

    # TODO: Implementează solve() — returnează naționalitatea proprietarului peștelui.
    # Hint: folosește list(self._prolog.query("einstein(Owner)"))
    #       și extrage valoarea cheii "Owner" din primul rezultat.
    def solve(self) -> str:
        """Returnează naționalitatea proprietarului peștelui."""
        raise NotImplementedError("De implementat")

    # TODO: Implementează get_solution() — returnează lista completă a celor 5 case.
    # Fiecare casă este un dicționar cu cheile:
    #   {"culoare": ..., "nationalitate": ..., "bautura": ..., "animal": ..., "tigari": ...}
    # Hint: interogează predicatul solution/1 și prelucrează structura House Prolog
    #       (un termen compus de tipul house(Culoare, Nat, Bautura, Animal, Tigari)).
    def get_solution(self) -> list[dict]:
        """Returnează lista celor 5 case cu toate atributele lor."""
        raise NotImplementedError("De implementat")
