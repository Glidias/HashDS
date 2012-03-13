package hashds.game.alchemy;
import flash.Memory;

/**
 * ...
 * @author Glenn Ko
 */

class A_Node extends A_Base
{
	
	public function new() 
	{
		super();
	}
	
	@field public inline function get_entity(index:Int):Int {
		return Memory.getI32( _mem.offset + (index*_blockSize) );
	}
		
	public inline function set_entity(index:Int, val:Int):Void {
		Memory.setFloat(_mem.offset + (index*_blockSize), val );
	}
	
	
	
}