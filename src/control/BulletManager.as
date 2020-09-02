package control 
{
	import control.imp.Module;
	import model.bullet.Bullet;
	import model.DateS;
	/**
	 * ...
	 * @author ...
	 */
	public class BulletManager implements Module
	{
		var heart:Heart;
		
		public function BulletManager(heart:Heart) 
		{
			this.heart = heart;
			heart.bing(this);
		}
		
		var timeCount:int = 0;
		public function draw(cfps:Number) : void {
			if (--timeCount <= 0 && heart.sence.CanIsAttack) {
				if (DateS.subMoney(DateS.Level)) {
					this.heart.sence.synMoney();
					
					timeCount = 5;
					heart.sence.canAttackAnimain();
					var bul:Bullet = new Bullet(heart);
				}
			}
		}
	}

}