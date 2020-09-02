package util 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class CoinsEvent extends Event
	{
		public static const COINS_OBTAIN:String = "COINS_OBTAIN";
		
		var _x:int;
		var _y:int;
		var _num:int;
		
		public function CoinsEvent(type:String,x:int,y:int,num:int) 
		{
			super(type);
			this._x = x;
			this._y = y;
			this._num = num;
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function get num():int 
		{
			return _num;
		}
		
	}

}