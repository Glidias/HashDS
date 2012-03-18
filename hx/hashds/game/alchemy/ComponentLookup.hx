package hashds.game.alchemy;
import flash.errors.Error;
import flash.utils.Dictionary;
import flash.Vector;
import flash.xml.XML;
import flash.xml.XMLList;
import haxe.rtti.Meta;

/**
 * Singleton/global component lookup list, hash  and injector.
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
	
	
	public static function injectComponentsInto(target:Dynamic):Int {
		var fields = Meta.getFields(target.constructor);
		var count:Int = 0;
		
		// use FLash since RTTI not necessary for flash-only target. 
		var describeType:Dynamic = untyped __global__["flash.utils.describeType"];
		var xml:XML = new XML(describeType(target.constructor));
		var xmlList:XMLList = xml.child("factory").child("variable");
		var len:Int = xmlList.length();
		
		var dict:Dictionary = new Dictionary();
		for ( i in 0...len) {
			var atom:XML = xmlList[i];
			untyped dict[atom.attribute("name").toString()] = atom.attribute("type").toString();		
		}
		
		var reflectedFields =  Reflect.fields(fields);
		var namer;
		var comp:Dynamic;
		for (i in reflectedFields) {
			var obj = Reflect.field(fields, i);
			if (Std.string(obj.component) == "undefined") continue; //bad hack
			count++;
			namer = null;
			var typer = Type.typeof(obj.component);
			switch( typer ) {
				case ValueType.TNull:
				comp = getComponentByKey( getKeyForComponentClasse(Type.resolveClass(untyped dict[i]), null) );
				untyped target[i] = comp;
			
				continue;
				
				case ValueType.TClass(Array):
				if (obj.component.length == 0) throw new Error("Array params are of zero length!");
				comp =  getComponentByKey( getKeyForComponentClasse(Type.resolveClass(untyped dict[i]), untyped obj.component[0]) );
				untyped target[i] = comp;
				
				count++;
				continue;

				default:
				throw new Error("Couldn't resolve component meta-data type:" + typer);
				continue;		
			}
		}
		
		return count;
	}
	
	public static inline function getKeyForComponent(comp:IComponentDS):String {
		return getKeyForComponentClasse(Type.getClass(comp), comp.getName());
	}
	public static inline function getKeyForComponentClasse(classe:Class<Dynamic>, name:String):String {
		return Type.getClassName(classe) + (name != null ? "@" + name : "" );
	}
	
	public static function getComponentByKey(key:String):Dynamic {
		var instance:Dynamic =  _INSTANCE.getComponent(key);
		if (instance == null) throw new Error("Failed to get component by key:" + key);
		return instance;
	}

	public static function getList():Vector<IComponentDS> {
		return _INSTANCE._list;
	}
	public static function registerComponent(comp:IComponentDS):Int {
		return _INSTANCE.register(comp);
	}
	
}