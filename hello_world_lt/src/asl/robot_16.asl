// Agent robot_15 in project hello_world_lt

/* Initial beliefs and rules */


grid(3, 3).

location(robot, 1, 1).

location(bin, 1, 3).
location(waste, 3, 1).
location(waste, 2, 2).

carrying(robot, waste, 0).

location(sink, 2, 3).
location(dishes, 2, 1).
location(dishes, 1, 2).
location(dishes, 3, 2).

carrying(robot, dishes, 0).

destination(waste, bin).
destination(dishes, sink).

next_move(right) :- route(robot, outbound) & grid(Columns, _) & location(robot, X, Y) & X < Columns & Y mod 2 \== 0.
next_move(right) :- not route(robot, outbound) & grid(Columns, _) & location(robot, X, Y) & X < Columns & Y mod 2 == 0.

next_move(left) :- route(robot, outbound) & location(robot, X, Y) & X > 1 & Y mod 2 == 0.
next_move(left) :- not route(robot, outbound) & location(robot, X, Y) & X > 1 & Y mod 2 \== 0.

next_move(up) :- route(robot, outbound) & grid(_, Rows) & location(robot, 1, Y) & Y < Rows & Y mod 2 == 0.
next_move(up) :- route(robot, outbound) & grid(Columns, Rows) & location(robot, Columns, Y) & Y < Rows & Y mod 2 \== 0.

next_move(down) :- not route(robot, outbound) & grid(Columns, Rows) & location(robot, Columns, Y) & Y > 1 & Y mod 2 == 0.
next_move(down) :- not route(robot, outbound) & grid(_, Rows) & location(robot, 1, Y) & Y > 1 & Y mod 2 \== 0.

next_move(unknown).

/* Initial goals */

!clean(dishes).

/* Plans */

+!clean(Item) :
  destination(Item, Target) & location(robot, X, Y) & location(Target, X, Y) & carrying(robot, Item, ItemCount) & ItemCount > 0 <- 
    .print("Depositing ", Item, " (x", ItemCount, ") in the ", Target);
    -carrying(robot, Item, ItemCount);
    +carrying(robot, Item, 0);
    !clean(Item).

+!clean(Item) :
  location(robot, X, Y) & location(Item, X, Y) & carrying(robot, Item, ItemCount) <-
    .print("Picking up ", Item);
    -location(Item, X, Y);
    -carrying(robot, Item, ItemCount);
    +carrying(robot, Item, ItemCount+1);
    !clean(Item).

+!clean(Item) :
  next_move(Direction) & Direction \== unknown <-
    !move(Direction);
    ?where_am_i(X, Y);
    .print("Arrived at row ", Y, ", column ", X);
    !clean(Item).

+!clean(_) : true <- .print("Stopping").
+?where_am_i(X, Y) : location(robot, X, Y) <- .wait(500). // 增加时间延时


+!move(right) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X+1, Y).
+!move(up) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X, Y+1).
+!move(left) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X-1, Y).
+!move(down) : location(robot, X, Y) <- -location(robot, X, Y); +location(robot, X, Y-1).

+location(robot, X, Y) : 
  grid(X, Y) & ( ( Y mod 2 \== 0 ) | ( Y mod 2 == 0 & X == 1 ) ) <-
    -route(robot, outbound);
    .print("Now travelling inbound").

+location(robot, 1, 1) : true <- +route(robot, outbound); .print("Now travelling outbound").
