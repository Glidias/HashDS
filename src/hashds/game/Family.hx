package hashds.game;
import flash.errors.Error;
import flash.utils.Dictionary;
import flash.Vector;
import flash.xml.XML;
import flash.xml.XMLList;
import hashds.ds.IDLMixNode;
import hashds.ds.Indexable;
import hashds.ds.ISLMixNode;
import hashds.game.Entity;
import haxe.rtti.XmlParser;

#if usePolygonal
import de.polygonal.ds.IntIntHashTable;
#end


/**
 * Abstract base class for Family. A Family provide a link between data structures with entities , their components, and the game itself.
 * It provides the boiler-plate code nececessary for reflection of nodes, and registering entities to a hash if required
 * for key 0(1) data-node lookups.
 * @author Glidias
 */

class Family implements ISLMixNode<Family>
{
		 
	#if (component64 || component32)
		private var _componentMask:Int;
		#if component64
		private var _componentMask2:Int;
		#end
	#end
	
	private var _gameUpdate:GameUpdate;
	
	private var _nodeClass:Class<Dynamic>;
	
	private var _inject:InjectionMapping;
	
	private var _typeMask:Int;
	
	// Unique id key, DO not change!
	private static var __COUNT__:Int = 0;
	public var key:Int;

	
	#if !entityOwns
		#if usePolygonal  // we assume family owns case for now
			private var _entHash:IntIntHashTable;
		#else
			private var _entHash:Dictionary;
		#end
	#end
	
	#if (usePolygonal && !entityOwns)  
	private var _nodes:Vector<Dynamic>;
	private var _nodeCount:Int;
	private static inline var PRE_ALLOCATE_NODE_SLOTS:Int = 64;  // cannot be less than 1! leave behind empty space for 1st slot.
	#end
	
	public var next:Family;
	public var _secondList:Family; 
	
	private var _numComponents:Int;
	
	private function new(self:Family, typeMasking:Int=0) 
	{
		
		if (self != this) throw new Error("Abstract class:: Family cannot be instantiated directly!");
		
		key = __COUNT__++;
		#if (family32 || family64)
			#if family64
				if (key >= 64) throw new Error("64 bit family key limit exceeded!");
			#else
				if (key >= 32) throw new Error("32 bit family key limit exceeded!");
			#end
		#end
		
		_numComponents = 0;
		#if (component64 || component32)
			_componentMask = 0;
			#if component64
			_componentMask2 = 0;
			#end
		#end
		
		_typeMask = typeMasking;
		
		#if !entityOwns
			#if usePolygonal
			_entHash = new IntIntHashTable(4, -1, true, -1);
			 _nodes = new Vector<Dynamic>(PRE_ALLOCATE_NODE_SLOTS);
			_nodeCount = 1;   
			#else
			_entHash = new Dictionary();
			#end
		#end
	}
	
	public function setupSecondList(arr:Array<Dynamic>):Void {
		arr.sort(_sortSecondaryChoicesMethod);
		var len:Int = arr.length;
		for (i in 0...len) { 
			var fam:Family = arr[i];
			fam.next = _secondList;
			_secondList = fam;
		}	
	}
	
	public function getSecondListAsArray():Array<Dynamic> {
		var arr:Array<Dynamic> = [];
		var s:Family = _secondList;
		while (s != null) {
			arr.push(s);
			s = s.next;
		}
		return arr;
	}
	
	public inline function _addIfMatch(entity:Entity):Void { 
		if (_matches(entity)) {
			_doAddConfirm(entity);
		}
	}
	public inline function _doAddConfirm(entity:Entity):Void {
		if (_secondList == null) {
			_confirmAddEntity(entity);
		}
		else {
			_addIfMatch2(entity);
		}
	}
	
	public inline function _addIfMatch2(entity:Entity):Void  // optional inline?
	{
		var choose:Family = this;
		var f:Family = _secondList;
		while (f != null) {
			if (f._matches(entity)) {
				choose = f;
				break;
			}
			f = f.next;
		}
		choose._confirmAddEntity(entity);
	}
	
	public inline function _confirmAddEntity(entity:Entity):Void {
		#if (family32 || family64) 
			#if (family64)
			if (key < 32) entity.familyMask |= (1 << key);
			else entity.familyMask2 |= (1 << (key&31));
			#else
				entity.familyMask |= (1 << key);
			#end
		#end
		
		#if !entityOwns
		add(entity);
		#else
		entity._addFamilyKey(this, add(entity));
		#end
	}
	
	
	private function _sortSecondaryChoicesMethod(fam1:Family, fam2:Family):Int {
		return fam1._numComponents  == fam2._numComponents ? 0 : fam1._numComponents  < fam2._numComponents  ? -1  : 1;
	}
	
	
	inline private function getNodeKeyByEntity(entity:Entity):Dynamic {
		#if !entityOwns
			#if (usePolygonal)
			return _nodes[_entHash.get(entity.key)];
			#else
			return untyped _entHash[entity];
			#end
		#else
		throw new Error("Family.getNodeKeyByEntity(entity::Entity) should not be called in entityOwns build!");
		return null;  // this method should not be called in entityOwns case
		#end
	}
	
	
	inline public function _setGameUpdate(gameUpdate:GameUpdate):Void {
		_gameUpdate = gameUpdate;
	}
	
	inline public function _contains(entity:Entity):Bool {
		#if (family32 || family64) 
			#if (family64)
			return (key < 32 ? (entity.familyMask & (1<<key))!=0 : (entity.familyMask2 & (1<<(key&31)))!=0 )  && (_typeMask == 0 || (entity.typeMask & _typeMask != 0) );
			#else
			return (entity.familyMask & (1<<key) ) != 0  && (_typeMask == 0 || (entity.typeMask & _typeMask != 0) );
			#end
		#else
			#if !entityOwns
				#if usePolygonal
				return _entHash.hasKey(entity.key);
				#else
				return untyped _entHash[entity];
				#end
			#else
				return entity._belongsToFamily(this);
			#end
		#end
	}
	
	inline public function _matches(entity:Entity):Bool {
		#if (component32 || component64) 
			#if (component64)
			return  (_componentMask== 0 || (_componentMask & entity.componentMask) != 0)   && (_componentMask2 == 0 || (_componentMask2 & entity.componentMask2) != 0) && (_typeMask == 0 || (entity.typeMask & _typeMask != 0) );
			#else
			return (_componentMask & entity.componentMask) != 0  && (_typeMask == 0 || (entity.typeMask & _typeMask != 0) );
			#end
		#else 
			var doesMatch:Bool = (_typeMask == 0 || (entity.typeMask & _typeMask) != 0);
			var i:InjectionMapping = doesMatch ? _inject : null;
			while (i != null) {
				if (!entity.hasComponent( i.id )) {
					doesMatch = false;
					break;
				}
				i = i.next;
			}
			return doesMatch;		
		#end
	}
	
	public function add( entity : Entity ) : Dynamic
	{
		throw new Error("Please overwrite!");
		return null;
	}
		
	// This method should NEVER be called in compile entityOwns build!
	public function remove( entity : Entity) : Void   
	{
		removeNodeByKey( getNodeKeyByEntity( entity) );
		_remove(entity);
	}
	
	
	
	
	public function removeNodeByKey(keyer:Dynamic):Void {
		throw new Error("Please overwrite!");
	}
	

	
	public function getDataStructure():Dynamic {
		throw new Error("Please overwrite!");
		return null;
	}
	
	#if (family32 || family64) 
	inline public function _cleanupEntity(entity:Entity):Void {
		
			#if (family64)
				if (key < 32) entity.familyMask &= ~(1 << key);
				else entity.familyMask2 &= ~(1 << (key&31));
			#else
				entity.familyMask &= ~(1 << key);
			#end
	
	}
	#end
	
	/**
	 * The default root.remove() implementation, All familes need to call this as required upon remove() or cleanup(), to clean up any hash references/listeners.
	 * @param	entity
	 */
	inline private function _remove(entity:Entity):Void {
		#if (family32 || family64)  _cleanupEntity(entity); #end
		#if !entityOwns
			#if usePolygonal
			_entHash.remove(entity.key);
			#else
			untyped __delete__(_entHash, entity);
			#end
		#end
	}
	
	inline public function getNodeClass():Class<Dynamic> {
		return _nodeClass;
	}
	
	public function cleanup():Void {
		throw new Error("Please overwrite!");
	}
	
	inline private function injectIntoNode(node:#if (usePolygonal && !entityOwns)Indexable #else Dynamic #end, entity:Entity):Void {
		untyped node["entity"] = entity;
		var i:InjectionMapping = _inject;
		while (i != null) {
			untyped node[i.name] =  entity.getComponent(i.id);
			i = i.next;
		}
		
		#if !entityOwns
			#if usePolygonal
			if (node.index == 0) { // a new node! register it to a >0 slot!
				node.index  = _nodeCount;
				_nodes[_nodeCount++] = node;
			}
			_entHash.set(entity.key, node.index);
			#else
			untyped _entHash[entity] = node;
			#end
		#end
	}
	
	private function _reflectClass(t:Class<Dynamic>):Void {
		_nodeClass = t;
		var dummyCheck:Dynamic = Type.createEmptyInstance(t);
		if ( !Reflect.hasField(dummyCheck, "entity" ) ) {
			throw new Error("Instance doesn't have entity field! "+dummyCheck);
		}
		if ( Reflect.hasField(t, "__rtti") ) _reflectClassRtti(t)
		else {
			_reflectClassAS3(t);
		}
		
		if (_numComponents == 0) throw new Error(this + ":: Invalid reflection! Found zero components for node!! " + t);
		#if (component64 || component32)
			#if component64
			if (_componentMask == 0 && _componentMask2 == 0)  throw new Error(this + ":: Invalid component masks! " + _componentMask + ", "+_componentMask2);
			#else
			if (_componentMask == 0)  throw new Error(this + ":: Invalid component mask! " + _componentMask );
			#end
		#end
	}
	
	private function _reflectClassAS3(t:Class<Dynamic>):Void {
		var describeType:Dynamic = untyped __global__["flash.utils.describeType"];
		var xml:XML = new XML(describeType(t));
		var xmlList:XMLList = xml.child("factory").child("variable");
		var len:Int = xmlList.length();
		for ( i in 0...len) {
			var atom:XML = xmlList[i];
			var compClass : Dynamic = Type.resolveClass( atom.attribute("type").toString() );
			if (compClass == null) continue;
			 if ( !Reflect.hasField(compClass, "ID")) continue;
			 switch(Type.typeof(compClass.ID)) {
					case TInt: 
					_registerField(atom.attribute("name").toString(), compClass.ID);
					default:   throw new Error("Non integer ID data type for component:" + Type.typeof(compClass.ID));
				}  
		}
	}
	
	private inline function _registerField(fieldName:String, compId:Int):Void {
		#if (component32 || component64) 
			#if component64
			if (compId < 32) _componentMask |= (1 << compId);
			else _componentMask2 |= (1 << (compId&31) );
			#else
			_componentMask |= (1 << compId); 
			#end
		#end	
		_numComponents++;
		
		var mapping:InjectionMapping = new InjectionMapping();
		mapping.id = compId;
		mapping.name = fieldName;
		mapping.next = _inject;
		_inject = mapping;
	}
	
	private function _reflectClassRtti(t:Class<Dynamic>):Void {
		 var rtti:String = untyped t.__rtti;
		   var x = Xml.parse(rtti).firstElement();
		   var infos = new XmlParser().processElement(x);

		   switch (infos) {
			   case TClassdecl(c):
				   //trace("Found class - " + c.path);

				   // scan the fields of the class looking for type information
				   var fieldTypes = new Hash<String>();
				   for (field in c.fields) {
					//   trace("field name: " + field.name);
					   switch (field.type) {
						   case CClass(name, params): if (field.isPublic) {
							  var compClass:Dynamic =  Type.resolveClass(name);
							  if ( !Reflect.hasField(compClass, "ID")) continue;
								switch(Type.typeof(compClass.ID)) {
									case TInt: 
									_registerField(field.name, compClass.ID);
									default:   throw new Error("Non integer ID data type for component:" + Type.typeof(compClass.ID));
								}  
						   }
						   //case CEnum(name, params):  fieldTypes.set( field.name, name );
						   default: continue;//trace("    skipping field: " + field.type);
					   }
				   }

				   // PROCESS FIELDS HERE

			   default: infos;
			}
	}
	
	
}

class InjectionMapping {
	public function new() {
		
	}
	public var next:InjectionMapping;
	public var name:String;
	public var id:Int;
}