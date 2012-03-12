package hashds.components.common.twoD;
import hashds.game.ComponentID;
import hashds.hutil.XY;
import hashds.hutil.XYZUtils;

/**
 * ...
 * @author Glidias
 */

class Size2 implements XY
{
	public static var ID:Int = ComponentID.next();
		
	public var x:Float;
	public var y:Float;
	
	private function new() {
		
	}
	
	#if inlineCompGet inline #end
	public static function get(x:Float=0, y:Float=0):Size2 {
		var me:Size2 = new Size2();
		XYZUtils.reset2(me, x,y);
		return me;
	}
	
}