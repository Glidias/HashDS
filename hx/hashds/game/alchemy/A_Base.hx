package hashds.game.alchemy;
import de.polygonal.ds.mem.IntMemory;
import de.polygonal.ds.mem.MemoryAccess;
import flash.errors.Error;
import hashds.game.alchemy.ds.MemoryDS;

/**
 *	Provides standard boiler-plate for alchemy memory operations with components and nodes.
 * @author Glenn Ko
 */

class A_Base 
{
	public var _mem:MemoryDS;
	private var _blockSize:Int;

	public function new() 
	{
		
	}
	
	// Memory DS proxy methods
	public inline function getAvailableAddress():Int {
		return _mem.getAvailableAddr(_blockSize);
	}
	public inline function getBlockSize():Int {
		return _blockSize;
	}
	public inline function getMemorySize():Int {
		return _mem.bytes;
	}
	public inline function getMemoryUsed():Int {
		return _mem.getUsedBytes();
	}
	public inline function getMemoryOffset():Int {
		return _mem.offset;
	}
	public inline function getUsedBytes():Int {
		return _mem.getUsedBytes();
	}
		

	
	// Other utility methods
	public inline function getBlockOffset(index:Int):Int {
		return index * _blockSize;
	}
	public inline function getAddressAtIndex(index:Int):Int {
		return _mem.offset + getBlockOffset(index);
	}
	public inline function getTailAddress():Int  {
		return _mem.offset + getMemoryUsed() - _blockSize;
	}
	
	// --Private utility method for extended classes
	private inline function _init(allocateNumBlocks:Int, allocateAvailIndices:Int, useExistingMem:Bool = false, existingMem:MemoryDS = null):Void {
		if (useExistingMem) {
			_mem = existingMem;
		}
		else {
			_mem = new MemoryDS(_blockSize * allocateNumBlocks, allocateAvailIndices);
		}
	}
	
	private function checkValidBlockSize(blockSize:Int):Void {
		reflectBlockSize();
		if (_blockSize != blockSize) {
			throw new Error("Invalid block size discrepancy! Correct/Wrong:" + _blockSize + ", "+blockSize);
		}
	}
	
	// todo: scans meta-data fields to determine block size
	private function reflectBlockSize():Void  {

	}

}