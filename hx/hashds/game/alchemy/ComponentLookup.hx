package hashds.game.alchemy;
import flash.Vector;

/**
 * Global component lookup list/hash singleton.
 * @author Glidias
 */

class ComponentLookup
{

	private static var _INSTANCE:ComponentLookup = new ComponentLookup();
	private var _list:Vector<A_Component>;
	
	private function new() {
		
		_list = new Vector<A_Component>();
	}

	private function register(comp:A_Component):Void {
		comp._index = _list.length;
		_list.push(comp);
	}
	
	public static function getList():Vector<A_Component> {
		return _INSTANCE._list;
	}
	public static function registerComponent(comp:A_Component):Void {
		_INSTANCE.register(comp);
	}
	
}