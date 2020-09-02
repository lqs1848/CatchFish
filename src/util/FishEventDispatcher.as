package util 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author heliotrope
	 */
	public class FishEventDispatcher extends EventDispatcher 
	{
		
		static private var inst:FishEventDispatcher;
		static public var objData:Object;
		public function FishEventDispatcher(){
			if(inst != null) throw Error("FishEventDispatcher is singleton!");
		}
		static public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void { 
			if (getInstance().hasEventListener(type) == false) {
				getInstance().addEventListener(type, listener, useCapture, priority, useWeakReference);
			}
		}
		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
			getInstance().removeEventListener(type, listener, useCapture);
		}
		static public function dispatchEvent(event:*, data:Object = null):Boolean {
			objData = data;
			return getInstance().dispatchEvent(event);
		}
		static public function hasEventListener(type:String):Boolean{
			return getInstance().hasEventListener(type);
		}
		static public function getInstance():FishEventDispatcher{
			if(inst == null){
				inst = new FishEventDispatcher();
			}
			return inst;
		}
	}
}