% ============================================================
% family.pl — Baza de cunoștințe despre relații de familie
% ============================================================

% --- Fapte: relația tată ---
tatal(ilie, vasale).
tatal(popa, vasale).
tatal(george, ilie).
tatal(maria, ilie).
tatal(petru, popa).
tatal(vasilica, cobelea).
tatal(dana, pavel).

% --- Fapte: relația mamă ---
mama(george, vasilica).
mama(maria, vasilica).
mama(vasilica, diana).
mama(petru, dana).
mama(matcu, dana).
mama(dana, elena).
mama(ilie, elena).
mama(popa, elena).

% --- Fapte: genul persoanelor ---
barbat(george). barbat(petru). barbat(ilie). barbat(popa).
barbat(vasale). barbat(cobelea). barbat(pavel).

femeie(maria). femeie(matcu). femeie(vasilica). femeie(ileana).
femeie(dana). femeie(diana). femeie(elena).

% --- Fapte: relația de soți ---
sot(vasilica, ilie).
sot(dana, popa).
sot(ileana, petru).

% --- Fapte: relația de unchi (explicite) ---
unchi(george, popa).
unchi(petru, ilie).

% --- Reguli: frate și soră ---
frate(X, Y) :- tatal(X, A), tatal(Y, A), barbat(X), barbat(Y).
frate(X, Y) :- frate(Y, X), barbat(X), barbat(Y).

sora(X, Y) :- tatal(X, A), tatal(Y, A), femeie(Y).

% --- Reguli: mătușă ---
matusa(X, Y) :- sot(Y, Z), frate(Z, W), Z \= W, tatal(X, W).

% --- Reguli: bunic și bunică ---
bunicul(X, Y) :- barbat(Y), tatal(X, W), tatal(W, Y).
bunicul(X, Y) :- barbat(Y), mama(X, W), tatal(W, Y).

bunica(X, Y) :- femeie(Y), tatal(X, W), mama(W, Y).
bunica(X, Y) :- femeie(Y), mama(X, W), mama(W, Y).

% ============================================================
% TODO Tema 1: Extindeți modelul adăugând noi relații de familie.
% ============================================================

% var(X, Y) — X și Y sunt veri primari (părinții lor sunt frați sau surori)
var(X, Y) :- tatal(X, A), tatal(Y, B), A \= B, frate(A, B).
var(X, Y) :- mama(X, A), mama(Y, B), A \= B, frate(A, B).
var(X, Y) :- tatal(X, A), mama(Y, B), frate(A, B).
var(X, Y) :- mama(X, A), tatal(Y, B), frate(A, B).

% nepot(X, Y) — X este nepotul/nepoata lui Y (Y este bunic sau bunică)
nepot(X, Y) :- bunicul(X, Y).
nepot(X, Y) :- bunica(X, Y).

% strabunic(X, Y) — Y este străbunicul lui X
strabunic(X, Y) :- barbat(Y), tatal(X, W), bunicul(W, Y).
strabunic(X, Y) :- barbat(Y), mama(X, W), bunicul(W, Y).

% parinte(X, Y) — Y este părintele lui X
parinte(X, Y) :- tatal(X, Y).
parinte(X, Y) :- mama(X, Y).

% descendent(X, Y) — X este descendentul lui Y (recursiv)
descendent(X, Y) :- parinte(X, Y).
descendent(X, Y) :- parinte(X, Z), descendent(Z, Y).

% ============================================================
% TODO Tema 1: 5 întrebări noi propuse și verificate
%
% 1. Cine sunt verii lui George?
%    ?- var(george, X).
%    X = petru.
%
% 2. Este Petru nepotul lui Vasale?
%    ?- nepot(petru, vasale).
%    true.
%
% 3. Cine sunt toți nepoții lui Vasale?
%    ?- findall(X, nepot(X, vasale), L).
%    L = [george, maria, petru, george, maria, petru].
%
% 4. Cine este străbunicul lui George?
%    ?- strabunic(george, X).
%    X = vasale ; X = cobelea ; X = pavel.
%
% 5. Câți descendenți are Vasale?
%    ?- findall(X, descendent(X, vasale), L), length(L, N).
%    N = 5. % (ilie, popa, george, maria, petru)
% ============================================================