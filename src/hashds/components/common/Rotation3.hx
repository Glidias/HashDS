package hashds.components.common;
import hashds.game.ComponentID;
import hashds.hutil.XYZ;
import hashds.hutil.XYZUtils;



/**
 * ...
 * @author Glidias
 */

class Rotation3 implements XYZ
{
	public static var ID:Int = ComponentID.next();
	
	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	private function new() {
		
	}

	#if inlineCompGet inline #end
	public static function get(x:Float=0, y:Float=0, z:Float=0):Rotation3 {
		var me:Rotation3 = new Rotation3();
		XYZUtils.reset(me, x, y, z);
		return me;
	}
	
	
	
}