"""
test_einstein.py — Teste pentru EinsteinSolver.

Rulează cu: uv run pytest tests/test_einstein.py
"""

import pytest
from lab14.einstein import EinsteinSolver


@pytest.fixture
def solver():
    """Fixture care inițializează solver-ul pentru problema Einstein."""
    return EinsteinSolver()


class TestEinsteinSolver:
    def test_solve_returns_string(self, solver):
        """solve() trebuie să returneze un string nevid."""
        owner = solver.solve()
        assert isinstance(owner, str)
        assert len(owner) > 0

    def test_solve_known_answer(self, solver):
        """Răspunsul cunoscut: germanul deține peștele."""
        owner = solver.solve()
        assert owner.lower() == "german"

    def test_get_solution_returns_five_houses(self, solver):
        """get_solution() trebuie să returneze exact 5 case."""
        solution = solver.get_solution()
        assert len(solution) == 5

    def test_get_solution_format(self, solver):
        """Fiecare casă trebuie să fie un dicționar cu 5 chei."""
        solution = solver.get_solution()
        required_keys = {"culoare", "nationalitate", "bautura", "animal", "tigari"}
        for house in solution:
            assert isinstance(house, dict)
            assert required_keys == set(house.keys())
