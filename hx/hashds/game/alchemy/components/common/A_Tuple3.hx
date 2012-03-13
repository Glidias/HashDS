package hashds.game.alchemy.components.common;
import flash.Memory;
import hashds.game.alchemy.A_Component;

/**
 * ...
 * @author Glenn Ko
 */

class A_Tuple3 extends A_Component
{

	public static inline var BLOCK_SIZE:Int = 12;


	public function new() 
	{
		super();
		_blockSize = BLOCK_SIZE;
	}
	
	@field public inline function get_x(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index *BLOCK_SIZE) );
	}
	@field public inline function get_y(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index *BLOCK_SIZE) + 1 );
	}
	@field public inline function get_z(index:Int):Float {
		return Memory.getFloat( _mem.offset + (index * BLOCK_SIZE) + 2 );
	}
	public inline function set_x(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index *BLOCK_SIZE), val );
	}
	public inline function set_y(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index *BLOCK_SIZE) + 1, val );
	}
	public inline function set_z(index:Int, val:Float):Void {
		Memory.setFloat( _mem.offset + (index * BLOCK_SIZE) + 2, val );
	}
	
	public inline function set(index:Int, x:Float, y:Float, z:Float):Void {
		set_x(index,x);
		set_y(index,y);
		set_z(index,z);
	}
		
	
	
}