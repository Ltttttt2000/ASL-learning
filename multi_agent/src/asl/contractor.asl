// Agent contractor in project multi_agent

/* Initial beliefs and rules */

cost(task1, 2).
cost(task2, 4).

/* Initial goals */

/* Plans */
//由manager要求执行 from manager
+!propose(Task, Instance)[source(Manager)] :
//检查是否有足够的资源，resources在beliefs里定义，每个人的都不一样
//调用已经设定的大家都一样的cost
  resources(Resources) & cost(Task, Cost) & Resources >= Cost <-
    .random(Percentage);  // 有足够的资源的话，生成一个随机数0-1
    Bid = math.round(Cost + ((Resources - Cost) * Percentage));  //算出一个出价
    .print("Proposing ", Bid, " seconds for ", Task);
    .send(Manager, tell, proposal(Task, Instance, Bid)).
    // 发回给manager   Manager：与source一样  manager执行proposal，记录Instance和Bid

// 若资源不足 if-else中的else 直接decline
+!propose(Task, Instance)[source(Manager)] : true <- .print("Declining ", Task).

//从Manager收到执行任务的指令  ??为什么还要单独删除：因为有多个任务，有可能执行完一个任务之后resource就不够了。但是是先被选成winner了
+accepted(Task, Instance, Bid)[source(Manager)] :
  resources(Resources) & Bid > Resources <- //若大于已有资源的数量
    .print("Cancelling ", Task, " due to insufficient resources");
    .send(Manager, untell, proposal(Task, Instance, Bid)). //取消之前发给的消息 删除belief

+accepted(Task, Instance, Bid) :
  resources(Resources) <-
    -resources(Resources);
    +resources(Resources - Bid);  //更新资源数量
    .print("Performing ", Task, " for ", Bid, " seconds");
    .wait(Bid * 1000);
    .print("Completed ", Task).