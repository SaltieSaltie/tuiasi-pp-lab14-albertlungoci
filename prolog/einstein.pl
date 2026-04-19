% ============================================================
% einstein.pl — Problema lui Einstein (Zebra Puzzle)
% Cine deține peștele?
% ============================================================
%
% Există 5 case de culori diferite, așezate în linie (pozițiile 1-5).
% Fiecare casă este locuită de o persoană de naționalitate diferită.
% Fiecare persoană bea o anumită băutură, fumează un anumit brand
% de țigări și deține un anumit animal.
%
% Fiecare casă este reprezentată ca:
%   house(Culoare, Nationalitate, Bautura, Animal, Tigari)
%
% Cele 15 indicii:
%  1. Britanicul locuiește în casa roșie.
%  2. Suedezul ține un câine.
%  3. Danezul bea ceai.
%  4. Casa verde este imediat la stânga casei albe.
%  5. Proprietarul casei verzi bea cafea.
%  6. Persoana care fumează Pall Mall ține o pasăre.
%  7. Proprietarul casei galbene fumează Dunhill.
%  8. Persoana din mijloc (casa 3) bea lapte.
%  9. Norvegianul locuiește în prima casă (stânga).
% 10. Persoana care fumează Blend locuiește lângă cea cu pisica.
% 11. Omul cu calul locuiește lângă cel care fumează Dunhill.
% 12. Persoana care fumează BlueMaster bea bere.
% 13. Germanul fumează Prince.
% 14. Norvegianul locuiește lângă casa albastră.
% 15. Persoana care fumează Blend are un vecin care bea apă.
%
% ============================================================

% next_to(X, Y, List) — X și Y sunt case vecine în lista List
%
% TODO: Decomentați și completați predicatul next_to/3:
% next_to(X, Y, [X,Y|_]).
% next_to(X, Y, [Y,X|_]).
% next_to(X, Y, [_|T]) :- next_to(X, Y, T).

% ============================================================
% TODO: Implementați predicatul solution/1 care instanțiază
% lista celor 5 case și verifică toate cele 15 constrângeri.
%
% Schelet de pornire:
%
% solution(Houses) :-
%     Houses = [house(_,_,_,_,_), house(_,_,_,_,_), house(_,_,_,_,_),
%               house(_,_,_,_,_), house(_,_,_,_,_)],
%     % Indiciu 8: persoana din mijloc bea lapte
%     Houses = [_, _, house(_, _, lapte, _, _), _, _],
%     % Indiciu 9: norvegianul e primul
%     Houses = [house(_, norvegian, _, _, _) | _],
%     % Indiciu 1: britanicul locuiește în casa roșie
%     member(house(rosu, britanic, _, _, _), Houses),
%     % Indiciu 2: suedezul ține câine
%     member(house(_, suedez, _, caine, _), Houses),
%     % ... adăugați restul constrângerilor
%     true.

% ============================================================
% TODO: Implementați einstein/1 care găsește proprietarul peștelui.
%
% einstein(Owner) :-
%     solution(Houses),
%     member(house(_, Owner, _, peste, _), Houses).
% ============================================================
