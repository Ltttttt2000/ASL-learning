// Agent meta in project multi_agent


/* Initial beliefs and rules */

/* Initial goals */

!go_to(work)[priority(high)].
!go_to(sleep)[priority(low)].

/* Plans */

+!go_to(X)[priority(high)] : true <- .print("going to ", X).

+!go_to(X)[priority(low)] : true <- .print("will go to ", X, " another time").