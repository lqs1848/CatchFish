package util 
{
	/**
	 * ...
	 * @author heliotrope
	 */
	public class AgentUtil 
	{
		public static function getAngle(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			// 直角的边长
			var x:Number = Math.abs(x1 - x2);
			var y:Number = Math.abs(y1 - y2);
			// 斜边长
			var z:Number = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
			// 余弦
			var cos:Number = y / z;
			// 弧度
			var radina:Number = Math.acos(cos);
			// 角度
			var angle:Number =  180 / (Math.PI / radina);
			return angle;
		}
		
	}

}