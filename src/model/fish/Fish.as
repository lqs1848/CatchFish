package model.fish 
{
	import control.Heart;
	import control.imp.Module;
	import fl.livepreview.LivePreviewParent;
	import flash.display.MovieClip;
	import flash.events.ContextMenuEvent;
	import model.DateS;
	import util.AgentUtil;
	import util.CoinsEvent;
	import util.FishEvent;
	import util.FishEventDispatcher;
	import util.RanUtil;
	/**
	 * ...
	 * @author heliotrope
	 */
	public class Fish implements Module
	{
		//驱动器
		var heart:Heart;
		//鱼的类型
		var type:int;
		//鱼的动画
		var fishMc:MovieClip;
		
		//是否已被捕获
		var capture:Boolean = false;
		//捕获动画计数器
		var captureCount:int;
		//是否已经消失
		var isDisappear:Boolean = false;
		
		//鱼游动速度
		var speed:Number;
		
		//位置
		//起点坐标
		var sx:int;
		var sy:int;
		//终点坐标
		var ex:int;
		var ey:int;
		
		//鱼旋转角度
		var rotation:Number;
		//弧度
		var radian:Number;
		//延迟旋转角度
		var delayRotation:Number = 999;
		//鱼X轴移动速度
		var speedX:Number;
		//鱼Y轴移动速度
		var speedY:Number;
		
		var thisWidth:Number;
		var thisHeight:Number;
		var gameWidth:Number;
		var gameHeight:Number;
		
		//是否可以转弯
		var canTurning:Boolean = false;
		var changeDirCounter:int = 0;
		//碰撞检测计数器
		var outScreenCheckCount:int;
		
		
		public function Fish(heart:Heart,type:int,sx:int,sy:int,ex:int,ey:int,speed:Number,rotation:Number = 999) 
		{
			this.heart = heart;
			this.type = type;
			this.sx = sx;
			this.sy = sy;
			this.ex = ex;
			this.ey = ey;
			this.speed = speed;
			if (Math.random() > 0.90)
				this.speed = FishType.getSpeed(type);
			
			this.thisWidth = FishType.getRegX(type);
			this.thisHeight = FishType.getRegY(type);
			this.gameWidth = heart.sence.gWidth();
			this.gameHeight = heart.sence.gHeight();
			
			this.fishMc = FishType.getMovieClip(type);
			fishMc.x = sx;
			fishMc.y = sy;
			heart.sence.gAddChild(fishMc);
			heart.bing(this);
			
			var ranJump:int = Math.random() * (FishType.getCapture(type) - 1) + 1;
			fishMc.gotoAndPlay(ranJump);
			
			//没有给角度
			if(rotation == 999){
				//角度计算
				var tanC:Number;
				var dirX:Number = ex - sx;
				var dirY:Number = ey - sy;
				//向上还是向下
				if(dirY<0){//向上
					if(dirX>0){//向右
						tanC = -AgentUtil.getAngle(0,0,dirY,dirX);
					}else{
						tanC = AgentUtil.getAngle(0,0,dirY,dirX) + 180;
					}
				}else{
					if(dirX>0){//向右
						tanC = AgentUtil.getAngle(dirY,dirX,0,0);
					}else{
						tanC = -AgentUtil.getAngle(dirY,dirX,0,0) + 180;
					}
				}
				this.setDirection(tanC);
			}else {
				this.setDirection(rotation);
			}
			
			//发送创建鱼事件
			FishEventDispatcher.dispatchEvent(new FishEvent(FishEvent.Life));
		}
		
		/**
		 * 设置鱼移动的方向
		 */
		public function setDirection(dir:Number):void
		{
			if (this.rotation == dir) return;
			this.rotation = dir;
			setSpeed();
		}
		
		/**
		 * 设置鱼游动的速度
		 */
		public function setSpeed():void {
			//计算鱼游动速度
			this.radian = this.rotation * (Math.PI / 180);
			var tempSpeed:Number = this.speed + DateS.dynSpeed;
			this.speedX = tempSpeed * Math.cos(this.radian);
			this.speedY = tempSpeed * Math.sin(this.radian);
		}
		
		/**
		 * 修改鱼移动的方向
		 */
		public function changeDirection(dir:Number = 999):void
		{
			if (dir == 999) {
				if (Math.random() > 0.8 ) {
					dir = RanUtil.nextBoolean() ? 1 : -1;
					var degree:Number = RanUtil.midValueNum(30);
					this.delayRotation = this.rotation + degree * dir;
				}
			}else {
				this.setDirection(dir);
			}
			
			var min:int = heart.fps * 5;
			var max:int = heart.fps * 10;
			this.changeDirCounter = Math.random() * (max - min + 1) + min >> 1;
		}
		
		public function draw(cfps:Number) : void
		{
			if (this.capture) {
				if (--this.captureCount <= 0)
					unload();
				return;
			}
			
			if (DateS.dynSpeed != 0) setSpeed();
			this.fishMc.rotation = this.rotation;
			this.fishMc.x += speedX;
			this.fishMc.y += speedY;
			
			if (this.delayRotation != 999) {
				var delta:Number = this.delayRotation - this.rotation;
				var step:Number;
				if (Math.abs(Math.abs(this.delayRotation) - Math.abs(this.rotation)) > 30)
					step = 30 * DateS.radianBase / heart.fps * FishType.getRadianSpeed(type) * speed / 3;
				else
					step = 120 * 0.1 / heart.fps;
				var realStep:Number = delta > 0 ? step : -step;
				var r:Number = this.rotation + realStep;
				if(delta >> 0 == 0 ||
				   (realStep > 0 && r >= this.delayRotation) || 
				   (realStep < 0 && r <= this.delayRotation)){
					this.setDirection(this.delayRotation);
					this.delayRotation = 999;
				}else{
					this.setDirection(r);
				}
			}else if ( --this.changeDirCounter <= 0 && this.canTurning) {
				this.changeDirection();
			}
			
			//鱼消失判断
			if (cfps > heart.fps * 10 && --this.outScreenCheckCount <= 0 ) {
				this.outScreenCheckCount += heart.fps / DateS.collisionDetectionNum >> 0;
				if(isOutOfScreen())
					unload();
			}
		}
		
		
		//是否超出显示区域
		public function isOutOfScreen():Boolean
		{
			/*if(this.fishMc.x < -thisWidth ||
			   this.fishMc.x > gameWidth + thisWidth ||
			   this.fishMc.y < -thisHeight ||
			   this.fishMc.y > gameHeight + thisHeight){
				return true;
			}else {*/
				if (heart.sence.isOutOfScreen(this.fishMc))
					return true;
				else {
					this.canTurning = true;
				}
			//}
			return false;
		}
		
		public function webCheck(webMc:MovieClip,level:int):void 
		{
			var x:Number = this.fishMc.x;
			var y:Number = this.fishMc.y;
			
			if(webMc.hitTestPoint(x,y,true)){
				canBeCaptured(level);
			}else if(this.fishMc.hitTestPoint(webMc.x,webMc.y,true)) {
				canBeCaptured(level);
				/*
				var allpoint:Array = FishType.getWebPoint(type);
				if (allpoint != null) {
					for (var i:int = 0; i < allpoint.length; i += 2) {
						var setX:Number = allpoint[i];
						var setY:Number = allpoint[i + 1];
						setX = Math.cos(this.radian) * setX + x;
						setY = Math.sin(this.radian) * setX + y;
						var ff:web = new web();
						ff.x = setX;
						ff.y = setY;
						ff.stop();
						this.heart.sence.gAddChild(ff);
						if (webMc.hitTestPoint(setX, setY, true)) {
							canBeCaptured(level);
							return;
						}
					}//for
					this.heart.unbing(this);
				}
				*/
			}
		}//webCheck method
		
		//被网网到方法
		public function canBeCaptured(power:int):void {
			//中不中奖基础判断
			if (FishType.getCaptureRate(type) * (1 + power * 0.05) < Math.random() || this.capture) return;
			
			var money:int = FishType.getMoney(type);
			if (DateS.addMoney(money)) {
				this.heart.sence.synMoney();
				
				this.fishMc.gotoAndPlay(FishType.getCapture(type));
				this.capture = true;
				this.captureCount = this.heart.fps / 2 >> 0;
				this.isDisappear = true;
				
				FishEventDispatcher.dispatchEvent(new CoinsEvent(CoinsEvent.COINS_OBTAIN, this.fishMc.x, this.fishMc.y, money));
			}
		}
		
		//进入捕获状态
		public function tocapture():void
		{
			fishMc.gotoAndPlay(FishType.getCapture(type));
		}
		
		public function unload():void
		{
			//发送鱼死亡事件
			FishEventDispatcher.dispatchEvent(new FishEvent(FishEvent.Death));
			this.heart.unbing(this);
			this.heart.sence.gRemoveChild(this.fishMc);
			this.isDisappear = true;
		}
		
		/**
		 * 是否存在于界面中
		 */
		public function isExist():Boolean
		{
			return !this.isDisappear;
		}
		
		public function setDelayRotation(value:Number):void 
		{
			this.delayRotation = this.rotation + value;
		}
		
		public function getFishMc():MovieClip {
			return this.fishMc;
		}
	}

}