package hashds.hutil;


class XYZUtils 
{
	inline public static function reset3(me:XYZ, x:Float, y:Float, z:Float):Void {
		me.x = x;
		me.y = y;
		me.z = z;
	}
	inline public static function reset2(me:XY, x:Float, y:Float):Void {
		me.x = x;
		me.y = y;
	}
	
	inline public static function dotProduct3(a:XYZ, b:XYZ):Float {
		return a.x * b.x + a.y * b.y + a.z * b.z;
	}
	inline public static function dotProduct2(a:XY, b:XY):Float {
		return a.x * b.x + a.y * b.y;
	}
	
}