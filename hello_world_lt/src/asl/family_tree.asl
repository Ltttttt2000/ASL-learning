// Agent family_tree in project hello_world_lt

/* Initial beliefs and rules */

/* Initial goals */
/* Initial beliefs and rules */

// Initial base beliefs

female(alice).
female(carol).
female(eve).
female(grace).
female(heidi).
female(judy).
female(peggy).
female(wendy).

male(bob).
male(dave).
male(frank).
male(ivan).
male(mike).
male(oscar).
male(rupert).
male(ted).
male(victor).

parent(dave, alice).
parent(dave, bob).
parent(eve, alice).
parent(eve, bob).
parent(ivan, carol).
parent(ivan, dave).
parent(heidi, carol).
parent(heidi, dave).
parent(mike, eve).
parent(mike, frank).
parent(judy, eve).
parent(judy, frank).
parent(peggy, grace).
parent(peggy, ivan).
parent(rupert, grace).
parent(rupert, ivan).
parent(ted, judy).
parent(ted, oscar).
parent(victor, judy).
parent(victor, oscar).
parent(wendy, judy).
parent(wendy, oscar).

age(alice, 91).
age(bob, 92).
age(carol, 61).
age(dave, 62).
age(eve, 63).
age(frank, 64).
age(grace, 31).
age(ivan, 32).
age(heidi, 33).
age(mike, 34).
age(judy, 35).
age(oscar, 36).
age(peggy, 1).
age(rupert, 2).
age(ted, 3).
age(victor, 4).
age(wendy, 5).

self_name(dave).

birthday(eve).
birthday(ivan).
birthday(wendy).


// Initial rules

child(X, Y) :- parent(Y, X).

mother(X, Y) :- parent(X, Y) & female(Y).

father(X, Y) :- parent(X, Y) & male(Y).

sibling(X, Y) :- parent(X, Z) & parent(Y, Z) & X \== Y.

grandparent(X, Z) :- parent(X, Y) & parent(Y, Z).

cousin(X, Y) :- grandparent(X, Z) & grandparent(Y, Z) & not(sibling(X, Y)) & X \== Y.

immediate_family(X, Y) :- parent(X, Y) | child(X, Y) | sibling(X, Y).

adult(X) :- age(X, Y) & Y >= 18.

years_as_adult(X, Z) :- adult(X) & age(X, Y) & Z = Y - 18.

ancestor(X, Z) :- parent(X, Z).
ancestor(X, Z) :- parent(X, Y) & ancestor(Y, Z).

ages(List) :- .findall(X, age(_, X), List).

swap([X, Y | Rest], [Y, X | Rest]) :- X > Y.
swap([Z | Rest], [Z | RestPrime]) :- swap(Rest, RestPrime).

bubble_sort(List, Sorted) :- swap(List, ListPrime) & bubble_sort(ListPrime, Sorted).
bubble_sort(Sorted, Sorted).

ages_sorted(SortedList) :- ages(List) & bubble_sort(List, SortedList).

/* Initial goals */

!wish_happy_birthday.

/* Plans */

+!wish_happy_birthday : self_name(X) & birthday(Y) & sibling(X, Y) & female(Y) & not acknowledged(Y) <- .print("Happy birthday ", Y, "! You are my favourite sister"); +acknowledged(Y); !wish_happy_birthday.

+!wish_happy_birthday : self_name(X) & birthday(Y) & sibling(X, Y) & male(Y) & not acknowledged(Y) <- .print("Happy birthday ", Y, "! You are my favourite brother"); +acknowledged(Y); !wish_happy_birthday.

+!wish_happy_birthday : self_name(X) & birthday(Y) & immediate_family(X, Y) & not acknowledged(Y) <- .print("Happy birthday ", Y, "!"); +acknowledged(Y); !wish_happy_birthday.

+!wish_happy_birthday : true <- .print("Hmm, hope I have not forgotten anyone...").