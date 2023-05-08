// Agent leader in project multi_agent

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */
// transfer an instruction. welcomed is a base belief that is added to the belief base of all agents.
+!start : true <- .print("welcome everyone!"); .broadcast(tell, welcomed).