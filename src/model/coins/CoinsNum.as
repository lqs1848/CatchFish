package model.coins 
{
	import control.Heart;
	import control.imp.Module;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class CoinsNum implements Module
	{
		var heart:Heart;
		var numberMc:Array;
		
		public function CoinsNum(heart:Heart, x:int, y:int,coins:int) 
		{
			this.heart = heart;
			heart.bing(this);
			numberMc = new Array();
			var num:int;
			if (coins >= 100)
				num = 3;
			else if (coins >= 10)
				num = 2;
			else
				num = 1;
			var con:coinText = new coinText();
			con.gotoAndStop(11);
			con.x = x;
			con.y = y;
			numberMc.push(con);
			for (var i:int=0; i < num; i++ ) {
				con = new coinText();
				con.x = x + (i + 1) * 38;
				con.y = y;
				if(coins >= 100)
					con.gotoAndStop(coins / 100 % 10 + 1);
				else if (coins >= 10)
					con.gotoAndStop(coins / 10 % 10 + 1);
				else
					con.gotoAndStop(coins % 10 + 1);
					
				coins %= 10 * (num-1);
				numberMc.push(con);
			}
			
			for (var i:int=0; i < numberMc.length; i++ ) {
				con = numberMc[i];
				heart.sence.gAddChild(con);
			}
			this.count = heart.fps * 0.8 >>0;
		}
		
		var count:int;
		public function draw(cfps:Number) : void {
			if (--count <= 0) {
				var con:coinText;
				for (var i:int = 0; i < numberMc.length; i++ ) {
					con = numberMc[i];
					this.heart.sence.gRemoveChild(con);
				}
				this.heart.unbing(this);
			}else {
				var con:coinText;
				for (var i:int=0; i < numberMc.length; i++ ) {
					con = numberMc[i];
					con.y -= 2;
				}
			}
			
		}
		
	}//class

}