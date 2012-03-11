package hashds.game;
import flash.errors.Error;
import flash.utils.Dictionary;
import flash.utils.TypedDictionary;
import hashds.ds.DMixList;
import hashds.ds.DMixPriorityList;
import hashds.ds.MixList;
import hashds.game.family.NodeListFamily;

/**
 * ...
 * @author Glidias
 */

class Game 
{
	private var _updateState:GameUpdate;
	private var _familyHash:Dictionary;
	private var _familyList:MixList<Family>;
	private var _systemList:DMixPriorityList<GameSystem>;
	
	#if !gameFixed
	private var _entityList:DMixList<Entity>;
	#end


	public function new() 
	{
		_updateState = new GameUpdate();
		_familyHash = new Dictionary();
		_familyList = new MixList<Family>();
		_systemList = new DMixPriorityList<GameSystem>();
	}
	

	public function addEntity( entity : Entity ) : Void
	{
		#if !gameFixed  _entityList.add( entity );  #end
		var f:Family = _familyList.head;
		while(f!=null) 
		{
			f._addIfMatch(entity);
			f = f.next;
		}
	}

	public function notifyComponentsChange(entity:Entity):Void {
		var f:Family = _familyList.head;
		while (f != null) {
			if ( f._contains(entity)) {
				if (!f._matches(entity)) __removeEntityFrom(f, entity);
			}
			else if (f._secondList != null && f._matches(entity)) { // potentialally in secondlist (do not overload 2nd condition?)
				_checkSecondListRemove(f, entity);
			}
			else f._addIfMatch(entity);
			f = f.next;
		}
	}
	
	public function notifyComponentsRemoved(entity:Entity):Void {
		var f:Family = _familyList.head;
		while (f != null) {
			if ( f._contains(entity) ) {
				if (!f._matches(entity)) __removeEntityFrom(f, entity);
			}
			else if (f._secondList != null && f._matches(entity)) { // potentialally in secondlist (do not overload 2nd condition?)
				_checkSecondListRemove(f, entity);
			}
		}
	}
	
	public function notifyComponentsAdded(entity:Entity):Void {
		var f:Family = _familyList.head;
		while (f != null) {
			if ( !f._contains(entity)) {
				f._addIfMatch(entity);
			}
			else if (f._secondList != null && f._matches(entity)) { // potentialally in secondlist (do not overload 2nd condition?)
				f._addIfMatch2(entity);
			}
			f = f.next;
		}
	}

	public function removeEntity( entity : Entity ) : Void
	{
		#if !entityOwns
		var f:Family = _familyList.head;
		while(f!=null) 
		{
			if ( f._contains( entity ) ) f.remove(entity);
			else if (f._secondList != null && f._matches(entity) ) {  // entity is potentially inside second-list
				f = f._secondList;
				while ( f != null) {
					if (f._contains(entity)) {
						f.remove(entity);
						break;
					}
					f = f.next;
				}
			}
		}
		#else
			entity._removeAllFamilyKeys();
		#end
		#if !gameFixed _entityList.remove( entity ); #end
	}
	
	public function registerFamilyMap(familyMap:FamilyMap):Void {
		var map = familyMap._getMap();
		var iterator:Iterator<Dynamic> = map.iterator();		
		while (iterator.hasNext() ) {
			var key:Dynamic = iterator.next();
			var fam:Family = map.get( key );
			untyped _familyHash[key] = fam;
			fam._setGameUpdate(_updateState);
		}
	}


	public function getDataStructure( nodeClass : Class<Dynamic> ) : Dynamic
	{
		if( _hasFamily(nodeClass) )
		{
			return _getFamily(nodeClass).getDataStructure(nodeClass);
		}
		else {
			if (!_extendsFromNode(nodeClass)) {
				throw new Error("Class should extend from Node!!");
			}
			var defaultFamily : NodeListFamily = new NodeListFamily( untyped nodeClass );

			_setFamily( nodeClass, defaultFamily);

			#if !gameFixed
			var e:Entity = _entityList.head;
			while (e != null) {
				defaultFamily._addIfMatch(e);
				e = e.next;
			}
			#end
			
			return defaultFamily.getDataStructure(nodeClass);
		}
	}
	

	public function releaseNodeList( nodeClass : Dynamic ) : Void
	{
		if( _hasFamily(nodeClass) )
		{
			var fam:Family = _getFamily(nodeClass);
			fam.cleanup(nodeClass);
			
			untyped __delete__(_familyHash, nodeClass);
			
			_deleteFamily(fam);
			
		}
	}
	
	public function addSystem(system:GameSystem, priority:Int):Void {
		system.priority = priority;
		system.addToGame( this );
		_systemList.add( system );
	}
	
	public function removeSystem(system:GameSystem):Void {
		_systemList.remove(system);
		system.removeFromGame( this );
	}


	
	public function update(dt:Float):Void {  // consider..timeframe instance or seconds?
		_updateState.isUpdating = true;
		var s = _systemList.head;
		while (s != null) {
			s.update(dt);
			s = s.next;
		}
		_updateState.isUpdating = false;
	}
	
	// -- Private methods helpers
	
	private inline function _checkSecondListRemove(f:Family, entity:Entity):Void {
		var c:Family = f._secondList;
		while ( c != null) {
			if (c._contains(entity)) {
				c.remove(entity);
				break;
			}
			c = c.next;
		}
		if (c == null) {  // not found in second list, so place in root family
			f._confirmAddEntity(entity);
		}
	}
	private inline function __removeEntityFrom(f:Family, entity:Entity):Void {
		#if !entityOwns
		f.remove(entity);
		#else
		entity._removeFrom(f);
		#end
	}
		
	private inline function _hasFamily(nodeClass:Class<Dynamic>):Bool {
		return untyped _familyHash[nodeClass];
	}
	private inline function _getFamily(nodeClass:Class<Dynamic>):Family {
		return untyped _familyHash[nodeClass];
	}
	private inline function _setFamily(nodeClass:Class<Dynamic>, fam:Family):Void {
		fam._setGameUpdate(_updateState);
		untyped _familyHash[nodeClass] = fam;
	}
	private inline function _deleteFamily(fam:Family):Void {
		_familyList.remove( fam );
	}
	private function _extendsFromNode(nodeClass:Class<Dynamic>):Bool {
		var c:Class<Dynamic> = nodeClass;
		var validC:Class<Dynamic>  = null;
		while ( c != null) {
			validC = c;
			c = Type.getSuperClass(nodeClass);
		}
		return validC == Node;
	}
	
	
	
	
	
	
}