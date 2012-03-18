package hashds.game.alchemy;
import de.polygonal.ds.mem.IntMemory;
import de.polygonal.ds.mem.MemoryAccess;
import flash.errors.Error;
import hashds.game.alchemy.ds.MemoryDS;
import haxe.rtti.Meta;

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
		_reflectBlockSize();
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
		//_reflectBlockSize();
		if (_blockSize != blockSize) {
			throw new Error("Invalid block size discrepancy! Correct/Wrong:" + _blockSize + ", "+blockSize);
		}
	}
	
	
	private function _reflectBlockSize():Void  {
		var untypedThis:Dynamic = this;
		var fields = Meta.getFields(untypedThis.constructor);
		var size:Int = 0;
		var reflectedFields =  Reflect.fields(fields);
		var namer;
		var comp:Dynamic;
		var typer;
		var fieldTail:Int;
		var untypedField:Dynamic;
		
		for (i in reflectedFields) {
			var obj = Reflect.field(fields, i);
			// bad hack
			if ( Std.string(obj.field) != "undefined") {  // somehow, public method fields don't work for !=null. GOt to use this hack
				var typer = Type.typeof(obj.field);
					switch(typer  ) {
						case ValueType.TNull:
							size += 4;
					
						case ValueType.TClass(Array):
						untypedField = obj.field;
						fieldTail = obj.field.length - 1;
						if (untypedField[fieldTail] == 8) {
							size += 1;
						}
						else if (untypedField[fieldTail] == 16) {
							size += 2;
						}
						else if (untypedField[fieldTail] == 32) {
							size += 4;
						}
						else {
							throw new Error("Could not resolve bit size for field:"+i + ", "+untypedField[fieldTail] + ", "+Type.typeof(untypedField[fieldTail]));
						}
						default: throw new Error("Couldn't resolve component meta-data type:" + typer);
				}
			}
			else if (Std.string(obj.component) != "undefined"  ) {   // bad hack 
					var typer = Type.typeof(obj.component);
					switch(typer  ) {
						case ValueType.TNull:
							size += 4;
					
						case ValueType.TClass(Array):
							untypedField = obj.component;
							fieldTail = obj.component.length - 1;
							
							switch( Type.typeof(untypedField[fieldTail]) ) {
								case ValueType.TInt:
									
								if (untypedField[fieldTail] == 8) {
									size += 1;
								}
								else if (untypedField[fieldTail] == 16) {
									size += 2;
								}
								else if (untypedField[fieldTail] == 32) {
									size += 4;
								}
								else {
									throw new Error("Could not resolve bit size for field:"+i + ", "+untypedField[fieldTail] );
								}
								
								default:
								size += 4;
							}
						default: throw new Error("Couldn't resolve component meta-data type:" + typer);
				}
			}	
		}
		
		_blockSize = size;
	}

}