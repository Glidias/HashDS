package hashds.game.alchemy;
import flash.utils.Dictionary;
import flash.Vector;

/**
 * Global component lookup list/hash singleton.
 * @author Glidias
 */

class ComponentLookup
{

	private static var _INSTANCE:ComponentLookup = new ComponentLookup();
	private var _list:Vector<IComponentDS>;
	private var _hash:Dictionary;
	
	private function new() {
		
		_list = new Vector<IComponentDS>();
		_hash = new Dictionary();
	}

	private function register(comp:IComponentDS):Int {
		var index:Int = _list.length;
		_list.push(comp);
		untyped _hash[getKeyForComponent(comp)] = comp;
		return index;
	}
	private inline function getComponent(key:String):Dynamic {
		return untyped _hash[key];
	}
	
	public static inline function getKeyForComponent(comp:IComponentDS):String {
		return getKeyForComponentClasse(Type.getClass(comp), comp.getName());
	}
	public static inline function getKeyForComponentClasse(classe:Class<Dynamic>, name:String):String {
		return Type.getClassName(classe) + (name != null ? "@" + name : "" );
	}
	
	public static function getComponentByKey(key:String):Dynamic {
		return _INSTANCE.getComponent(key);
	}

	public static function getList():Vector<IComponentDS> {
		return _INSTANCE._list;
	}
	public static function registerComponent(comp:IComponentDS):Int {
		return _INSTANCE.register(comp);
	}
	
}