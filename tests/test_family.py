"""
test_family.py — Teste pentru FamilyKnowledgeBase.

Rulează cu: uv run pytest tests/test_family.py
"""

import pytest
from lab14.family import FamilyKnowledgeBase


@pytest.fixture
def kb():
    """Fixture care inițializează baza de cunoștințe."""
    return FamilyKnowledgeBase()


class TestFamilyQueries:
    def test_query_matusa_returns_results(self, kb):
        """query_matusa() trebuie să returneze cel puțin un rezultat."""
        results = kb.query_matusa()
        assert len(results) > 0

    def test_query_matusa_format(self, kb):
        """Fiecare element din query_matusa() trebuie să fie un tuplu de 2 string-uri."""
        results = kb.query_matusa()
        assert all(isinstance(r, tuple) and len(r) == 2 for r in results)

    def test_query_bunic_returns_results(self, kb):
        """query_bunic() trebuie să returneze cel puțin un rezultat."""
        results = kb.query_bunic()
        assert len(results) > 0

    def test_query_bunic_format(self, kb):
        """Fiecare element din query_bunic() trebuie să fie un tuplu de 2 string-uri."""
        results = kb.query_bunic()
        assert all(isinstance(r, tuple) and len(r) == 2 for r in results)

    def test_query_sora_lui_george(self, kb):
        """George are sora Maria (ambii au tatăl Ilie)."""
        sori = kb.query_sora_lui("george")
        assert "maria" in [s.lower() for s in sori]

    def test_query_sora_lui_returns_list(self, kb):
        """query_sora_lui() trebuie să returneze o listă."""
        result = kb.query_sora_lui("george")
        assert isinstance(result, list)
