package hashds.components.common.oneD;
import hashds.game.ComponentID;

/**
 * ...
 * @author Glidias
 */

class Age 
{
	public static var ID:Int = ComponentID.next();		
	public var life:Float;

	public function new() 
	{
		
	}
	
	inline public static function get(life:Float):Age {
		var me:Age = new Age();
		me.life = life;
		return me;
	}
}