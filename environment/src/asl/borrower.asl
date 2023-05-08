// borrower.asl

//agent(borrower).
!borrow(Book).
// define the goals of the agent
+!borrow(Book) : available_books(N) & N > 0 <- send(library, !borrow(Book)[source(borrower)]), asserta(busy(borrower)).
+!return(Book) : borrowers(List) & member(Book, List) <- send(library, !return(Book)[source(borrower)]), asserta(busy(borrower)).

// define the beliefs of the agent
available_books(N) : true.
borrowers(List) : true.

// define the communication protocol of the agent
+!borrowers(List)[source(Agent)] : borrowers(List) <- true.
+!available_books(N)[source(Agent)] : available_books(N) <- true.
