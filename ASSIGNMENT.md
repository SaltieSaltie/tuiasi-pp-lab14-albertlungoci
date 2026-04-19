# Laborator 14 — Programare în Prolog și interoperabilitate cu Python

## 1. Introducere

**Prolog** (Programming in Logic) este un limbaj de programare declarativ bazat pe logica predicatelor de ordinul întâi. În loc să specificăm *cum* să calculăm un rezultat, descriem *ce* este adevărat prin **fapte** și **reguli**, iar motorul Prolog găsește singur soluțiile prin **rezoluție** și **backtracking**.

**pyswip** este o bibliotecă Python care permite apelarea motorului **SWI-Prolog** direct din cod Python. Astfel putem combina expresivitatea logicii Prolog cu ecosistemul Python (testare, procesare date, interfețe grafice etc.).

### Concepte cheie Prolog

| Concept | Exemplu | Descriere |
|---------|---------|-----------|
| Fapt | `tatal(george, ilie).` | George este tatăl lui Ilie |
| Regulă | `frate(X,Y) :- tatal(X,A), tatal(Y,A).` | X și Y sunt frați dacă au același tată |
| Interogare | `?- frate(george, maria).` | Este George fratele Mariei? |
| Variabilă | `X`, `Y`, `Who` | Începe cu literă mare sau `_` |
| Atom | `george`, `ilie`, `rosu` | Începe cu literă mică |

---

## 2. Structura proiectului

```
lab14/
├── prolog/
│   ├── family.pl          # Baza de cunoștințe despre familie (fapte + reguli date)
│   └── einstein.pl        # Schelet pentru problema Einstein (de completat)
├── lab14/
│   ├── __init__.py
│   ├── family.py          # Wrapper Python pentru family.pl
│   └── einstein.py        # Wrapper Python pentru einstein.pl
├── tests/
│   ├── __init__.py
│   ├── test_family.py     # Teste automate pentru family.py
│   └── test_einstein.py   # Teste automate pentru einstein.py
├── .github/
│   └── workflows/
│       └── classroom.yml  # Pipeline CI/CD GitHub Actions
├── pyproject.toml         # Configurația proiectului Python
├── ASSIGNMENT.md          # Acest fișier
└── README.md              # Instrucțiuni rapide
```

---

## 3. Instalare și configurare

### 3.1 SWI-Prolog

```bash
# Ubuntu / Debian
sudo apt install swi-prolog

# macOS (Homebrew)
brew install swi-prolog

# Verificare instalare
swipl --version
```

### 3.2 Dependențe Python

```bash
# Instalează uv (manager de pachete modern)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Instalează dependențele proiectului
uv sync --dev
```

---

## 4. Cerințe

### Tema 1 — Extinderea bazei de cunoștințe `family.pl` (50 puncte)

#### 4.1 Adăugarea de noi relații în `prolog/family.pl`

Deschideți fișierul `prolog/family.pl` și adăugați cel puțin **3 reguli noi** de familie în secțiunea marcată cu `TODO Tema 1`. Sugestii:

**Văr primar** — două persoane sunt veri dacă părinții lor sunt frați:
```prolog
var(X, Y) :- tatal(X, A), tatal(Y, B), frate(A, B).
var(X, Y) :- mama(X, A), mama(Y, B), frate(A, B).
% ... adăugați și celelalte combinații
```

**Nepot** — X este nepotul lui Y dacă Y este bunicul/bunica lui X:
```prolog
nepot(X, Y) :- bunicul(X, Y).
nepot(X, Y) :- bunica(X, Y).
```

**Strănepot** — extindeți lanțul genealogic cu o generație:
```prolog
strabunic(X, Y) :- barbat(Y), tatal(X, W), bunicul(W, Y).
```

**Verificare în consola SWI-Prolog:**
```bash
swipl prolog/family.pl
```
```prolog
?- var(george, petru).
?- nepot(george, vasale).
?- findall(X-Y, var(X,Y), L), length(L, N).
```

#### 4.2 Implementarea wrapper-ului Python în `lab14/family.py`

Completați metodele marcate cu `TODO` din clasa `FamilyKnowledgeBase`:

**`query_matusa()`** — returnează lista de perechi `(copil, mătușă)`:
```python
def query_matusa(self) -> list[tuple[str, str]]:
    rezultate = list(self._prolog.query("matusa(X,Y)"))
    return [(str(r["X"]), str(r["Y"])) for r in rezultate]
```

**`query_bunic()`** — returnează lista de perechi `(nepot, bunic)`:
```python
def query_bunic(self) -> list[tuple[str, str]]:
    rezultate = list(self._prolog.query("bunicul(X,Y)"))
    return [(str(r["X"]), str(r["Y"])) for r in rezultate]
```

**`query_sora_lui(name)`** — returnează lista surorilor persoanei date:
```python
def query_sora_lui(self, name: str) -> list[str]:
    rezultate = list(self._prolog.query(f"sora(X,{name.lower()})"))
    return [str(r["X"]) for r in rezultate]
```

**`query_var()`** — după implementarea regulii `var/2` în Prolog:
```python
def query_var(self) -> list[tuple[str, str]]:
    rezultate = list(self._prolog.query("var(X,Y)"))
    return [(str(r["X"]), str(r["Y"])) for r in rezultate]
```

#### 4.3 Propuneți cel puțin 5 întrebări noi

Adăugați ca și comentarii în `family.pl` cel puțin 5 interogări Prolog cu răspunsurile lor. Exemplu:
```prolog
% ?- bunicul(george, X).
% X = vasale.
```

---

### Tema 2 — Problema lui Einstein în `prolog/einstein.pl` (50 puncte)

#### 4.4 Implementarea predicatelor în `prolog/einstein.pl`

Problema lui Einstein (Zebra Puzzle) are un singur răspuns corect. Trebuie să implementați:

**Pasul 1** — Decomentați și verificați `next_to/3`:
```prolog
next_to(X, Y, [X,Y|_]).
next_to(X, Y, [Y,X|_]).
next_to(X, Y, [_|T]) :- next_to(X, Y, T).
```

**Pasul 2** — Implementați `solution/1` cu toate cele 15 constrângeri:
```prolog
solution(Houses) :-
    Houses = [house(_,_,_,_,_), house(_,_,_,_,_), house(_,_,_,_,_),
              house(_,_,_,_,_), house(_,_,_,_,_)],
    % Indiciu 8: persoana din mijloc bea lapte
    Houses = [_, _, house(_, _, lapte, _, _), _, _],
    % Indiciu 9: norvegianul e primul
    Houses = [house(_, norvegian, _, _, _) | _],
    % Indiciu 1
    member(house(rosu, britanic, _, _, _), Houses),
    % Indiciu 2
    member(house(_, suedez, _, caine, _), Houses),
    % Indiciu 3
    member(house(_, danez, ceai, _, _), Houses),
    % Indiciu 4: verde imediat la stânga albului
    next_to(house(verde, _, _, _, _), house(alb, _, _, _, _), Houses),
    % Indiciu 5
    member(house(verde, _, cafea, _, _), Houses),
    % Indiciu 6
    member(house(_, _, _, pasare, pallmall), Houses),
    % Indiciu 7
    member(house(galben, _, _, _, dunhill), Houses),
    % Indiciu 10
    next_to(house(_, _, _, _, blend), house(_, _, _, pisica, _), Houses),
    % Indiciu 11
    next_to(house(_, _, _, cal, _), house(_, _, _, _, dunhill), Houses),
    % Indiciu 12
    member(house(_, _, bere, _, bluemaster), Houses),
    % Indiciu 13
    member(house(_, german, _, _, prince), Houses),
    % Indiciu 14
    next_to(house(_, norvegian, _, _, _), house(albastru, _, _, _, _), Houses),
    % Indiciu 15
    next_to(house(_, _, _, _, blend), house(_, _, apa, _, _), Houses).
```

**Pasul 3** — Implementați `einstein/1`:
```prolog
einstein(Owner) :-
    solution(Houses),
    member(house(_, Owner, _, peste, _), Houses).
```

**Verificare:**
```bash
swipl prolog/einstein.pl
?- einstein(X).
X = german.
```

#### 4.5 Implementarea wrapper-ului Python în `lab14/einstein.py`

**`solve()`** — returnează naționalitatea proprietarului peștelui:
```python
def solve(self) -> str:
    rezultate = list(self._prolog.query("einstein(Owner)"))
    return str(rezultate[0]["Owner"])
```

**`get_solution()`** — returnează lista completă a celor 5 case:
```python
def get_solution(self) -> list[dict]:
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
```

---

## 5. Hint-uri Prolog

### Predicate built-in utile

| Predicat | Exemplu | Descriere |
|----------|---------|-----------|
| `member/2` | `member(X, [1,2,3])` | X este element al listei |
| `permutation/2` | `permutation([1,2,3], P)` | P este o permutare a listei |
| `nth1/3` | `nth1(3, L, X)` | X este al 3-lea element din L (indexat de la 1) |
| `length/2` | `length(L, 5)` | L are exact 5 elemente |
| `findall/3` | `findall(X, frate(X,Y), L)` | L = lista tuturor X cu frate(X,Y) |
| `\=/2` | `X \= Y` | X și Y nu sunt unificabile |
| `append/3` | `append([1,2], [3], L)` | Concatenare liste |

### Sintaxă de bază

```prolog
% Definirea unui predicat
parinte(X, Y) :- tatal(X, Y).
parinte(X, Y) :- mama(X, Y).

% Interogare cu findall
?- findall(X, parinte(X, ilie), L).
L = [george, maria].

% Negație
nu_are_copii(X) :- \+ tatal(_, X), \+ mama(_, X).
```

### Sfaturi pentru problema Einstein

- Folosiți `member/2` pentru a plasa proprietăți în case nenumite.
- Folosiți pattern matching direct pe lista `Houses` pentru constrângeri de poziție.
- Prolog va face backtracking automat — nu trebuie să gestionați manual căutarea.
- Adăugați constrângerile cele mai restrictive primele (indiciile 8 și 9) pentru eficiență.

---

## 6. Exemple de interogări în consola SWI-Prolog

```bash
# Porniți consola cu fișierul family.pl încărcat
swipl prolog/family.pl
```

```prolog
% Cine sunt toți frații lui George?
?- frate(george, X).
X = ilie.   % (daca george si ilie au acelasi tata)

% Cine sunt toate bunicile lui George?
?- bunica(george, X).
X = diana ;
X = elena.

% Câți bunici are George în total?
?- findall(B, bunicul(george, B), L), length(L, N).
N = 2.

% Verificați dacă Maria și George sunt frați/surori
?- sora(maria, george).
true.
```

---

## 7. Rularea testelor

```bash
# Rulează toate testele
uv run pytest

# Cu output detaliat
uv run pytest -v

# Doar testele pentru familia
uv run pytest tests/test_family.py -v

# Doar testele pentru Einstein
uv run pytest tests/test_einstein.py -v

# Oprire la primul test eșuat
uv run pytest -x
```

---

## 8. Tabel de evaluare

| Criteriu | Punctaj |
|----------|---------|
| **Tema 1** | **50 pct** |
| Reguli noi corecte în `family.pl` (minim 3) | 15 pct |
| Cel puțin 5 întrebări noi propuse și comentate | 10 pct |
| `query_matusa()` implementat și teste trec | 8 pct |
| `query_bunic()` implementat și teste trec | 7 pct |
| `query_sora_lui()` implementat și teste trec | 5 pct |
| `query_var()` implementat după regula din Prolog | 5 pct |
| **Tema 2** | **50 pct** |
| `next_to/3` implementat corect | 5 pct |
| `solution/1` cu toate 15 constrângeri | 25 pct |
| `einstein/1` implementat corect | 5 pct |
| `EinsteinSolver.solve()` returnează `"german"` | 10 pct |
| `EinsteinSolver.get_solution()` returnează 5 case | 5 pct |
| **TOTAL** | **100 pct** |
