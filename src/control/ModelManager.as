package control 
{
	import control.imp.Module;
	import model.DateS;
	import util.RanUtil;
	/**
	 * ...
	 * @author ...
	 */
	public class ModelManager implements Module
	{
		var heart:Heart;
		public function ModelManager(heart:Heart) 
		{
			this.heart = heart;
			heart.bing(this);
		}
		
		//计数器
		//模式持续计数器
		var mode_Count:int;
		//模式变化计数器
		var mode_ChangeCon:int;
		
		var isInit:Boolean = true;
		//当前执行的模式
		// 0清除所有界面上存在的鱼的模式 
		// 1正常出现鱼的模式
		var runMode:int = 3;
		
		public function draw(cfps:Number) : void {
			switch(runMode) {
				case 0:
					dismissal();
					break;
				case 1:
					model_General();
					break;
				case 2:
					model_Circling();
					break;
				case 3:
					model_OneToTwelve();
					break;
			}
			
			selectMode();
		}
		
		/**
		 * 移除掉所有的鱼
		 */
		public function dismissal() {
			if (isInit) {
				isInit = false;
				mode_Count = int.MAX_VALUE;
				DateS.dynSpeed = 0;	
				DateS.isNewFish = false;
				mode_ChangeCon = heart.fps * 6;
			}
			
			if(--mode_ChangeCon<=0 && DateS.poolSize > 0){//界面上还有剩余的鱼 加速让鱼退场
				DateS.dynSpeed += DateS.baseSpeed / heart.fps / 3;
			}
			if (DateS.poolSize == 0) {//界面上没有剩余的鱼了 重新选择模式
				DateS.dynSpeed = 0;
				mode_Count = 0;
				DateS.isNewFish = true;
			}
		}
		
		//随机选取出鱼的模式
		public function selectMode() {
			//判断是否需要重新选择模式
			if (--mode_Count <= 0) {
				isInit = true;
				if (runMode != 0) {
					runMode = 0;
				}else {
					runMode = 1;
					if (Math.random() > 0.9)
						runMode = 2;
					if (Math.random() > 0.95)
						runMode = 3;
				}
			}
		}
		
		///-------------------------------------------普通的出鱼--------------------------------------------------------
		public function model_General() {
			if (isInit) {
				trace("进入模式一");
				isInit = false;
				//模式持续时间
				mode_Count = heart.fps * 3 * 60;
				mode_ChangeCon = 0;
				DateS.fishType = false;
				DateS.chance = 50;
				DateS.ranMove = false;
			}
			if (--mode_ChangeCon <= 0) {
				mode_ChangeCon = heart.fps * 20;
				DateS.radianBase = RanUtil.nextNum(6);
				DateS.fishShowModel = RanUtil.nextBoolean() ? 1 : 4;
				DateS.fishLifeSpeed = 100 + RanUtil.midValueNum(100);
			}
		}
		
		///-------------------------------------------从鱼类型1 到类型12 依次出现------------------------------------------
		//本次出现的鱼的类型
		var fishType:int = 0;
		public function model_OneToTwelve() {
			if (isInit) {
				trace("进入模式三");
				isInit = false;
				mode_ChangeCon = 0;
				DateS.fishType = true;
				DateS.chance = 75;
				DateS.ranMove = false;
				fishType = 0;
			}
			if (--mode_ChangeCon <= 0) {
				mode_ChangeCon = heart.fps * 15;
				mode_Count = mode_ChangeCon + 1;
				if (fishType < 12) fishType++;
				else mode_Count = 0;
				DateS.fishLifeSpeed = 300 * (100 / 12 * (13-fishType)/100);
				DateS.fishShowModel = RanUtil.nextBoolean() ? 2 : 3;
				DateS.fishTypeArr = [fishType];
			}
		}
		
		///-------------------------------------------鱼围绕水池巡游--------------------------------------------------------
		public function model_Circling() {
			if (isInit) {
				trace("进入模式二");
				isInit = false;
				mode_Count = heart.fps * 60;
				mode_ChangeCon = 0;
				DateS.fishType = false;
				DateS.chance = 66;
				DateS.ranMove = true;
				DateS.fishShowModel = 4;
			}
			if (--mode_ChangeCon <= 0) {
				mode_ChangeCon = heart.fps * 10;
				DateS.fishLifeSpeed = RanUtil.midValueNum(300) + 100;
				DateS.radianBase = RanUtil.nextNum(6);
			}
		}
		
	}//class
}