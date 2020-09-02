package util 
{
	/**
	 * ...
	 * @author heliotrope
	 */
	public class RanUtil 
	{
		public static function midValueNum(num:Number):Number
		{
			//var minNum:Number = num >> 1;
			var minNum:Number = num / 10;
			var res:Number = minNum + Math.random() * (num - minNum * 2);
			return res;
		}
		
		
		public static function nextBoolean():Boolean
		{
			return Math.random() > 0.5? true:false;
		}
		
		public static function nextNum(num:Number):Number
		{
			return Math.random() * (num-1) + 1; 
		}
		
		public static function nextInt(num:int):int
		{
			return Math.round(Math.random() * (num-1)) + 1;
		}
	}

}