package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import view.Body;

	/**
	 * ...
	 * @author heliotrope
	 */
	public class Main extends Sprite 
	{
		private var body:Body;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			body = new Body();
			this.addChild(body);
		}

	}

}