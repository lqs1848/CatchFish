package view 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import model.DateS;
	import util.AgentUtil;
	
	/**
	 * ...
	 * @author heliotrope
	 */
	public class Scenario extends Sprite 
	{
		//背景
		private var bg:background;
		
		//舞台
		private var sandwich:Sprite;
		//舞台范围
		private var objTest:MovieClip;
		
		//前景
		private var ps:prospects;
		private var btn_sub:SimpleButton;
		private var btn_add:SimpleButton;
		//炮台
		var cannon:Cannon;
		//炮台是否处于开火状态中
		var _CanIsAttack:Boolean = false;
		//炮台旋转角度
		var _CanRotation:Number = 0;
		var _CanX:Number;
		var _CanY:Number;
		//当前炮台Mc
		var canMc:MovieClip;
		
		//金钱
		var money_0:MovieClip;
		var money_1:MovieClip;
		var money_2:MovieClip;
		var money_3:MovieClip;
		var money_4:MovieClip;
		var money_5:MovieClip;
		
		//显示FPS
		var fpsTxt:TextField;
		
		public function Scenario() 
		{
			super();
			
			//画遮罩层
			var myMask:Sprite = new Sprite();    
            myMask.graphics.beginFill(0xFFFFFF);    
            myMask.graphics.drawRect(0,0,1024,768);    
            myMask.graphics.endFill();    
			this.addChild(myMask);
			
			bg = new background();
			this.addChild(bg);
			
			sandwich = new Sprite();
			this.addChild(sandwich);
			//使用遮罩层
			sandwich.mask = myMask;
			
			ps = new prospects();
			ps.x = 128;
			ps.y = 698;
			this.addChild(ps);
			//金钱池
			var money:MovieClip = ps.getChildByName("money") as MovieClip;
			this.money_0 = money.getChildByName("num_ge") as MovieClip;
			this.money_1 = money.getChildByName("num_shi") as MovieClip;
			this.money_2 = money.getChildByName("num_bai") as MovieClip;
			this.money_3 = money.getChildByName("num_qian") as MovieClip;
			this.money_4 = money.getChildByName("num_wan") as MovieClip;
			this.money_5 = money.getChildByName("num_shiwan") as MovieClip;
			synMoney();
			
			btn_sub = ps.getChildByName("btnsub") as SimpleButton;
			btn_sub.addEventListener(MouseEvent.MOUSE_DOWN,dpsub);
			btn_add = ps.getChildByName("btnadd") as SimpleButton;
			btn_add.addEventListener(MouseEvent.MOUSE_DOWN, dpadd);
			
			cannon = ps.getChildByName("cannon") as Cannon;
			_CanX = cannon.x + ps.x;
			_CanY = cannon.y + ps.y;
			canMc = cannon.getChildByName("can" + DateS.Level) as MovieClip;
			
			fpsTxt = new TextField();
			fpsTxt.textColor = 0xCFB53B;
			fpsTxt.selectable = false;
			var format:TextFormat = new TextFormat();
			format.font = "Comic Sans MS";
			format.size = 12;
			fpsTxt.defaultTextFormat = format;
			this.addChild(fpsTxt);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, canClick);
			this.addEventListener(MouseEvent.MOUSE_UP, canClick);
			this.addEventListener(MouseEvent.MOUSE_MOVE, canClick);
		}
		
		public function synMoney():void {
			var money:int = DateS.Coins;
			money_0.gotoAndStop(money % 10 + 1);
			money_1.gotoAndStop(money / 10  % 10 + 1 >> 0);
			money_2.gotoAndStop(money / 100 % 10 + 1 >> 0);
			money_3.gotoAndStop(money / 1000 % 10 + 1 >> 0);
			money_4.gotoAndStop(money / 10000 % 10 + 1 >> 0);
			money_5.gotoAndStop(money / 100000 % 10 + 1 >> 0);
		}
		
		/**
		 * 播放 炮台攻击动画
		 */
		public function canAttackAnimain():void {
			canMc.play();
		}
		
		private function  canClick(e:MouseEvent):void {
			if (e.type == MouseEvent.MOUSE_DOWN) {
				_CanIsAttack = true;
			} else if( e.type == MouseEvent.MOUSE_UP) {
				_CanIsAttack = false;
			} else if (e.type == MouseEvent.MOUSE_MOVE) {
				//trace(e.stageX + " " + e.stageY);
				var xz:Number = e.stageX - _CanX;
				var yz:Number = _CanY - e.stageY;
				var tanC:Number;
				if (yz <= 0) tanC = 90;
				else tanC = AgentUtil.getAngle(0, 0, xz, yz);
				if (xz <= 0) tanC = -tanC;
				cannon.rotation = tanC;
				_CanRotation = tanC;
			}
		}
		
		public function gWidth():Number
		{
			return bg.width;
		}
		public function gHeight():Number
		{
			return bg.height;
		}
		
		/**
		 * 添加到舞台
		 */
		public function gAddChild(obj:DisplayObject):void
		{
			sandwich.addChild(obj);
		}
		/**
		 * 从舞台移除
		 */
		public function gRemoveChild(obj:DisplayObject):void
		{
			sandwich.removeChild(obj);
		}
		
		/**
		 * 判断对象是否超出屏幕范围
		 */
		public function isOutOfScreen(obj:DisplayObject):Boolean
		{
			return !bg.hitTestObject(obj);
		}
		
		private function dpsub(e:Event):void {
			e.stopImmediatePropagation();
			if (DateS.Level == 1) {
				DateS.Level = 7;
			}else {
				DateS.Level = DateS.Level - 1;
			}
			synCannon();
		}
		
		private function dpadd(e:Event):void {
			e.stopImmediatePropagation();
			if (DateS.Level == 7) {
				DateS.Level = 1;
			}else {
				DateS.Level = DateS.Level + 1;
			}
			synCannon();
		}
		
		public function synCannon() {
			cannon.addEventListener(Event.ADDED , func);
			cannon.gotoAndStop(DateS.Level);
		}
		function func (event:Event):void {
			if (cannon.getChildByName("can" + DateS.Level) != null) {
				canMc = cannon.getChildByName("can" + DateS.Level) as MovieClip;
				cannon.removeEventListener(Event.ADDED , func);
		  }
		}
		
		public function setFps(fps:int):void {
			fpsTxt.text = String(fps);
		}
		
		public function get CanX():Number 
		{
			return _CanX;
		}
		
		public function get CanY():Number 
		{
			return _CanY;
		}
		
		public function get CanRotation():Number 
		{
			return _CanRotation;
		}
		
		public function get CanIsAttack():Boolean 
		{
			return _CanIsAttack;
		}
	}

}