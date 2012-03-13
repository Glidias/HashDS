package hashds.game.alchemy;
import de.polygonal.ds.mem.MemoryAccess;
import flash.errors.Error;

/**
 *
 * @author Glenn Ko
 */

class A_Base 
{
	private var _blockSize:Int;	 // The recorded byte size of each block
	private var _totalBlocks:Int;  // The total active blocks to be processed
	private var _mem:MemoryAccess;


	public function new() 
	{
		_totalBlocks = 0;
	}
	
	public inline function getBlockSize():Int {
		return _blockSize;
	}
	public inline function getTotalBlocks():Int {
		return _totalBlocks;
	}
	public inline function getMemoryOffset():Int {
		return _mem.offset;
	}
	public inline function getDataOffset(index:Int):Int {
		return index * _blockSize;
	}
	
	public inline function init(allocateNumBlocks:Int):Void {
		_mem = new MemoryAccess(_blockSize * allocateNumBlocks);
	}
	
	
	private function checkValidBlockSize(blockSize:Int):Void {
		reflectBlockSize();
		if (_blockSize != blockSize) {
			throw new Error("Invalid block size discrepancy! Correct/Wrong:" + _blockSize + ", "+blockSize);
		}
	}
	
	// scans meta-data fields to determine block size
	private function reflectBlockSize():Void  {

	}

}