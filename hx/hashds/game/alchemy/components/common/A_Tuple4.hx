package hashds.game.alchemy.components.common;
import de.polygonal.ds.IntIntHashTable;
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

	public function new(name:String=null) 
	{
		super(name);
		_blockSize = BLOCK_SIZE;
	}
	public inline function add(hash:IntIntHashTable, x:Float=0, y:Float=0, z:Float=0, w:Float=0):Void {
		var addr:Int = getAvailableAddress();
		hash.set(_id, addr);
		set(addr, x, y, z, w);
	}
	/*
	override public function addDefault(hash:IntIntHashTable):Bool {
		add(hash);
		return true;
	}
	*/
	
	@field public inline function get_x(addr:Int):Float {
		return Memory.getFloat( addr );
	}
	@field public inline function get_y(addr:Int):Float {
		return Memory.getFloat( addr + 4 );
	}
	@field public inline function get_z(addr:Int):Float {
		return Memory.getFloat( addr + 8);
	}
	@field public inline function get_w(addr:Int):Float {
		return Memory.getFloat( addr + 12);
	}
	
	public inline function set_x(addr:Int, val:Float):Void {
		Memory.setFloat( addr, val );
	}
	public inline function set_y(addr:Int, val:Float):Void {
		Memory.setFloat( addr+4, val );
	}
	public inline function set_z(addr:Int, val:Float):Void {
		Memory.setFloat( addr+8, val);
	}
	public inline function set_w(addr:Int, val:Float):Void {
		Memory.setFloat( addr+12, val );
	}
	
	public inline function set(addr:Int, x:Float, y:Float, z:Float, w:Float=0):Void {
		set_x(addr,x);
		set_y(addr,y);
		set_z(addr,z);
		set_w(addr,w);
	}
	
	
	
}