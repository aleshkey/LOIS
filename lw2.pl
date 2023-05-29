% Лабораторная работа №2 по дисциплине "Логические основы интеллектуальных систем"
% Выполнена студентом группы 121701 БГУИР:
% - Олешкевич Алексей Сергеевич
% Вариант: 4, последнее изменение: 20.05.2023

% Данный файл является исходным кодом к программе, решающий следующую задачу:

%Два береги реки. На одном из них полицейский с заключенным, мама с дочерьми и отец с сыновьями. 
%Необходимо с помощью плота, вмещающего не более двух человек, переправить всех персонажей на другой берег реки. 
%Управлять плотом могут только полицейский и родители. Заключённого нельзя оставлять ни с одним из членов семьи. 
%Папе не разрешается находиться с дочерьми без присутствия матери. Маме не разрешается находиться с сыновьями без присутствия отца.


legal(CL, PL, DL, ML, SL, DtL, CR, PR, DR, MR, SR, DtR) :-
    CL >=0, PL >=0, DL >=0, ML >=0, SL >=0, DtL >=0, CR >=0, PR >=0, DR >=0, MR >=0, SR >=0, DtR >=0,
    CL + CR < 2,
    PL + PR < 2,
    DL + DR < 2,
    ML + MR < 2,
    check_all_parents(DL, ML, SL, DtL, DR, MR, SR, DtR),
    check_prisoner(CL, PL, DL, ML, SL, DtL, CR, PR, DR, MR, SR, DtR).
    
check_all_parents(DL, ML, SL, DtL, DR, MR, SR, DtR) :-
    check_parent(ML, DL, SL),
    check_parent(MR, DR, SR),
    check_parent(DL, ML, DtL),
    check_parent(DR, MR, DtR).

check_parent(Parent1, Parent2, Child) :-
    (Parent1 = 1, Child  = 0, Parent2 = 0);
    (Parent1 = 1, Child >= 0, Parent2 = 1);
    (Parent1 = 0, Child >= 0).

check_prisoner(CL, PL, DL, ML, SL, DtL, CR, PR, DR, MR, SR, DtR) :-
    CL = PL;
    (
        not(with_family(PL, DL, ML, SL, DtL)),
        not(with_family(PR, DR, MR, SR, DtR))
    ).

with_family(Prisoner, Dad, Mom, Son, Daughter) :-
    Prisoner = 1,
    (
        Dad > 0; 
        Mom > 0; 
        Son > 0; 
        Daughter > 0
    ).


%коп

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML, SL, DtL, rgt, CR2, PR, DR, MR, SR, DtR]
    ) :-
    CL2 is CL - 1,
    CR2 is CR + 1,
    legal(CL2, PL, DL, ML, SL, DtL, CR2, PR, DR, MR, SR, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML, SL, DtL, lft, CR2, PR, DR, MR, SR, DtR]
    ) :-
    CL2 is CL + 1,
    CR2 is CR - 1,
    legal(CL2, PL, DL, ML, SL, DtL, CR2, PR, DR, MR, SR, DtR).

%мать

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL, ML2, SL, DtL, rgt, CR, PR, DR, MR2, SR, DtR]
    ) :-
    ML2 is ML - 1,
    MR2 is MR + 1,
    legal(CL, PL, DL, ML2, SL, DtL, CR, PR, DR, MR2, SR, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL, ML2, SL, DtL, lft, CR, PR, DR, MR2, SR, DtR]
    ) :-
    ML2 is ML + 1,
    MR2 is MR - 1,
    legal(CL, PL, DL, ML2, SL, DtL, CR, PR, DR, MR2, SR, DtR).

%отец

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL2, ML, SL, DtL, rgt, CR, PR, DR2, MR, SR, DtR]
    ) :-
    DL2 is DL - 1,
    DR2 is DR + 1,
    legal(CL, PL, DL2, ML, SL, DtL, CR, PR, DR2, MR, SR, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL2, ML, SL, DtL, lft, CR, PR, DR2, MR, SR, DtR]
    ) :-
    DL2 is DL + 1,
    DR2 is DR - 1,
    legal(CL, PL, DL2, ML, SL, DtL, CR, PR, DR2, MR, SR, DtR).

%коп и преступник

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL2, PL2, DL, ML, SL, DtL, rgt, CR2, PR2, DR, MR, SR, DtR]
    ) :-
    CL2 is CL - 1,
    CR2 is CR + 1,
    PL2 is PL -1,
    PR2 is PR + 1,
    legal(CL2, PL2, DL, ML, SL, DtL, CR2, PR2, DR, MR, SR, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL2, PL2, DL, ML, SL, DtL, lft, CR2, PR2, DR, MR, SR, DtR]
    ) :-
    CL2 is CL + 1,
    CR2 is CR - 1,
    PL2 is PL + 1,
    PR2 is PR - 1,
    legal(CL2, PL2, DL, ML, SL, DtL, CR2, PR2, DR, MR, SR, DtR).

%коп и сын

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML, SL2, DtL, rgt, CR2, PR, DR, MR, SR2, DtR]
    ) :-
    CL2 is CL - 1,
    CR2 is CR + 1,
    SL2 is SL - 1,
    SR2 is SR + 1,
    legal(CL2, PL, DL, ML, SL2, DtL, CR2, PR, DR, MR, SR2, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML, SL2, DtL, lft, CR2, PR, DR, MR, SR2, DtR]
    ) :-
    CL2 is CL + 1,
    CR2 is CR - 1,
    SL2 is SL + 1,
    SR2 is SR - 1,
    legal(CL2, PL, DL, ML, SL2, DtL, CR2, PR, DR, MR, SR2, DtR).


%коп и дочь

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML, SL, DtL2, rgt, CR2, PR, DR, MR, SR, DtR2]
    ) :-
    CL2 is CL - 1,
    CR2 is CR + 1,
    DtL2 is DtL - 1,
    DtR2 is DtR + 1,
    legal(CL2, PL, DL, ML, SL, DtL2, CR2, PR, DR, MR, SR, DtR2).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML, SL, DtL2, lft, CR2, PR, DR, MR, SR, DtR2]
    ) :-
    CL2 is CL + 1,
    CR2 is CR - 1,
    DtL2 is DtL + 1,
    DtR2 is DtR - 1,
    legal(CL2, PL, DL, ML, SL, DtL2, CR2, PR, DR, MR, SR, DtR2).

%коп и мать

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML2, SL, DtL, rgt, CR2, PR, DR, MR2, SR, DtR]
    ) :-
    CL2 is CL - 1,
    CR2 is CR + 1,
    ML2 is ML - 1,
    MR2 is MR + 1,
    legal(CL2, PL, DL, ML2, SL, DtL, CR2, PR, DR, MR2, SR, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL, ML2, SL, DtL, lft, CR2, PR, DR, MR2, SR, DtR]
    ) :-
    CL2 is CL + 1,
    CR2 is CR - 1,
    ML2 is ML + 1,
    MR2 is MR - 1,
    legal(CL2, PL, DL, ML2, SL, DtL, CR2, PR, DR, MR2, SR, DtR).

%коп и отец

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL2, ML, SL, DtL, rgt, CR2, PR, DR2, MR, SR, DtR]
    ) :-
    CL2 is CL - 1,
    CR2 is CR + 1,
    DL2 is DL - 1,
    DR2 is DR + 1,
    legal(CL2, PL, DL2, ML, SL, DtL, CR2, PR, DR2, MR, SR, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL2, PL, DL2, ML, SL, DtL, lft, CR2, PR, DR2, MR, SR, DtR]
    ) :-
    CL2 is CL + 1,
    CR2 is CR - 1,
    DL2 is DL + 1,
    DR2 is DR - 1,
    legal(CL2, PL, DL2, ML, SL, DtL, CR2, PR, DR2, MR, SR, DtR).

%отец и сын

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL2, ML, SL2, DtL, rgt, CR, PR, DR2, MR, SR2, DtR]
    ) :-
    SL2 is SL - 1,
    SR2 is SR + 1,
    DL2 is DL - 1,
    DR2 is DR + 1,
    legal(CL, PL, DL2, ML, SL2, DtL, CR, PR, DR2, MR, SR2, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL2, ML, SL2, DtL, lft, CR, PR, DR2, MR, SR2, DtR]
    ) :-
    SL2 is SL + 1,
    SR2 is SR - 1,
    DL2 is DL + 1,
    DR2 is DR - 1,
    legal(CL, PL, DL2, ML, SL2, DtL, CR, PR, DR2, MR, SR2, DtR).

%отец и мать

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL2, ML2, SL, DtL, rgt, CR, PR, DR2, MR2, SR, DtR]
    ) :-
    ML2 is ML - 1,
    MR2 is MR + 1,
    DL2 is DL - 1,
    DR2 is DR + 1,
    legal(CL, PL, DL2, ML2, SL, DtL, CR, PR, DR2, MR2, SR, DtR).

move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL2, ML2, SL, DtL, lft, CR, PR, DR2, MR2, SR, DtR]
    ) :-
    ML2 is ML + 1,
    MR2 is MR - 1,
    DL2 is DL + 1,
    DR2 is DR - 1,
    legal(CL, PL, DL2, ML2, SL, DtL, CR, PR, DR2, MR2, SR, DtR).

%мать и дочь

move(
    [CL, PL, DL, ML, SL, DtL, lft, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL, ML2, SL, DtL2, rgt, CR, PR, DR, MR2, SR, DtR2]
    ) :-
    ML2 is ML - 1,
    MR2 is MR + 1,
    DtL2 is DtL - 1,
    DtR2 is DtR + 1,
    legal(CL, PL, DL, ML2, SL, DtL2, CR, PR, DR, MR2, SR, DtR2).


move(
    [CL, PL, DL, ML, SL, DtL, rgt, CR, PR, DR, MR, SR, DtR],
    [CL, PL, DL, ML2, SL, DtL2, lft, CR, PR, DR, MR2, SR, DtR2]
    ) :-
    ML2 is ML + 1,
    MR2 is MR - 1,
    DtL2 is DtL + 1,
    DtR2 is DtR - 1,
    legal(CL, PL, DL, ML2, SL, DtL2, CR, PR, DR, MR2, SR, DtR2).

path([CL1, PL1, DL1, ML1, SL1, DtL1, Boat1, CR1, PR1, DR1, MR1, SR1, DtR1],
     [CL2, PL2, DL2, ML2, SL2, DtL2, Boat2, CR2, PR2, DR2, MR2, SR2, DtR2], Explored, MovesList) :-
    move([CL1, PL1, DL1, ML1, SL1, DtL1, Boat1, CR1, PR1, DR1, MR1, SR1, DtR1], 
         [CL3, PL3, DL3, ML3, SL3, DtL3, Boat3, CR3, PR3, DR3, MR3, SR3, DtR3]),
    not(member([CL3, PL3, DL3, ML3, SL3, DtL3, Boat3, CR3, PR3, DR3, MR3, SR3, DtR3], Explored)),
    path([CL3, PL3, DL3, ML3, SL3, DtL3, Boat3, CR3, PR3, DR3, MR3, SR3, DtR3],
         [CL2, PL2, DL2, ML2, SL2, DtL2, Boat2, CR2, PR2, DR2, MR2, SR2, DtR2],
         [[CL3, PL3, DL3, ML3, SL3, DtL3, Boat3, CR3, PR3, DR3, MR3, SR3, DtR3] | Explored],
         [[[CL3, PL3, DL3, ML3, SL3, DtL3, Boat3, CR3, PR3, DR3, MR3, SR3, DtR3], 
           [CL1, PL1, DL1, ML1, SL1, DtL1, Boat1, CR1, PR1, DR1, MR1, SR1, DtR1]] | MovesList ]).

path([CL, PL, DL, ML, SL, DtL, Boat, CR, PR, DR, MR, SR, DtR],
     [CL, PL, DL, ML, SL, DtL, Boat, CR, PR, DR, MR, SR, DtR], _, MovesList) :-
    write(' '), write('C'),write(" "), write('P'), write(" "), write('D'),write(' '), write('M'),write(' '), write('s'), write(' '), write('d'),
    write('    '),
    write(' '), write('C'),write(" "), write('P'), write(" "), write('D'),write(' '), write('M'),write(' '), write('s'), write(' '), write('d'),
    write('     '),
    write(' '), write('C'),write(" "), write('P'), write(" "), write('D'),write(' '), write('M'),write(' '), write('s'), write(' '), write('d'),
    write('    '),
    write(' '), write('C'),write(" "), write('P'), write(" "), write('D'),write(' '), write('M'),write(' '), write('s'), write(' '), write('d'),
    output(MovesList).

reverse_list([], []).
reverse_list([H|T], R) :- reverse_list(T, TR), append(TR, [H], R).

output([]) :- nl.
output([[A, B] | MovesList]) :-
    output(MovesList),
    write(B), write(' -> '), write(A), nl.

find(X, Y) :- path(X, Y, [X], _). 
find       :- find([1, 1, 1, 1, 0, 1, lft, 0, 0, 0, 0, 2, 0], [0, 0, 0, 0, 0, 0, rgt, 1, 1, 1, 1, 2, 1]).