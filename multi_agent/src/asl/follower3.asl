/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start[source(self)] : true <- .print("hi alice!"); .send(alice, tell, arrived).

+welcomed[source(X)] : true <- .print("thank you ", X, ", glad to be here").