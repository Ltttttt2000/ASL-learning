/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!acquire(Item, ItemWant) :
  have(Item, ItemHave) & ItemWant > ItemHave <-
    ItemNeed = ItemWant - ItemHave;
    .print("does anyone have ", Item, " (x", ItemNeed, ") to sell?");
    +need(Item, ItemNeed);
    +target(Item, ItemWant);
    .broadcast(askOne, available(Item, ItemNeed, _)).

+?available(Item, ItemNeed, ItemAvailable)[source(Buyer)] :
  have(Item, ItemHave) & .min([ItemNeed, ItemHave], ItemAvailable) <-
    .random(Percentage);
    .wait(Percentage * 1000);
    .print(Buyer, ", I can sell you ", Item, " (x", ItemAvailable, ")").

+available(Item, _, ItemAvailable)[source(Seller)] :
  need(Item, ItemNeed) & .min([ItemAvailable, ItemNeed], ItemBuy) & ItemBuy > 0 <-
    .print(Seller, ", I would like to buy ", Item, " (x", ItemBuy, ")");
    -need(Item, ItemNeed);
    +need(Item, ItemNeed - ItemBuy);
    .send(Seller, achieve, sell(Item, ItemBuy)).

+!sell(Item, ItemBuy)[source(Buyer)] :
  have(Item, ItemHave) & .min([ItemHave, ItemBuy], ItemSell) & ItemSell > 0 <-
    .print(Buyer, ", here is your purchase of ", Item, " (x", ItemSell, ")");
    -have(Item, ItemHave);
    +have(Item, ItemHave - ItemSell);
    .send(Buyer, tell, received(Item, ItemSell)).

+received(Item, ItemReceived) :
  have(Item, ItemHave) <-
    -have(Item, ItemHave);
    +have(Item, ItemHave + ItemReceived).

+have(Item, ItemHave) :
  target(Item, ItemHave) <-
    .print("I now have all the ", Item, " I wanted");
    -target(Item, ItemHave).