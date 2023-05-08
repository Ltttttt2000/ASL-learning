// Agent humidSensor in project water

/* Initial beliefs and rules */

/* Initial goals */

!start. // 要先执行start

/* Plans */
+!start[source(X)] : true <- .print("Humidity sensor started. ", X).
	
+sense[source(X)]: true <- .print("Hi, ", X).send(X, tell, receivesensor).

//+!start : 
//	true <- 
//	.print("Humidity sensor started.");
//	.broadcast(tell, watering).
// 每隔一定时间发送湿度数据给浇水机器人
//+interval: true <-
//	wait(1000).// 等待1秒钟
//	.send(waterRobot, "+humidity(random(40,100))").
//	.println("Humidity data set to water robot").// 将X替换成传感器获取的湿度值
//	.goto(interval).
//	
	

