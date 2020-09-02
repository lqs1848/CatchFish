package model.bullet 
{
	import control.FishGroup;
	import control.Heart;
	import control.imp.Module;
	import model.DateS;
	import model.fish.Fish;
	/**
	 * ...
	 * @author ...
	 */
	public class Bullet implements Module
	{
		var heart:Heart;
		var level:int;
		var speed:Number = 15;
		
		//子弹动画
		var bulletMc:bullet;
		//网动画
		var webMc:web;
		
		var speedX:Number;
		var speedY:Number;
		
		//子弹是否变成鱼网
		var isWeb:Boolean = false;
		
		//碰撞检测计数器
		var collisionDetectionCount:int;
		
		public function Bullet(heart:Heart) 
		{
			this.heart = heart;
			this.level = DateS.Level;
			
			bulletMc = new bullet();
			bulletMc.gotoAndStop(this.level);
			bulletMc.x = heart.sence.CanX;
			bulletMc.y = heart.sence.CanY;
			bulletMc.rotation = heart.sence.CanRotation;
			heart.sence.gAddChild(bulletMc);
			heart.bing(this);
			
			var radian:Number = heart.sence.CanRotation * (Math.PI / 180);
			this.speedX = this.speed * Math.cos(radian);
			this.speedY = this.speed * Math.sin(radian);
		}
		
		public function draw(cfps:Number) : void{
			if (isWeb) {
				var delayKs:Number = 1 / this.heart.fps * 2; 
				if (this.webMc.scaleX < 1) {
					if (1 - this.webMc.scaleX > delayKs) {
						this.webMc.scaleX += delayKs;
						this.webMc.scaleY += delayKs;
					}else {
						this.webMc.scaleX = 1;
						this.webMc.scaleY = 1;
						
						collisionDetectionCheckByWeb();
					}
				}
			}else {
				this.bulletMc.x += speedY;
				this.bulletMc.y -= speedX;
				
				if (isOutOfScreen()) 
					unloadBullet();
				else
					collisionDetectionCheckByBullet();
			}//isWeb else
		}//draw method
		
		//是否超出显示区域
		public function isOutOfScreen():Boolean{
			return heart.sence.isOutOfScreen(this.bulletMc);
		}
		
		//碰撞检测
		public function collisionDetectionCheckByBullet():void {
			var len:int = DateS.fishArr.length;
			for (var i:int = 0; i < len; i++ ) {
				var group:FishGroup = DateS.fishArr[i];
				if (group && group.isExist()) {
					var fishs:Array = group.fishArr;
					for (var j:int = 0; j < fishs.length; j++ ) {
						var fish:Fish = fishs[j];
						if (fish && fish.isExist() && fish.getFishMc().hitTestPoint(this.bulletMc.x, this.bulletMc.y, true)) {
							toWeb();
							return;
						}
					}//for j 
				}
			}//for i
		}
		
		//碰撞检测
		public function collisionDetectionCheckByWeb():void {
			var len:int = DateS.fishArr.length;
			for (var i:int = 0; i < len; i++ ) {
				var group:FishGroup = DateS.fishArr[i];
				if (group && group.isExist()) {
					var fishs:Array = group.fishArr;
					for (var j:int = 0; j < fishs.length; j++ ) {
						var fish:Fish = fishs[j];
						if (fish)
							fish.webCheck(this.webMc, this.level);
					}//for j 
				}
			}//for i
			
			unloadWeb();
		}
		
		//子弹碰撞到鱼之后
		public function toWeb():void {
			this.isWeb = true;
			this.webMc = new web();
			this.webMc.gotoAndStop(this.level);
			this.webMc.x = this.bulletMc.x;
			this.webMc.y = this.bulletMc.y;
			this.webMc.scaleX = 0.6;
			this.webMc.scaleY = 0.6;
			this.heart.sence.gAddChild(this.webMc);
			this.heart.sence.gRemoveChild(this.bulletMc);
		}
		
		public function unloadBullet():void {
			this.heart.unbing(this);
			this.heart.sence.gRemoveChild(this.bulletMc);
		}
		
		public function unloadWeb():void {
			this.heart.unbing(this);
			this.heart.sence.gRemoveChild(this.webMc);
		}
		
	}//class bullet

}