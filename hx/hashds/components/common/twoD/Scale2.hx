package hashds.components.common.twoD;
import hashds.game.ComponentID;
import hashds.hutil.XY;
import hashds.hutil.XYZUtils;

/**
 * ...
 * @author Glidias
 */

class Scale2 implements XY
{
	public static var ID:Int = ComponentID.next();
		
	public var x:Float;
	public var y:Float;
	
	private function new() {
		
	}
	
	#if inlineCompGet inline #end
	public static function get(x:Float=0, y:Float=0):Scale2 {
		var me:Scale2 = new Scale2();
		XYZUtils.reset2(me, x,y);
		return me;
	}
	
}