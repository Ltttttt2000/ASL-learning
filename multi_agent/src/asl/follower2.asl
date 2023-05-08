/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */
// send to alice myname X
+!start : true <- .print("hi alice!"); .my_name(X); .send(alice, tell, arrived(X)).

+welcomed : true <- .print("thank you, glad to be here").