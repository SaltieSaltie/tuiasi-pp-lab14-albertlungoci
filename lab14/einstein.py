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

    def solve(self) -> str:
        """Returnează naționalitatea proprietarului peștelui."""
        rezultate = list(self._prolog.query("einstein(Owner)"))
        return str(rezultate[0]["Owner"])

    def get_solution(self) -> list[dict]:
        """Returnează lista celor 5 case cu toate atributele lor."""
        rezultate = list(self._prolog.query("solution(Houses)"))
        houses_raw = rezultate[0]["Houses"]
        solutie = []
        for casa in houses_raw:
            args = casa.args
            solutie.append({
                "culoare": str(args[0]),
                "nationalitate": str(args[1]),
                "bautura": str(args[2]),
                "animal": str(args[3]),
                "tigari": str(args[4]),
            })
        return solutie