package model 
{
	import com.adobe.crypto.MD5;
	/**
	 * ...
	 * @author heliotrope
	 */
	public class DateS 
	{
		//金币数量
		public static var Coins:int = 0;
		//金币防修改
		private static var moneys:Array = new Array();
		private static var moneyMd5:String = MD5.hash("0");
		
		//可以获得的金币数量
		public static var reCoins:int = 0;
		
		//炮台级别
		public static var Level:int = 1;
		//动态加速度
		public static var dynSpeed:Number = 0;
		//鱼游动基础移动速度
		public static var baseSpeed:Number = 4;
		//水流的速度
		public static var waterSpeed:int = 8;
		//水流X轴情况
		public static var waterX:Number = 0;
		//水流Y轴情况 负数逆流 正数顺流
		public static var waterY:Number = 0;
		
		//鱼池数量
		public static var poolSize:int = 0;
		//最小鱼数量
		public static var minNumFish:int = 10;
		//最大鱼数量
		public static var maxNumFish:int = 100;
		//是否创建新的鱼
		public static var isNewFish:Boolean = true;
		
		//所有的鱼对象
		public static var fishArr:Array = new Array();
		
		
		//---------------------------游戏模式设置-------------------------
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
		public static var fishLifeSpeed:Number = 1000;
		//中奖几率  100 并不是百分百中奖 而是 几率*基础中奖几率 这里只是微调
		public static var chance:Number = 100;
		
		
		
		//一秒进行多少次碰撞检测 
		public static var collisionDetectionNum:int = 6;
		
		
		
		
		
		
		
		//内存修改检测
		public static function checkMoney():void {
			var m:int = sumMoneys();
			if (moneyMd5 != MD5.hash(Coins.toString())) {
				if (moneyMd5 != MD5.hash(m.toString())) {
					throw new Error("金额被修改! 请勿作弊!");
				}else {
					Coins = m;
				}
			}
		}
		
		public static function addMoneyBySystem(num:int) {
			Coins += num;
			addMoneys(num);
			moneyMd5 = MD5.hash(Coins.toString());
		}
		
		/**
		 * 防外挂修改内存 添加金额方法
		 */
		public static function addMoney(num:int):Boolean {
			checkMoney();
			var orMoney:int = Coins;
			if (reCoins >= num) {
				Coins += num;
				addMoneys(num);
				reCoins -= num;
				if (orMoney == Coins)
					throw new Error("内存被锁定 出现错误!");
				else
					moneyMd5 = MD5.hash(Coins.toString());
				return true;
			}
			return false;
		}
		
		/**
		 * 防外挂修改内存 减少金额方法
		 */
		public static function subMoney(num:int):Boolean {
			checkMoney();
			var orMoney:int = Coins;
			if (Coins >= num) {
				Coins -= num;
				subMoneys(num);
				reCoins += num;
				if (orMoney == Coins)
					throw new Error("内存被锁定 出现错误!");
				else
					moneyMd5 = MD5.hash(Coins.toString());
				return true;
			}
			return false;
		}
		
		
		
		public static function init():void {
			for (var i:int = 0; i < 10;i++ )
				moneys.push(0);
		}
		public static function addMoneys(num:int):void {
			var index:int = Math.random() * moneys.length + 1 >> 0;
			moneys[index] += num;
		}
		public static function subMoneys(num:int):void {
			var index:int = Math.random() * moneys.length + 1 >> 0;
			moneys[index] -= num;
		}
		public static function sumMoneys():int {
			var m:int = 0;
			for (var i:int = 0; i < 10;i++ )
				m += moneys[i];
			return m;
		}
	}

}