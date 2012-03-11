package hashds.hutil;


class XYZUtils 
{
	inline public static function reset(me:XYZ, x:Float, y:Float, z:Float):Void {
		me.x = x;
		me.y = y;
		me.z = z;
	}
	
	inline public static function dotProduct(a:XYZ, b:XYZ):Float {
		return a.x * b.x + a.y * b.y + a.z * b.z;
	}
	
}