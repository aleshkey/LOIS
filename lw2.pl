legal(CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight) :-
    CopLeft >=0, PrisonerLeft >=0, DadLeft >=0, MomLeft >=0, SonLeft >=0, DaughterLeft >=0, CopRight >=0, PrisonerRight >=0, DadRight >=0, MomRight >=0, SonRight >=0, DaughterRight >=0,
    CopLeft + CopRight < 2,
    PrisonerLeft + PrisonerRight < 2,
    DadLeft + DadRight < 2,
    MomLeft + MomRight < 2,
    check_all_parents(DadLeft, MomLeft, SonLeft, DaughterLeft, DadRight, MomRight, SonRight, DaughterRight),
    check_prisoner(CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight).

check_all_parents(DadLeft, MomLeft, SonLeft, DaughterLeft, DadRight, MomRight, SonRight, DaughterRight) :-
    check_parent(MomLeft, DadLeft, SonLeft),
    check_parent(MomRight, DadLeft, SonRight),
    check_parent(DadLeft, MomLeft, DaughterLeft),
    check_parent(DadRight, MomRight, DaughterRight).

check_parent(Parent1, Parent2, Child) :-
    (Parent1 = 1, Child  = 0);
    (Parent1 = 1, Child >= 0, Parent2 = 1);
    (Parent1 = 0, Child >= 0).

check_prisoner(CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight) :-
    CopLeft == PrisonerLeft;
    (
        not(with_family(PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft)),
        not(with_family(PrisonerRight, DadRight, MomRight, SonRight, DaughterRight))
    ).

with_family(Prisoner, Dad, Mom, Son, Daughter) :-
    Prisoner = 1,
    (
        Dad > 0; 
        Mom > 0; 
        Son > 0; 
        Daughter > 0
    ).

%коп и преступник

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft2, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight2, PrisonerRight2, DadRight, MomRight, SonRight, DaughterRight]
    ) :-
    write(DadRight), nl,
    CopLeft2 is CopLeft - 1,
    CopRight2 is CopRight + 1,
    PrisonerLeft2 is PrisonerLeft -1,
    PrisonerRight2 is PrisonerRight + 1,
    legal(CopLeft2, PrisonerLeft2, DadLeft, MomLeft, SonLeft, DaughterLeft, CopRight2, PrisonerRight2, DadRight, MomRight, SonRight, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft2, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight2, PrisonerRight2, DadRight, MomRight, SonRight, DaughterRight]
    ) :-
    CopLeft2 is CopLeft + 1,
    CopRight2 is CopRight - 1,
    PrisonerLeft2 is PrisonerLeft + 1,
    PrisonerRight2 is PrisonerRight - 1,
    legal(CopLeft2, PrisonerLeft2, DadLeft, MomLeft, SonLeft, DaughterLeft, CopRight2, PrisonerRight2, DadRight, MomRight, SonRight, DaughterRight).

%коп и сын

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft2, DaughterLeft, rgt, CopRight2, PrisonerRight, DadRight, MomRight, SonRight2, DaughterRight]
    ) :-
    CopLeft2 is CopLeft - 1,
    CopRight2 is CopRight + 1,
    SonLeft2 is SonLeft - 1,
    SonRight2 is SonRight + 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft2, DaughterLeft, CopRight2, PrisonerRight, DadRight, MomRight, SonRight2, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft2, DaughterLeft, lft, CopRight2, PrisonerRight, DadRight, MomRight, SonRight2, DaughterRight]
    ) :-
    CopLeft2 is CopLeft + 1,
    CopRight2 is CopRight - 1,
    SonLeft2 is SonLeft + 1,
    SonRight2 is SonRight - 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft2, DaughterLeft, CopRight2, PrisonerRight, DadRight, MomRight, SonRight2, DaughterRight).


%коп и дочь

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft2, rgt, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight2]
    ) :-
    CopLeft2 is CopLeft - 1,
    CopRight2 is CopRight + 1,
    DaughterLeft2 is DaughterLeft - 1,
    DaughterRight2 is DaughterRight + 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft2, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight2).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft2, lft, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight2]
    ) :-
    CopLeft2 is CopLeft + 1,
    CopRight2 is CopRight - 1,
    DaughterLeft2 is DaughterLeft + 1,
    DaughterRight2 is DaughterRight - 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft2, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight2).

%коп и мать

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, rgt, CopRight2, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight]
    ) :-
    CopLeft2 is CopLeft - 1,
    CopRight2 is CopRight + 1,
    MomLeft2 is MomLeft - 1,
    MomRight2 is MomRight + 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, CopRight2, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, lft, CopRight2, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight]
    ) :-
    CopLeft2 is CopLeft + 1,
    CopRight2 is CopRight - 1,
    MomLeft2 is MomLeft + 1,
    MomRight2 is MomRight - 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, CopRight2, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight).

%коп и отец

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, rgt, CopRight2, PrisonerRight, DadRight2, MomRight, SonRight, DaughterRight]
    ) :-
    CopLeft2 is CopLeft - 1,
    CopRight2 is CopRight + 1,
    DadLeft2 is DadLeft - 1,
    DadRight2 is DadRight + 1,
    legal(CopLeft2, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, CopRight2, PrisonerRight, DadRight2, MomRight, SonRight, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, lft, CopRight2, PrisonerRight, DadRight2, MomRight, SonRight, DaughterRight]
    ) :-
    CopLeft2 is CopLeft + 1,
    CopRight2 is CopRight - 1,
    DadLeft2 is DadLeft + 1,
    DadRight2 is DadRight - 1,
    legal(CopLeft2, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, CopRight2, PrisonerRight, DadRight2, MomRight, SonRight, DaughterRight).

%отец и сын

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft2, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight2, MomRight, SonRight2, DaughterRight]
    ) :-
    SonLeft2 is SonLeft - 1,
    SonRight2 is SonRight + 1,
    DadLeft2 is DadLeft - 1,
    DadRight2 is DadRight + 1,
    legal(CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft2, DaughterLeft, CopRight, PrisonerRight, DadRight2, MomRight, SonRight2, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft2, DaughterLeft, lft, CopRight, PrisonerRight, DadRight2, MomRight, SonRight2, DaughterRight]
    ) :-
    SonLeft2 is SonLeft + 1,
    SonRight2 is SonRight - 1,
    DadLeft2 is DadLeft + 1,
    DadRight2 is DadRight - 1,
    legal(CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft2, DaughterLeft, CopRight, PrisonerRight, DadRight2, MomRight, SonRight2, DaughterRight).

%отец и мать

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft2, MomLeft2, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight2, MomRight2, SonRight, DaughterRight]
    ) :-
    MomLeft2 is MomLeft - 1,
    MomRight2 is MomRight + 1,
    DadLeft2 is DadLeft - 1,
    DadRight2 is DadRight + 1,
    legal(CopLeft, PrisonerLeft, DadLeft2, MomLeft2, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight2, MomRight2, SonRight, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft2, MomLeft2, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight2, MomRight2, SonRight, DaughterRight]
    ) :-
    MomLeft2 is MomLeft + 1,
    MomRight2 is MomRight - 1,
    DadLeft2 is DadLeft + 1,
    DadRight2 is DadRight - 1,
    legal(CopLeft, PrisonerLeft, DadLeft2, MomLeft2, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight2, MomRight2, SonRight, DaughterRight).

%мать и дочь

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft2, rgt, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight2]
    ) :-
    MomLeft2 is MomLeft - 1,
    MomRight2 is MomRight + 1,
    DaughterLeft2 is DaughterLeft - 1,
    DaughterRight2 is DaughterRight + 1,
    legal(CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft2, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight2).


move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft2, lft, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight2]
    ) :-
    MomLeft2 is MomLeft + 1,
    MomRight2 is MomRight - 1,
    DaughterLeft2 is DaughterLeft + 1,
    DaughterRight2 is DaughterRight - 1,
    legal(CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft2, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight2).

%коп

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight]
    ) :-
    CopLeft2 is CopLeft - 1,
    CopRight2 is CopRight + 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight]
    ) :-
    CopLeft2 is CopLeft + 1,
    CopRight2 is CopRight - 1,
    legal(CopLeft2, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, CopRight2, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight).

%мать

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight]
    ) :-
    MomLeft2 is MomLeft - 1,
    MomRight2 is MomRight + 1,
    legal(CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight]
    ) :-
    MomLeft2 is MomLeft + 1,
    MomRight2 is MomRight - 1,
    legal(CopLeft, PrisonerLeft, DadLeft, MomLeft2, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight, MomRight2, SonRight, DaughterRight).

%отец

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight2, MomRight2, SonRight, DaughterRight]
    ) :-
    DadLeft2 is DadLeft - 1,
    DadRight2 is DadRight + 1,
    legal(CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight2, MomRight, SonRight, DaughterRight).

move(
    [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, rgt, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
    [CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, lft, CopRight, PrisonerRight, DadRight2, MomRight2, SonRight, DaughterRight]
    ) :-
    DadLeft2 is DadLeft + 1,
    DadRight2 is DadRight - 1,
    legal(CopLeft, PrisonerLeft, DadLeft2, MomLeft, SonLeft, DaughterLeft, CopRight, PrisonerRight, DadRight2, MomRight, SonRight, DaughterRight).


path([CopLeft1, PrisonerLeft1, DadLeft1, MomLeft1, SonLeft1, DaughterLeft1, Boat1, CopRight1, PrisonerRight1, DadRight1, MomRight1, SonRight1, DaughterRight1],
     [CopLeft2, PrisonerLeft2, DadLeft2, MomLeft2, SonLeft2, DaughterLeft2, Boat2, CopRight2, PrisonerRight2, DadRight2, MomRight2, SonRight2, DaughterRight2], Explored, MovesList) :-
    move([CopLeft1, PrisonerLeft1, DadLeft1, MomLeft1, SonLeft1, DaughterLeft1, Boat1, CopRight1, PrisonerRight1, DadRight1, MomRight1, SonRight1, DaughterRight1], 
         [CopLeft3, PrisonerLeft3, DadLeft3, MomLeft3, SonLeft3, DaughterLeft3, Boat3, CopRight3, PrisonerRight3, DadRight3, MomRight3, SonRight3, DaughterRight3]),
    not(member([CopLeft3, PrisonerLeft3, DadLeft3, MomLeft3, SonLeft3, DaughterLeft3, Boat3, CopRight3, PrisonerRight3, DadRight3, MomRight3, SonRight3, DaughterRight3], Explored)),
    path([CopLeft3, PrisonerLeft3, DadLeft3, MomLeft3, SonLeft3, DaughterLeft3, Boat3, CopRight3, PrisonerRight3, DadRight3, MomRight3, SonRight3, DaughterRight3],
         [CopLeft2, PrisonerLeft2, DadLeft2, MomLeft2, SonLeft2, DaughterLeft2, Boat2, CopRight2, PrisonerRight2, DadRight2, MomRight2, SonRight2, DaughterRight2],
         [[CopLeft3, PrisonerLeft3, DadLeft3, MomLeft3, SonLeft3, DaughterLeft3, Boat3, CopRight3, PrisonerRight3, DadRight3, MomRight3, SonRight3, DaughterRight3] | Explored],
         [[[CopLeft3, PrisonerLeft3, DadLeft3, MomLeft3, SonLeft3, DaughterLeft3, Boat3, CopRight3, PrisonerRight3, DadRight3, MomRight3, SonRight3, DaughterRight3], 
           [CopLeft1, PrisonerLeft1, DadLeft1, MomLeft1, SonLeft1, DaughterLeft1, Boat1, CopRight1, PrisonerRight1, DadRight1, MomRight1, SonRight1, DaughterRight1]] | MovesList ]).

path([CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, Boat, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight],
     [CopLeft, PrisonerLeft, DadLeft, MomLeft, SonLeft, DaughterLeft, Boat, CopRight, PrisonerRight, DadRight, MomRight, SonRight, DaughterRight], _, MovesList) :- output(MovesList).

output([]) :- nl.
output([[A, B] | MovesList]) :-
    output(MovesList),
    write(B), write(' -> '), write(A), nl.

find(X, Y) :- path(X, Y, [X], _). 
find       :- find([1, 1, 1, 1, 2, 2, lft, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, rgt, 1, 1, 1, 1, 2, 2]).