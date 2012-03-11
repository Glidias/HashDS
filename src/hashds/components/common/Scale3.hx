package hashds.components.common;
import hashds.game.ComponentID;
import hashds.hutil.XYZ;
import hashds.hutil.XYZUtils;


/**
 * ...
 * @author Glidias
 */

class Scale3 implements XYZ
{
	public static var ID:Int = ComponentID.next();
	
	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	private function new() {
		
	}
	
	#if inlineCompGet inline #end
	public static function get(x:Float=1, y:Float=1, z:Float=1):Scale3 {
		var me:Scale3 = new Scale3();
		XYZUtils.reset(me, x, y, z);
		return me;
	}
	
	
	
}