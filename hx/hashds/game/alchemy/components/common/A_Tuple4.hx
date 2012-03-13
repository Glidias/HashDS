package hashds.game.alchemy.components.common;
import flash.Memory;
import hashds.game.alchemy.A_Component;

/**
 * ...
 * @author Glenn Ko
 */

class A_Tuple4 extends A_Component
{

	public static inline var BLOCK_SHIFT:Int = 4;
	public static inline var BLOCK_SIZE:Int = (1 << BLOCK_SHIFT);

	public function new() 
	{
		super();
		_blockSize = BLOCK_SIZE;
	}
	
	@field public inline function get_x(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index << BLOCK_SHIFT) );
	}
	@field public inline function get_y(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index << BLOCK_SHIFT) + 1 );
	}
	@field public inline function get_z(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index << BLOCK_SHIFT) + 2 );
	}
	@field public inline function get_w(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index << BLOCK_SHIFT) + 3 );
	}
	
	public inline function set_x(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index << BLOCK_SHIFT), val );
	}
	public inline function set_y(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index << BLOCK_SHIFT) + 1, val );
	}
	public inline function set_z(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index << BLOCK_SHIFT) + 2, val );
	}
	public inline function set_w(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index << BLOCK_SHIFT) + 3, val );
	}
	
	public inline function set(index:Int, x:Int, y:Int, z:Int, w:Int=0):Void {
		set_x(index,x);
		set_y(index,y);
		set_z(index,z);
		set_w(index,w);
	}
	
	
	
}