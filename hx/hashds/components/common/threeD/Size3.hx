package hashds.components.common.threeD;
import hashds.game.ComponentID;
import hashds.hutil.XYZ;
import hashds.hutil.XYZUtils;

/**
 * ...
 * @author Glidias
 */

class Size3 implements XYZ
{
	public static var ID:Int = ComponentID.next();
		
	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	private function new() {
		
	}
	

	inline public static function get(x:Float=0, y:Float=0,z:Float=0):Size3 {
		var me:Size3 = new Size3();
		XYZUtils.reset3(me,x,y,z);
		return me;
	}
	
}