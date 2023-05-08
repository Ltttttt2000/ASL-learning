/* Initial beliefs and rules */

/* Initial goals */

!go_to(class).

/* Plans */

+weather(Attribute, Value)[source(self)] : true <- .print("I believe the ", Attribute, " is ", Value).

+weather(Attribute, Value)[source(percept)] : true <- .print("I observe the ", Attribute, " is ", Value).

+!go_to(Destination) :
  weather(cloud_cover, sunny) & not weather(temperature, cold) <-
    // walk from work regardless whether it currently at work or not.
    .wait(1000);
    walk(Location, Destination).

+!go_to(Destination) :
  .my_name(Agent) <-
    ?location(Agent, Location);
    .wait(1000);
    drive(Location, Destination).

+location(Agent, Location) : .my_name(Agent) <- .print("I am at ", Location).