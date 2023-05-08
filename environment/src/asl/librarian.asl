
agent(librarian).

// define the goals of the agent
+!borrowers(List) : borrowers(List) <- send(library, !borrowers(List)[source(librarian)]), true.
+!available_books(N) : available_books(N) <- send(library, !available_books(N)[source(librarian)]), true.

// define the beliefs of the agent
busy(librarian) : false.

// define the communication protocol of the agent
+!borrow(Book)[source(Agent)] : borrowers(List) & member(Book, List) <- send(Agent, !borrow(Book)), true.
+!return(Book)[source(Agent)] : true.
