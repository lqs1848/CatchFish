package view 
{
	import control.BulletManager;
	import control.CoinsManager;
	import control.FishManager;
	import control.Heart;
	import control.ModelManager;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.DateS;
	import view.Scenario;
	
	/**
	 * ...
	 * @author heliotrope
	 */
	public class Body extends Sprite 
	{
		
		public function Body() 
		{
			super();
			this.init();
			
		}
		
		public function init():void
		{
			DateS.init();
			DateS.addMoneyBySystem(10000);
			
			//主舞台
			var sence:Scenario = new Scenario();
			this.addChild(sence);
			
			//主逻辑
			var heart:Heart = new Heart(24,sence);
			addEventListener(Event.ENTER_FRAME, heart.heartbeat);
			
			//出鱼的模式
			new ModelManager(heart);
			
			var fishManager:FishManager = new FishManager(heart);
			var bulletManager:BulletManager = new BulletManager(heart);
			var coinsManager:CoinsManager = new CoinsManager(heart);
			
		}
		
	}

}