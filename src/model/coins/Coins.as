package model.coins {
	import control.Heart;
	import control.imp.Module;
	import flash.display.MovieClip;
	import util.AgentUtil;
	/**
	 * ...
	 * @author ...
	 */
	public class Coins implements Module
	{
		var heart:Heart;
		var coinsMc:MovieClip;
		
		var speedX:Number;
		var speedY:Number;
		
		public function Coins(heart:Heart, x:int, y:int, gold:Boolean) {
			this.heart = heart;
			
			heart.bing(this);
			if (gold)
				coinsMc = new coinAni2();
			else
				coinsMc = new coinAni1();
				
			coinsMc.x = x;
			coinsMc.y = y;
			this.heart.sence.gAddChild(coinsMc);
			
			//角度计算
			var tanC:Number;
			var dirX:Number = 180 - x;
			var dirY:Number = 700 - y;
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
			dirX = Math.abs(dirX);
			dirY = Math.abs(dirY);
			//计算出直线距离
			var distance:Number = Math.sqrt(dirX * dirX + dirY * dirY);
			var speed:Number = distance / heart.fps;
			var radian:Number = tanC * (Math.PI / 180);
			this.speedX = speed * Math.cos(radian);
			this.speedY = speed * Math.sin(radian);
		}
		
		var count:int;
		public function draw(cfps:Number) : void {
			if (++count > this.heart.fps) {
				this.heart.sence.gRemoveChild(coinsMc);
				this.heart.unbing(this);
			}
			coinsMc.x += this.speedX;
			coinsMc.y += this.speedY;
		}
	}//class

}