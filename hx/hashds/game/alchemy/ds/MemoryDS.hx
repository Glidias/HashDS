package hashds.game.alchemy.ds;
import de.polygonal.ds.mem.IntMemory;
import de.polygonal.ds.mem.MemoryAccess;

/**
 * MemoryAccess warapper for HashDS to support pooling of available memory access data blocks within component/node framework
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
	
	
	public inline function getAvailableAddr(blockSize:Int):Int {
		if (_ai != 0) return (offset+_availAddr.get(--_ai));  
		else return (offset + (_used += blockSize));
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