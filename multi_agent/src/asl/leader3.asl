/* Initial beliefs and rules */

tutorial(intro_to_jason).

/* Initial goals */

!start.

/* Plans */

+!start[source(X)] : tutorial(Y)[source(Z)] <- .print("this tutorial is ", Y, " (X=", X, ", Z=", Z, ")").

+arrived[source(X)] : true <- .print("welcome ", X, "!"); .send(X, tell, welcomed).