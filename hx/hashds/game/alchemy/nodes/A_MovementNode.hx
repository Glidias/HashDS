package hashds.game.alchemy.nodes;
import flash.Memory;
import hashds.components.common.twoD.Position2;
import hashds.game.alchemy.A_Node;
import hashds.game.alchemy.components.common.A_Tuple2;
/**
 * Example A_Node. 
 * All field and component metadata is used to determine size of data block. Component metadata
 * is also used for dependency injection from the given A_Family. 
 * @author Glidias
 */

class A_MovementNode extends A_Node
{
	@component('position') public var position:A_Tuple2;
	@component('velocity') public var velocity:A_Tuple2;
	@component('rotation') public var rotation:A_Tuple2;
	
	@componentOrder('position', 'velocity', 'rotation')
	public static inline function myComponents(position:A_Tuple2, velocity:A_Tuple2, rotation:A_Tuple2):Void { }

	public function new() 
	{
		super();
	}
	
	
	// component address offset getters for systems
	
	public inline function get_position(addr:Int):Int {
		return Memory.getI32( addr );
	}
	public inline function get_velocity(addr:Int):Int {
		return Memory.getI32( addr + 4 );
	}
	public inline function get_rotation(addr:Int):Int {
		return Memory.getI32( addr + 8);
	}
	
	// any extra fields assosiated with the given node for the current system
	
	@field public inline function get_offsetRotation(addr:Int):Float {
		return Memory.getFloat( addr + 12);
	}
	public inline function set_offsetRotation(addr:Int, val:Float):Void {
		Memory.setFloat( addr + 12, val);
	}
	
	
}