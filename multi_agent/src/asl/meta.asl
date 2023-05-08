// Agent meta in project multi_agent

/* Initial beliefs and rules */

feeling(today, good)[degree_of_belief(0.25)].

/* Initial goals */

/* Plans */

// if else judgement.

+feeling(today, good)[degree_of_belief(X)] : X >= 0.5 <- .print("today is a good day").

+feeling(today, good)[degree_of_belief(X)] : X < 0.5 <- .print("today is not a good day").


