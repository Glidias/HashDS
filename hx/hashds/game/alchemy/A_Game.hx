package hashds.game.alchemy;
import de.polygonal.ds.IntIntHashTable;
import de.polygonal.ds.mem.IntMemory;
import flash.display.DisplayObject;
import flash.Vector;
import hashds.game.alchemy.components.ds.VectorComponent;
import hashds.game.alchemy.nodes.ExampleFactory;

/**
 * ...
 * @author Glidias
 */

class A_Game 
{
	private var _entC:Vector<IntIntHashTable>;
	private var _entI:Int;
	private var _entLen:Int;
	
	private var _availEntIndices:IntMemory;
	private var _ai:Int;

	private var _entHashSlotCount:Int;
	private var _entHashCapacity:Int;
	private var _allocateEntityAmt:Int;
	private var _entAmtGrowShift:Int;
	
	
	
	public function new(allocateEntityAmt:Int, allocateAvailIndices:Int, entHashSlotCount:Int=4, entHashCapacity:Int=4, entAmtGrowShift:Int=1) 
	{
		_entHashSlotCount = entHashSlotCount;
		_entHashCapacity = entHashCapacity;
		_allocateEntityAmt = allocateEntityAmt;
		_entAmtGrowShift = entAmtGrowShift;
		
		_entC = new Vector<IntIntHashTable>(allocateEntityAmt);
		
		for (i in 0...allocateEntityAmt) {
			var hashTable:IntIntHashTable = new IntIntHashTable(entHashSlotCount, entHashCapacity);
			hashTable.key = i;
			_entC[i] = hashTable;
		}
		_entLen = allocateEntityAmt;
		_entI  = 0;
		
		_ai = 0;
		_availEntIndices = new IntMemory(allocateAvailIndices);
	}
	
	public inline function getNewComponentHash():IntIntHashTable {
		if (_ai != 0) return _entC[ _availEntIndices.get(--_ai) ];
		else {
			if (_entI == _entLen) growEntC();
			return _entC[_entI++];
		}	
	}
	
	public function registerComponentHash(hash:IntIntHashTable):Void {
		
	}
	
	private function growEntC():Void 
	{
		var newLen:Int = _entLen + (1 << _entAmtGrowShift);
		_entC.length = newLen;
		for (i in _entLen...newLen) {
			var hashTable:IntIntHashTable =  new IntIntHashTable(_entHashSlotCount, _entHashCapacity);
			hashTable.key = i;
			_entC[i] = hashTable;
		}
		_entLen = newLen;
	}
	
	
	
	public function getNode(nodeClass:Class<A_Node>):Dynamic {
		return null;
	}
	
}