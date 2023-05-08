/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+weather(Attribute, Value)[source(self)] : true <- .print("I believe the ", Attribute, " is ", Value).

+weather(Attribute, Value)[source(percept)] : true <- .print("I observe the ", Attribute, " is ", Value).