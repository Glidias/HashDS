package hashds.game.alchemy;
import de.polygonal.ds.IntIntHashTable;
import de.polygonal.ds.mem.IntMemory;
import flash.display.DisplayObject;
import flash.utils.Dictionary;
import flash.Vector;
import hashds.ds.MixList;
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
	
	private var _familyList:MixList<A_Family>;
	private var _familyHash:Dictionary;
	
	
	
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
		
		_familyHash = new Dictionary();
		_familyList = new MixList<A_Family>();
		
	}
	
	public inline function getNewComponentHash():IntIntHashTable {
		if (_ai != 0) return _entC[ _availEntIndices.get(--_ai) ];
		else {
			if (_entI == _entLen) growEntC();
			return _entC[_entI++];
		}	
	}
	
	public function registerComponentHash(hash:IntIntHashTable):Void {
		var fam:A_Family  = _familyList.head;
		while (fam != null) {
			fam._addIfMatchTable(hash);
			fam = fam.next;
		}
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