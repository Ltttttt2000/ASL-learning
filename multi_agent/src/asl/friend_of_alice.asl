// Agent friend_of_alice in project multi_agent

/* Initial beliefs and rules */

friend(alice).

/* Initial goals */

!start.

/* Plans */
// input X=alice (based on initial belief)
+!start : friend(X) <- .print("hello ", X).
