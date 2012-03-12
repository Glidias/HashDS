package hashds.game;


import flash.errors.Error;
import hashds.ds.ISLMixNode;
import hashds.game.factory.BasicEntityFactory;
import hashds.signals.Signal0;
import hashds.signals.Signal1;
import hashds.signals.Signal2;
import hashds.ds.IDLMixNode;

#if usePolygonal 
import de.polygonal.ds.HashKey;
import de.polygonal.ds.Hashable;
import de.polygonal.ds.IntHashTable; 
#else
import flash.utils.Dictionary;
#end

/**
 * An Entity is a bag of components, which contain the data necessary for game-world systems to operate on.
 * @author Glidias
 */
class Entity #if usePolygonal implements Hashable #end
#if !gameFixed #if usePolygonal,#end implements IDLMixNode<Entity>  #end
{
	#if usePolygonal
	public var key:Int;
	public var componentHash:IntHashTable<Dynamic>;
	#else
	public var componentHash:Dictionary;
	#end
	
	public var pool:IEntityPool;
	public var next:Entity;
	#if !gameFixed public var prev:Entity; #end
	
	public var typeMask:Int;
	
	
	#if ( component32 || component64 )
		public var componentMask:Int;  
		#if component64
		public var componentMask2:Int;
		#end
	#end
	

	#if ( family32 || family64 )
		public var familyMask:Int;  
		#if family64
		public var familyMask2:Int;
		#end
	#end

	private static var FACTORY:EntityFactory = new BasicEntityFactory();

	
	#if usePolygonal
	private static inline var INIT_COMPONENT_HASH_SLOTCOUNT:Int = 4;
	private static inline var INIT_COMPONENT_HASH_CAPACITY:Int = INIT_COMPONENT_HASH_SLOTCOUNT;
	private static inline var INIT_COMPONENT_HASH_RESIZABLE:Bool = true;
	private static inline var INIT_COMPONENT_HASH_MAXSIZE:Int = -1;
	#end
	
	// hooks if needed
	//#if entityOnRemoved public var entityOnRemoved:Signal0; #end
	//public var onRemoveEntity:Signal1<Entity>;

	public function new() 
	{
		
	}
	
	public inline function _construct():Void {
		#if usePolygonal
		key = HashKey.next();
		componentHash = new IntHashTable<Dynamic>(INIT_COMPONENT_HASH_SLOTCOUNT, INIT_COMPONENT_HASH_CAPACITY, INIT_COMPONENT_HASH_RESIZABLE, INIT_COMPONENT_HASH_MAXSIZE);
		#else
		componentHash = new Dictionary();
		#end
		
		typeMask = 0;
		
		#if (component32 || component64)
			componentMask = 0;
			#if (component64)
			componentMask2 = 0;
			#end
		#end
	}
	
	#if entityOwns	
	private var _familyKeys:FamilyKey;
	private static var _FAM_KEY_:FamilyKey; // pool of family keys
	
	public inline function _addFamilyKey(fam:Family, key:Dynamic):Void {
		var k:FamilyKey = _FAM_KEY_ != null ? _FAM_KEY_ : new FamilyKey();
		k.family  = fam;
		k.key = key;
		
		_FAM_KEY_ = k.next;
		
		k.next = _familyKeys;
		_familyKeys = k;
		
	}
	public inline function _removeFrom(fam:Family):Void {
		// linear (o(n)) search of singly-linked list for removal
		var k:FamilyKey = _familyKeys;
		var lastK:FamilyKey = null;
		while ( k != null) {
			if (k.family == fam) {
				if (lastK != null) lastK.next = k.next;
				else _familyKeys = k.next;
				#if (family32 || family64) k.family.cleanupEntity(this) #end
				k.family.removeNodeByKey(k.key);
				k.next = _FAM_KEY_;
				_FAM_KEY_ = k;
				
				break;
			}
			lastK = k;
			k = k.next;
		}
	}
	public inline function _removeAllFamilyKeys():Void 
	{
		var k:FamilyKey = _familyKeys;
		var lastK:FamilyKey = null;
		while (k != null) {
			#if (family32 || family64) k.family.cleanupEntity(this) #end
			k.family.removeNodeByKey(k.key);
			lastK = k;
			k = k.next;
		}
		if (lastK != null) {
			lastK.next = _FAM_KEY_;
			_FAM_KEY_ = _familyKeys;
		}
	}
	
	public inline function _belongsToFamily(fam:Family):Bool { 
		// linear (o(n)) search of singly-linked list for checking
		var k:FamilyKey = _familyKeys;
		var gotF:Bool = false;
		while ( k != null) {
			if (k.family == fam) {
			gotF = true;
				break;
			}
			k = k.next;
		}
		return gotF;
	}
	#end
	
	public inline function _resetComponents():Void {
		#if (component32 || component64)
			componentMask = 0;
			#if (component64)
			componentMask2 = 0;
			#end
		#end

		#if usePolygonal
		   componentHash.clear();
		#else
			componentHash = new Dictionary();   // to benchmark: delete keys instead of create new instance?
		#end
	}
	
	public inline function _free():Void {
		#if (usePolygonal && alchemy)
			componentHash.free();
		#else
			//componentHash = null;  // not necessary i think, since entity is already freed
		#end
	}
	
	

	/**
	 * Default entity creation factory method. Though it's best to compose your own EntityFactory implementation
	 * accordingly.
	 * @return
	 */
	public static function get():Entity {
		return FACTORY.create();
	}
	
	

	#if !usePolygonal inline #end 
	public  function addComponent(comp:Dynamic, classe:Dynamic = null):Void {
		#if usePolygonal
		componentHash.set( (classe == null ? comp.constructor : classe).ID, comp);
		#else
		untyped componentHash[ (classe == null ? comp.constructor : classe).ID ] = comp;
		#end
	}	
	

	public inline function removeComponent(classe:Dynamic):Void {
		var ider:Int = classe.ID;
		#if usePolygonal
		componentHash.remove(ider);
		#else
		untyped __delete__(componentHash, ider);
		#end
	}
	
	
	public inline function getComponent(key:Int):Dynamic {
		#if usePolygonal
		return componentHash.get(key);
		#else
		return untyped componentHash[key];
		#end
	}
	
	public inline function hasComponent(key:Int):Bool {
		#if usePolygonal
		return componentHash.has(key);
		#else
		return untyped componentHash[key];
		#end
	}
	

	
	
}


#if entityOwns
class FamilyKey implements ISLMixNode<FamilyKey> {
	public var family:Family;
	public var key:Dynamic;
	public var next:FamilyKey;
	
	public function new() {
		
	}
}
#end
