// Agent manager in project multi_agent

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */
// +!由manager的goals触发，goals="call_for_proposals(task1, 0), call_for_proposals(task2, 0)"初始条件仅有goal
// instance代表已经提出的个数
+!call_for_proposals(Task, Instance) : 
  true <-
    .print("Requesting proposals for ", Task);
    .broadcast(achieve, propose(Task, Instance)); //广播到其他contractor代理执行+!propose
    /*
      .broadcast(achieve, ...)表示广播一条消息到多个代理，通知它们某个事件已经发生或某个目标已经被完成，
      而这些代理可以根据接收到的消息来更新自己的知识库和规则库，并执行相应的计划。
      achieve表示通知接收方某个目标已经被完成。

	 .askOne(...)表示向一个代理发送一条消息，并等待该代理的回复。
	 * 通常，回复的内容包含了所请求的信息，或者是接受或拒绝执行某个动作的信息。
	 * 这个操作可以被用于进行协商或协调，或者在多个代理之间共享信息。
     */
    .wait(2000);
    ?winner(Task, Instance, Bids, WinningContractor);
    //询问这个任务的赢家 
    .print("Received proposals ", Bids, " for ", Task ," - ", WinningContractor, " is the winner");
    !notify(Task, Instance, Bids, WinningContractor). //通知所有的agent

//根据询问语句执行
+?winner(Task, Instance, Bids, WinningContractor) :
  proposal(Task, Instance, _) <-  // proposal是contractor返回的指令
    .findall(bid(Bid, Contractor), proposal(Task, Instance, Bid)[source(Contractor)], Bids);
    //findall内置指令（要找的变量，满足条件的pattern，储存找到的变量的列表）
    .min(Bids, bid(_, WinningContractor)). //找到最小的从Bids，分配给WinningContractor

+!notify(_, _, [], _) : true <- true.  //若Bids列表为空不会有任何操作

//判断Bids列表第一个是winner，怎么比较的是不是？？？？？
+!notify(Task, Instance, [bid(WinningBid, WinningContractor) | Rest], WinningContractor) :
  true <-
    .print("Accepting proposal for ", Task, " from ", WinningContractor);
    .send(WinningContractor, tell, accepted(Task, Instance, WinningBid));//告诉winner accepted了
    !notify(Task, Instance, Rest, WinningContractor).  //下一个

// 如果表头是Loser 继续执行notify  相当于一直循环这个Bids列表，一个if else语句
+!notify(Task, Instance, [bid(LosingBid, LosingContractor) | Rest], WinningContractor) :
  true <-
    .print("Rejecting proposal for ", Task, " from ", LosingContractor);
    !notify(Task, Instance, Rest, WinningContractor).

-proposal(Task, Instance, Bid)[source(Contractor)] : true <- !call_for_proposals(Task, Instance + 1).
// 调用call_for_proposals时将从属性中删除所有Contractor的命题