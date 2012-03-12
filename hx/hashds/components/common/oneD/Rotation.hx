package hashds.components.common.oneD;
import hashds.game.ComponentID;

/**
 * ...
 * @author Glidias
 */

class Rotation 
{
	public static var ID:Int = ComponentID.next();		
	public var amount:Float;
	
	public function new() 
	{
		
	}
	
	inline public static function get(amount:Float):Rotation {
		var me:Rotation = new Rotation();
		me.amount = amount;
		return me;
	}
	
}