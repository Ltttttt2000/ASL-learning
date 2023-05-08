// Agent waterPump in project water

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("This is water pump").

+watering(X):
	true <-
	.println("Watering plants for ", X, " seconds.").
	.wait(X*1000).
	println("Watering complete").
	
-watering: true <- .println("Watering stopped.").
