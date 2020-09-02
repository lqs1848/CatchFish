# CatchFish
 用 QuarkJS 的捕鱼Damo 的素材做的 Flash版

很久以前写的 应该是QuarkJS刚推出的时候



实现了跳帧

不管一秒能跑多少帧

鱼群和子弹的动画一定会在预期的位置

鱼群可以随机出现

也可以自由控制 一级鱼 二级鱼 三级鱼 顺序出现





![image](https://github.com/lqs1848/CatchFish/blob/master/info/1.jpg)<br>



![image](https://github.com/lqs1848/CatchFish/blob/master/info/2.jpg)<br>



如果想做成联网可控制的

直接修改可获得金币数量即可

代码已经有防内存修改金币之类的逻辑

可以通过下发的可获得金币数量和实际获得的金币数量进行校对是否作弊



````
//---------------------------游戏可设置项目-------------------------
		//是否在舞台内绕圈移动
		public static var ranMove:Boolean = true;
		//鱼拐弯基数 取值范围在 1~6中取
		public static var radianBase:Number = 6;
		//是否要指定鱼的类型
		public static var fishType:Boolean = false;
		//可以出现的鱼的类型
		public static var fishTypeArr:Array = [12];
		
		//鱼出现模式  1 左右出现 2从左向右 3从右向左 4四周出现
		public static var fishShowModel:int = 4;
		//鱼出现的速度 百分比
		public static var fishLifeSpeed:Number = 100;

		//金币数量
		public static var Coins:int = 10000;
		//可以获得的金币数量
		public static var reCoins:int = 0;

		//鱼游动基础移动速度
		public static var baseSpeed:Number = 4;


		屏幕中鱼最大数量和最小数量也可设置


金币数量初始化时转换一次
金币用变成子弹后自动变为 可获得金币数量
````

