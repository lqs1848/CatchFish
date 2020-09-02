package model.fish 
{
	import flash.display.MovieClip;
	import model.DateS;
	/**
	 * ...
	 * @author heliotrope
	 */
	public class FishType 
	{
		//所有鱼的类型
		public static var length:int = 12;
		
		/**
		 *  获得 鱼 动画
		 */
		public static function getMovieClip(type:int):MovieClip
		{
			switch(type) 
			{
				case 1:
					return new fish1();
				case 2:
					return new fish2();
				case 3:
					return new fish3();
				case 4:
					return new fish4();
				case 5:
					return new fish5();
				case 6:
					return new fish6();
				case 7:
					return new fish7();
				case 8:
					return new fish8();
				case 9:
					return new fish9();
				case 10:
					return new fish10();
				case 11:
					return new shark1();
				case 12:
					return new shark2();
			}
			return  null;
		}
		
		/**
		 *  获得 鱼游动的速度  随机选取
		 */
		public static function getSpeed(type:int):Number
		{
			var maxSpeed:Number;
			var minSpeed:Number;
			switch(type) 
			{
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
					maxSpeed = 1.2;
					minSpeed = 0.5;
					break;
				case 7:
				case 8:
				case 9:
				case 10:
					maxSpeed = 0.8;
					minSpeed = 0.5;
					break;
				case 11:
				case 12:
					maxSpeed = 0.6;
					minSpeed = 0.5;
					break;
			}
			var speed = (maxSpeed - minSpeed) * Math.random() + minSpeed;
			return DateS.baseSpeed / 3 * 2 + DateS.baseSpeed / 3 * speed;
		}
		
		/**
		 * 跳转到第x帧是进入捕获动画
		 */
		public static function getCapture(type:int):int
		{
			switch(type) 
			{
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
					return 9;
				case 6:
				case 8:
				case 9:
				case 11:
				case 12:
					return 17;
				case 7:
				case 10:
					return 13;
			}
			return 0;
		}
		
		/**
		 * 鱼的价格
		 */
		public static function getMoney(type:int):int
		{
			switch(type) 
			{
				case 1:
					return 1;
				case 2:
					return 3;
				case 3:
					return 5;
				case 4:
					return 8;
				case 5:
					return 10;
				case 6:
					return 20;
				case 7:
					return 30;
				case 8:
					return 40;
				case 9:
					return 50;
				case 10:
					return 60;
				case 11:
					return 100;
				case 12:
					return 200;
			}
			return 0;
		}
		
		/**
		 * 鱼的捕获难度
		 * 值越接近0越难
		 */
		public static function getCaptureRate(type:int):Number
		{
			var difficulty:Number;
			switch(type) 
			{
				case 1:
					difficulty =  0.55;
					break;
				case 2:
					difficulty = 0.50;
					break;
				case 3:
					difficulty = 0.45;
					break;
				case 4:
					difficulty = 0.40;
					break;
				case 5:
					difficulty = 0.35;
					break;
				case 6:
					difficulty = 0.30;
					break;
				case 7:
					difficulty = 0.25;
					break;
				case 8:
					difficulty = 0.20;
					break;
				case 9:
					difficulty = 0.15;
					break;
				case 10:
					difficulty = 0.10;
					break;
				case 11:
					difficulty = 0.05;
					break;
				case 12:
					difficulty = 0.02;
					break;
			}
			
			difficulty *= DateS.chance / 100;
			return difficulty;
		}
		
		/**
		 * 一次出现这类型的鱼的最大数量
		 */
		public static function getGroupNum(type:int):int
		{
			switch(type) 
			{
				case 1:
					return 8;
				case 2:
					return 6;
				case 3:
				case 4:
					return 6;
				case 5:
				case 7:
					return 5;
				case 6:
				case 8:
					return 3;
				case 9:
				case 10:
					return 2;
				case 11:
				case 12:
					return 1;
			}
			return 0;
		}
		
		/**
		 * 获得 鱼 X 轴大小
		 */
		public static function getRegX(type:int):int
		{
			switch(type) 
			{
				case 1:
					return 55;
				case 2:
					return 78;
				case 3:
					return 72;
				case 4:
					return 77;
				case 5:
					return 107;
				case 6:
					return 105;
				case 7:
					return 92;
				case 8:
					return 174;
				case 9:
					return 166;
				case 10:
					return 178;
				case 11:
					return 509;
				case 12:
					return 516;
			}
			return 0;
		}
		
		/**
		 * 获得 鱼 Y 轴大小
		 */
		public static function getRegY(type:int):int
		{
			switch(type) 
			{
				case 1:
					return 37;
				case 2:
					return 64;
				case 3:
					return 56;
				case 4:
					return 59;
				case 5:
					return 122;
				case 6:
					return 79;
				case 7:
					return 151;
				case 8:
					return 126;
				case 9:
					return 183;
				case 10:
					return 187;
				case 11:
					return 270;
				case 12:
					return 273;
			}
			return 0;
		}
		
		/**
		 * 获得 鱼 拐弯速度
		 */
		public static function getRadianSpeed(type:int):Number
		{
			switch(type) 
			{
				case 1:
					return 1;
				case 2:
					return 0.95;
				case 3:
					return 0.93;
				case 4:
					return 0.9;
				case 5:
					return 0.75;
				case 6:
					return 0.3;
				case 7:
					return 0.4;
				case 8:
					return 0.6;
				case 9:
					return 0.5;
				case 10:
					return 0.05;
				case 11:
					return 0.2;
				case 12:
					return 0.25;
			}
			return 0;
		}
		
		public static function getWebPoint(type:int):Array
		{
			switch(type) 
			{
				case 11:
					return [-100,0,-200,0,-300,0];
				case 12:
					return [-100,0,-200,0,-300,0];
			}
			return null;
		}
	}

}