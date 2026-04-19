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
% Exemple de relații de adăugat:
%   - var(X, Y) :- ...       % X este văr cu Y
%   - nepot(X, Y) :- ...     % X este nepotul lui Y
%   - strabunic(X, Y) :- ... % X este străbunicul lui Y
%   - cuscru(X, Y) :- ...    % X este cuscrul lui Y
%   - ginere(X, Y) :- ...    % X este ginerele lui Y
%
% Adăugați regulile voastre aici:


% ============================================================
% TODO Tema 1: Propuneți cel puțin 5 întrebări noi și verificați-le
% în consola SWI-Prolog. Notați întrebările și răspunsurile
% ca și comentarii mai jos.
%
% Exemplu:
%   ?- var(george, X).
%   X = petru.
%
% Întrebările voastre:
% 1. ...
% 2. ...
% 3. ...
% 4. ...
% 5. ...
% ============================================================
