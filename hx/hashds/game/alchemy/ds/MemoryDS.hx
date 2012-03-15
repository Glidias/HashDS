package hashds.game.alchemy.ds;
import de.polygonal.ds.mem.IntMemory;
import de.polygonal.ds.mem.MemoryAccess;

/**
 * MemoryAccess warapper for HashDS to faciliiate pooling of available memory data access blocks within component/node framework,
 * and sharing of memory access buffer between components that have the same block size.
 * 
 * @author Glidias
 */

class MemoryDS extends MemoryAccess 
{

	private var _availAddr:IntMemory;
	private var _ai:Int;
	
	private var _used:Int;
	public inline function getUsedBytes():Int {
		return _used;
	}

	
	public function new(bytes:Int, allocateAvailSlots:Int, name:String= "?") 
	{
		super(bytes, name);
		
		_availAddr = new IntMemory(allocateAvailSlots, name + "_Indices");
		
		_ai = 0;
		_used = 0;
	}
	
	public inline function resetAvailAddrUsage():Void {
		_ai = 0;
	}
	public inline function getAvailAddrUsageCount():Int {
		return _ai;
	}
	public inline function getAvailAddrOffset():Int {
		return _availAddr.offset;
	}
	
	
	
	public inline function getAvailableAddr(blockSize:Int):Int {
		return _ai != 0 ? (offset + _availAddr.get(--_ai)) : (offset + (_used += blockSize));
	}
	
	public inline function freeAddr(addr:Int):Void 
	{
		_availAddr.set(_ai++, addr);
	}
	
	public inline function popUsage(blockSize:Int):Void 
	{
		_used -= blockSize;
	}
	
	
	

	
	
}