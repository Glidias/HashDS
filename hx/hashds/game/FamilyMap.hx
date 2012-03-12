package hashds.game;
import flash.utils.Dictionary;
import flash.utils.TypedDictionary;
import flash.Vector;
import hashds.ds.DLMixList;

/**
 * To facilitate initialization of strictly typed/custom families. Just keep using familyMap.add(familyInstance).
 * Also make sure if the family instance has any secondList items, you set up the nested 2nd list first before adding it to the
 * FamilyMap.
 * 
 * After setting up the map of families, use Game.registerFamilyMap(familyMap)
 * to register the strictly typed/custom families.
 * 
 * Currently, I feel this is the cleanest way to handle custom families.
 * 
 * @author Glidias
 */

class FamilyMap 
{
	private var _map:TypedDictionary<Dynamic, Family>;
	public inline function _getMap():TypedDictionary < Dynamic, Family > {
		return _map;
	}
	
	public var _list:Vector<Family>;
	
	function new() {
		_map = new TypedDictionary<Dynamic, Family>();
		_list  = new Vector<Family>();
	}
	
	public function add(instance:Family):Void {
		_list.push(instance);
		_map.set(instance.getNodeClass(), instance);
		_map.set(instance.getDataStructure().constructor, instance);
		var s:Family = instance._secondList;
		while (s != null) {
			_map.set(s.getNodeClass(), s);
			_map.set(s.getDataStructure().constructor, s);
			s = s.next;
		}
	}

}