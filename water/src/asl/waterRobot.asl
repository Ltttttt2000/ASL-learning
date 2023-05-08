// Agent waterRobot in project water

/* Initial beliefs and rules */

/* Initial goals */
!start.

/* Plans */
+!start[source(self)]: true <- .print("Hi sensor").send(sensor, tell, sense).  //传给sensor自己的名字
	
+receivesensor[source(X)] : true <- .print("received the sensor values from ", X).

//
//+humidity(X):  
//	(X<50) <-
//	.println("Humidity is low, watering plants.").
//	.send(waterPump, "+watering(5)"). // 浇水5秒钟
//	
//	(X>70) <-
//	.println("Humidity is high, stopping watering.").
//    .send(waterPump, "-watering").