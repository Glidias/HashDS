package hashds.game;
import flash.utils.Dictionary;
import flash.utils.TypedDictionary;
import hashds.ds.DLMixList;

/**
 * To facilitate initialization of strictly typed/custom families.
 * 
 * After adding the relavant nodeClass to the given typed family instances, use Game.registerFamilyMap(familyMap)
 * or Game.registerFamilyMaps( an array of family maps ) to register strictly typed/custom families.
 * 
 * @author Glidias
 */

class FamilyMap 
{
	private var _map:TypedDictionary<Dynamic, Family>;
	public inline function _getMap():TypedDictionary < Dynamic, Family > {
		return _map;
	}
	
	function new() {
		_map = new TypedDictionary<Dynamic, Family>();
	}
	
	public function add(nodeClass:Dynamic, instance:Family):Void {
		_map.set(nodeClass, instance);
		_map.set(untyped instance.constructor, instance);
	}

}