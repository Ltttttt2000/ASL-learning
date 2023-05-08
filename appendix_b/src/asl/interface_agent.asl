// Agent interface_agent in project appendix_b

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+my_percept(X)[source(Y)] : true <- .print("Belief added: ", my_percept(X)[source(Y)]).

-my_percept(X)[source(Y)] : true <- .print("Belief deleted: ", my_percept(X)[source(Y)]).