package util 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author heliotrope
	 */
	public class FishEvent extends Event 
	{
		public static const Life:String="Life";
		public static const Death:String = "Death";
		
		public function FishEvent(type:String) 
		{ 
			super(type);
		} 
	}
	
}