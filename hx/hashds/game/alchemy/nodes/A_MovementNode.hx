package hashds.game.alchemy.nodes;
import flash.Memory;
import hashds.components.common.twoD.Position2;
import hashds.game.alchemy.A_Node;
import hashds.game.alchemy.components.common.A_Tuple2;


/**
 * Example A_Node
 * @author Glidias
 */

class A_MovementNode extends A_Node
{
	@component('position') public var position:A_Tuple2;
	@component('velocity') public var velocity:A_Tuple2;

	public function new() 
	{
		super();
	}
	
	public inline function get_position(addr:Int):Int {
		return Memory.getI32( addr );
	}
	public inline function get_velocity(addr:Int):Int {
		return Memory.getI32( addr + 4 );
	}

	
}