// Agent friend_of_bob in project multi_agent

/* Initial beliefs and rules */

friend(bob).

/* Initial goals */

!start.

/* Plans */

+!start : friend(X) <- .print("hello ", X).