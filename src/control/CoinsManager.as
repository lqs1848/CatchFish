package control 
{
	import control.imp.Module;
	import model.coins.Coins;
	import model.coins.CoinsNum;
	import util.CoinsEvent;
	import util.FishEventDispatcher;
	/**
	 * ...
	 * @author ...
	 */
	public class CoinsManager
	{
		var heart:Heart;
		
		public function CoinsManager(heart:Heart) 
		{
			this.heart = heart;
			FishEventDispatcher.addEventListener(CoinsEvent.COINS_OBTAIN, coinsObtain);
		}
		
		public function coinsObtain(e:CoinsEvent):void {
			new Coins(this.heart, e.x, e.y, e.num >= 10 );
			new CoinsNum(this.heart, e.x, e.y, e.num);
		}
		
	}//class

}