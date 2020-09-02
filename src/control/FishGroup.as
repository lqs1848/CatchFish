package control 
{
	import control.imp.Module;
	import model.DateS;
	import model.fish.Fish;
	import model.fish.FishType;
	import util.RanUtil;
	/**
	 * ...
	 * @author heliotrope
	 */
	public class FishGroup implements Module
	{
		var heart:Heart;
		var type:int;
		var num:int;
		
		var width:int;
		var height:int;
		
		//鱼群
		var _fishArr:Array;
		//转向计数器
		var changeDirCounter:int = 0;
		
		public function FishGroup(heart:Heart,type:int,num:int) 
		{
			this.heart = heart;
			this.type = type;
			this.num = num;
			
			this.width = heart.sence.gWidth();
			this.height = heart.sence.gHeight();
			
			this._fishArr = new Array();
			this.changeDirCounter = heart.fps * 3;
			
			switch(DateS.fishShowModel) {
				case 1:
				case 2:
				case 3:
					fixedDir();
					break;
				case 4:
					randomDir();
					break;
			}
		}
		
		/**
		 * 是否存在
		 */
		public function isExist():Boolean
		{
			return _fishArr.length > 0;
		}
		
		var exitsCount:int = 0;
		public function draw(cfps:Number) : void
		{
			if (exitsCount < cfps) {
				exitsCount += heart.fps;
				for (var i:int = 0; i < this._fishArr.length && i >= 0; i++ ) {
					var fish:Fish = this._fishArr[i];
					if (!fish.isExist()) {
						_fishArr.splice(i, 1);
						i--;
					}//if
				}//for
			}//if
			
			if (--changeDirCounter <= 0) {
				changeDirection();
			}
			
		}//draw
		
		public function changeDirection():void
		{
			var dir:int = RanUtil.nextBoolean() ? 1 : -1;
			var degree:Number = 0;
			if (Math.random() > 0.99 ||  DateS.ranMove) {
				degree = RanUtil.midValueNum(180);
			}else if (Math.random() > 0.97 ) {
				degree = RanUtil.midValueNum(120);
			}else if (Math.random() > 0.95) {
				degree = RanUtil.midValueNum(60);
			}
			
			for (var i:int = 0; i < this.fishArr.length && i >= 0; i++ ) {
				var fish:Fish = this.fishArr[i];
				fish.setDelayRotation(degree * dir);
			}//for
			
			var min:int = heart.fps * 3;
			var max:int = heart.fps * 8;
			this.changeDirCounter = Math.random() * (max - min + 1) + min >> 1;
		}
		
		
		/**
		 * 固定方向移动
		 */
		public function fixedDir():void{
			//方向
			var startDir:int; 
			switch(DateS.fishShowModel) {
				case 1:
					startDir = RanUtil.nextBoolean() ? 1 : -1;
					break;
				case 2:
					startDir = 1;
					break;
				case 3:
					startDir = -1;
					break;
			}
			
			var sx:int;
			var sy:int;
			sy = RanUtil.midValueNum(height);
			//角度
			var degree:Number = Math.random() * 20 -10 >> 0;
			switch(startDir){
				case 1:
					sx = 0 - FishType.getRegX(type);
					break;
				case -1:
					sx = width + FishType.getRegX(type);
					degree+= 180;
					break;
			}
			var speed:Number = FishType.getSpeed(type);
			for (var i:int = 0; i < num; i++ ) {
				if(i>0){
					var dx:int = Math.random() * FishType.getRegX(type) + 20 >> 0;
					var dy:int = Math.random() * FishType.getRegY(type) + 20 >> 0;
					if (RanUtil.nextBoolean()) dy *= -1;
					sx += dx * (-startDir);
					sy += dy;
				}
				var fish:Fish = new Fish(heart, type, sx, sy, 0, 0, speed, degree);
				this._fishArr.push(fish);
			}
		}
		
		public function randomDir():void
		{
			//方向
			var startDir:int = Math.random() * 4 >> 0;
			var endDir:int = startDir;
			if (RanUtil.nextBoolean())
				endDir = startDir >= 2 ? startDir - 2 : startDir + 2;
			else
				while (startDir == endDir)
					endDir = Math.random() * 4 >> 0;
			
			//方向顺序 0左 1下 2右 3上
			var sx:int;
			var sy:int;
			switch(startDir){
				case 0:
					sx = 0 - FishType.getRegX(type);
					sy = RanUtil.midValueNum(height);
					break;
				case 1:
					sx = RanUtil.midValueNum(width);
					sy = height + FishType.getRegY(type);
					break;
				case 2:
					sx = width + FishType.getRegX(type);
					sy = RanUtil.midValueNum(height);
					break;
				case 3:
					sx = RanUtil.midValueNum(width);
					sy = 0 - FishType.getRegY(type);
					break;
			}
			
			var ex:int;
			var ey:int;
			switch(endDir){
				case 0:
					ex = 0 - FishType.getRegX(type);
					ey = RanUtil.midValueNum(height);
					break;
				case 1:
					ex = RanUtil.midValueNum(width);
					ey = height + FishType.getRegY(type);
					break;
				case 2:
					ex = width + FishType.getRegX(type);
					ey = RanUtil.midValueNum(height);
					break;
				case 3:
					ex = RanUtil.midValueNum(width);
					ey = 0 - FishType.getRegY(type);
					break;
			}
			
			var speed:Number = FishType.getSpeed(type);
			for (var i:int = 0; i < num; i++ ){
				var scx:int = sx;
				var scy:int = sy;
				var ecx:int = ex;
				var ecy:int = ey;
				
				var flag:Boolean = RanUtil.nextBoolean() ? true : RanUtil.nextBoolean() ;
				var offsetA:Number = Math.random() * (RanUtil.nextBoolean() ? Math.random() * FishType.getRegY(type) : -(Math.random() * FishType.getRegY(type))) * num;
				var offsetB:Number = RanUtil.midValueNum(FishType.getRegX(type) * num);
				if(flag && num>1)
					switch(startDir){
						case 0:
							scx = sx - offsetB;
							scy = sy + offsetA;
							break;
						case 1:
							scx = sx + offsetA;
							scy = sy + offsetB;
							break;
						case 2:
							scx = sx + offsetB;
							scy = sy + offsetA;
							break;
						case 3:
							scx = sx + offsetA;
							scy = sy - offsetB;
							break;
					}
				
				if (RanUtil.nextBoolean()){
					offsetA = Math.random() * (RanUtil.nextBoolean() ? Math.random() * FishType.getRegY(type) : -(Math.random() * FishType.getRegY(type))) * num;
					offsetB = RanUtil.midValueNum(FishType.getRegX(type) * num);
				}
				if(!flag || RanUtil.nextBoolean())
					switch(endDir){
						case 0:
							ecx = ex - offsetB;
							ecy = ey + offsetA;
							break;
						case 1:
							ecx = ex + offsetA;
							ecy = ey + offsetB;
							break;
						case 2:
							ecx = ex + offsetB;
							ecy = ey + offsetA;
							break;
						case 3:
							ecx = ex + offsetA;
							ecy = ey - offsetB;
							break;
					}
				
				var fish:Fish = new Fish(heart, type, scx, scy, ecx, ecy, speed);
				this._fishArr.push(fish);
			}//for
		}//randomDir
		
		public function get fishArr():Array 
		{
			return _fishArr;
		}
		
	}

}