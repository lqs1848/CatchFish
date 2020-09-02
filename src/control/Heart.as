package control 
{
	import control.imp.Module;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import view.Scenario;
	/**
	 * ...
	 * @author heliotrope
	 */
	public class Heart 
	{
		//游戏帧率
		public var fps:int;
		//实际帧率计数器
		var vertrefresh:int;
		//舞台
		public var sence:Scenario;
		
		//游戏开始时间
		var startTime:Number;
		//最后一次刷新的时间
		var lastflash:Number;
		//是否处于暂停状态
		var stopStatus:Boolean = false;
		//暂停状态所消耗的时间
		var stopTime:Number = 0;
		
		//所有组件列表
		var modules:Array;
		//等待回收组件列表
		var reModules:Array;
		//所有组件的注册时间
		var modulesBeatMap:Dictionary;
		
		public function Heart(fps:int,stage:Scenario) 
		{
			this.fps = fps;
			this.sence = stage;
			
			startTime = time();
			lastflash = startTime;
			modules = new Array();
			reModules = new Array();
			modulesBeatMap = new Dictionary();
		}
		
		//主逻辑
		public function heartbeat(e:Event):void 
		{
			//刷新率计算
			if (++vertrefresh > fps) {
				sence.setFps(Math.round(1000 / ((time() - lastflash) / vertrefresh)));
				vertrefresh = 0;
				lastflash = time();
			}
			
			
			
			if (!stopStatus)
			{
				var len:int = modules.length;
				for (var i:int = 0; i < len; i++ )
				{
					var brick:Module = modules[i];
					var cbrickfps:Number = cfps() - modulesBeatMap[brick];
					if(brick)
						brick.draw(cbrickfps);
					else
						modules.splice(i, 1);
				}
				
				/*len = reModules.length;
				for (var i:int = 0; i < len; i++ )
				{
					var brick:Module = reModules[i];
					modules.splice(modules.indexOf(modules), 1);
					delete modulesBeatMap[module];
					module = null;
				}*/
			}
		}
		
		//组件绑定
		public function bing(module:Module):void 
		{
			modules.push(module);
			modulesBeatMap[module] = cfps();
		}
		
		//组件解绑
		public function unbing(module:Module):void
		{
			modules.splice(modules.indexOf(module), 1);
			delete modulesBeatMap[module];
			module = null;
		}
		
		//当前执行的执行到第几Fps
		public function cfps():Number
		{
			return (time() - this.startTime -stopTime) / fps;
		}
		
		//当前时间
		private function time():Number
		{
			return new Date().getTime();
		}
		
		//暂停时间
		var stopStartTime:Number = 0;
		//切换启动状态i
		public function toggle(status:Boolean) : void {
			if(status != stopStatus){
				stopStatus = !stopStatus;
				if(!stopStatus)
					stopTime += this.time() - stopStartTime;
				else
					stopStartTime = this.time();
			}
		};
	}

}