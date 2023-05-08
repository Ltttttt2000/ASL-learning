// Agent robot in project hello_world_lt

/* Initial beliefs and rules */


grid(3, 3).

location(robot, 1, 1).

next_move(right) :- grid(Columns, _) & location(robot, X, Y) & X < Columns & Y mod 2 \== 0.

next_move(left) :- location(robot, X, Y) & X > 1 & Y mod 2 == 0.

next_move(up) :- grid(_, Rows) & location(robot, 1, Y) & Y < Rows & Y mod 2 == 0.
next_move(up) :- grid(Columns, Rows) & location(robot, Columns, Y) & Y < Rows & Y mod 2 \== 0.

next_move(unknown).

/* Initial goals */

!explore.

/* Plans */

+!explore :
  next_move(Direction) & Direction \== unknown <-
    !move(Direction);
    ?location(robot, X, Y);
    .print("Arrived at row ", Y, ", column ", X);
    !explore.

+!explore : true <- .print("Stopping").

+!move(right) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X+1, Y).
+!move(up) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X, Y+1).
+!move(left) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X-1, Y).
+!move(down) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X, Y-1).