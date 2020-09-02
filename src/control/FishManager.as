package control 
{
	import control.imp.Module;
	import flash.events.Event;
	import model.DateS;
	import model.fish.Fish;
	import model.fish.FishType;
	import util.FishEvent;
	import util.FishEventDispatcher;
	/**
	 * ...
	 * @author heliotrope
	 */
	public class FishManager implements Module
	{
		//驱动器
		var heart:Heart;
		
		
		//创建计数器
		var makeCounter:int = 0;

		public function FishManager(heart:Heart) 
		{
			this.heart = heart;
			heart.bing(this);
			
			FishEventDispatcher.addEventListener(FishEvent.Life, fishNewOrDes);
			FishEventDispatcher.addEventListener(FishEvent.Death, fishNewOrDes);
		}
		
		public function fishNewOrDes(e:FishEvent):void
		{
			if (e.type == FishEvent.Life)
				DateS.poolSize ++ ;
			if (e.type == FishEvent.Death)
				DateS.poolSize -- ;
		}
		
		var exitsCount:int = 0;
		public function draw(cfps:Number) : void
		{
			if (exitsCount < cfps) {
				exitsCount += heart.fps;
				for (var i:int = 0; i < DateS.fishArr.length && i >= 0; i++ ) {
					var group:FishGroup = DateS.fishArr[i];
					if (!group.isExist()) {
						heart.unbing(group);
						DateS.fishArr.splice(i, 1);
						i--;
					}//if
				}//for
			}//if
			
			if (--this.makeCounter <= 0) {
				//this.makeCounter += this.heart.fps;
				this.makeCounter += DateS.poolSize < DateS.minNumFish ? this.heart.fps * 2 : this.heart.fps * 3;
				this.makeCounter /= DateS.fishLifeSpeed / 100;
				makeFish();
			}
		}
		
		//创建鱼群
		public function makeFish():void
		{
			if (DateS.poolSize >= DateS.maxNumFish || !DateS.isNewFish) return;
			
			//随机出鱼的类型
			var type:int;
			if (DateS.fishType) {
				var len:int = DateS.fishTypeArr.length;
				var chance:int = Math.random() * len >> 0;
				var typeS:int = Math.round(Math.random() * chance) >> 0;
				type = DateS.fishTypeArr[typeS];
			}else {
				var len:int = FishType.length;
				var chance:int = Math.random() * len >> 0;
				type = Math.round(Math.random() * chance) + 1 >> 0;
			}
			//计算鱼的数量
			var num:int = Math.random() * FishType.getGroupNum(type) + 1 >> 0;
			var freeNum:int = DateS.maxNumFish - DateS.poolSize;
			if (num > freeNum) num = freeNum;
			if (num <= 0) return;
			
			var group:FishGroup = new FishGroup(heart, type, num);
			DateS.fishArr.push(group);
			heart.bing(group);
		}
		
	}

}