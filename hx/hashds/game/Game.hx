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
	public function _getEntityList():DMixList<Entity> {  // NOTE, for read-only purposes only!
		return _entityList;
	}
	#end
	
	


	public function new() 
	{
		_updateState = new GameUpdate();
		_familyHash = new Dictionary();
		_familyList = new MixList<Family>();
		_systemList = new DMixPriorityList<GameSystem>();
		
		#if !gameFixed
		_entityList = new DMixList<Entity>();
		#end
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
		var c:Family;
		while (f != null) {
			
			if ( f._contains(entity)) {  // Family contains entity at root
				if (!f._matches(entity)) __removeEntityFrom(f, entity)  // no longer matches, so remove
				else if (f._secondList!=null) {  // yes, it matches, and  could still be updgraded to 2nd list item
					c = f._secondList;
					while ( c != null) {
						if (c._matches(entity)) {  // upgraded to 2nd list item
							__removeEntityFrom(f, entity);
							c._confirmAddEntity(entity);
							break;
						}
						c = c.next;
					}
				}
			}
			else if (f._secondList!=null) {  // Famiy doesn't contain entity at root, but could potentially exist in 2nd list previously
				c = f._secondList;
				if (f._matches(entity)) {  //  entity component confirgration now matches root.
					var lastChoice:Family = null;
					var choice:Family = f;  // by default, will choose the root.
					while ( c != null) {  // check for last available state within this family list., (if available)
						if (c._contains(entity)) {
							lastChoice = c;
							break;
						}
						c = c.next;
					}
					
					c = f._secondList;
					while ( c != null) { // check for potentially new available state within this family list.
						if (c._matches(entity)) {
							choice = c;
							break;
						}
						c = c.next;
					}
					
					if (lastChoice != null) {  // it existed in this list previously as a valid choice
						if (choice != lastChoice) {  // need to migrate from lastChoice
							__removeEntityFrom(lastChoice, entity);
							choice._confirmAddEntity(entity);
						}
						// else keep lastChoice, as it's nested in the list and takes higher priority
					}
					else  {   // no lastChoice within nested list, so use the newly chosen one and simply add it in
						choice._confirmAddEntity(entity);
					}
				}
				else {  // no match of entity to root, so will never need to do adding at all
					while ( c != null) {  // go through mandatory list at 2nd level to check for any possible need to remove entity that still exists
						if (c._contains(entity)) {
							__removeEntityFrom(f, entity);
							break;
						}
						c = c.next;
					}
				}
			}
			else f._addIfMatch(entity);  // without a 2nd list and without existing within family, can use default addIfMatch method
			f = f.next;
		}
	}
	
	public function notifyComponentsRemoved(entity:Entity):Void {
		var f:Family = _familyList.head;
		var c:Family;
		while (f != null) {
			
			if ( f._contains(entity)) {  // Family contains entity at root
				if (!f._matches(entity)) __removeEntityFrom(f, entity);  // no longer matches, so remove
				// else since components are being removed only, there's no possible case of upgrading from the root... (CHANGE FROM default method)
			}
			else if (f._secondList!=null) {  // Famiy doesn't contain entity at root, but could potentially exist in 2nd list previously
				c = f._secondList;
				if (f._matches(entity)) {  //  entity component confirgration now matches root.
					var lastChoice:Family = null;
					var choice:Family = f;  // by default, will choose the root.
					while ( c != null) {  // check for last available state within this family list., (if available)
						if (c._contains(entity)) {
							lastChoice = c;
							break;
						}
						c = c.next;
					}
					
					c = f._secondList;
					while ( c != null) { // check for potentially new available state within this family list.
						if (c._matches(entity)) {
							choice = c;
							break;
						}
						c = c.next;
					}
					
					if (lastChoice != null) {  // it existed in this list previously as a valid choice
						if (choice != lastChoice) {  // need to migrate from lastChoice
							__removeEntityFrom(lastChoice, entity);
							choice._confirmAddEntity(entity);
						}
						// else keep lastChoice, as it's nested in the list and takes higher priority
					}
					else  {   // no lastChoice within nested list, so use the newly chosen one and simply add it in
						choice._confirmAddEntity(entity);
					}
				}
				else {  // no match of entity to root, so will never need to do adding at all
					while ( c != null) {  // go through mandatory list at 2nd level to check for any possible need to remove entity that still exists
						if (c._contains(entity)) {
							__removeEntityFrom(f, entity);
							break;
						}
						c = c.next;
					}
				}
			}
			// else since no new components are being added, no need to addIfMatch (CHANGE FROM default method)
			f = f.next;
		}
	}
	
	public function notifyComponentsAdded(entity:Entity):Void {
		var f:Family = _familyList.head;
		var c:Family;
		while (f != null) {
			
			if ( f._contains(entity)) {  // Family contains entity at root
				// Since components are being added only, it'll definitely still match! Only posisble case is an upgrade.  (CHANGE FROM default method)
								//if (!f._matches(entity)) __removeEntityFrom(f, entity)  // no longer matches, so remove
								//else     
								//if (f._secondList!=null) {  // yes, it matches, and  could still be updgraded to 2nd list item
					c = f._secondList;
					while ( c != null) {
						if (c._matches(entity)) {  // upgraded to 2nd list item
							__removeEntityFrom(f, entity);
							c._confirmAddEntity(entity);
							break;
						}
						c = c.next;
					}
								//}
			}
			else if (f._secondList!=null) {  // Famiy doesn't contain entity at root, but could potentially exist in 2nd list previously, if the root family does match
				if (f._matches(entity)) {  //  entity component confirgration must match root to begin with
					var lastChoice:Family = null;
					var choice:Family = f;  // by default, will choose the root.
					
					c = f._secondList;
					while ( c != null) {  // check for last available state within this family list., (if available)
						if (c._contains(entity)) {
							lastChoice = c;
							break;
						}
						c = c.next;
					}
					
					c = f._secondList;
					while ( c != null) { // check for potentially new available state within this family list.
						if (c._matches(entity)) {
							choice = c;
							break;
						}
						c = c.next;
					}
					
					if (lastChoice != null) {  // it existed in this list previously as a valid choice
						if (choice != lastChoice) {  // need to migrate from lastChoice
							__removeEntityFrom(lastChoice, entity);
							choice._confirmAddEntity(entity);
						}
						// else keep lastChoice, as it's nested in the list and takes higher priority
					}
					else  {   // no lastChoice within nested list, so use the newly chosen one and simply add it in
						choice._confirmAddEntity(entity);
					}
				}
				// else no match of entity to root, so will never need to do adding at all
				// since components are being added only in this method, but it doesn't match the root to begin with, there's no chance of adding or removing
				// in such a case.	
			}
			else f._addIfMatch(entity);  // without a 2nd list and without existing within family, can use default addIfMatch method
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
				var c:Family = f._secondList;
				while ( c != null) {
					if (c._contains(entity)) {
						c.remove(entity);
						break;
					}
					c = c.next;
				}
			}
			f = f.next;
		}
		#else
			entity._removeAllFamilyKeys();
		#end
		#if !gameFixed _entityList.remove( entity ); #end
		
		entity.pool.dispose(entity);
	}
	
	public function registerFamilyMap(familyMap:FamilyMap):Void {
		var map = familyMap._getMap();
		var iterator:Iterator<Dynamic> = map.iterator();	
	
		while (iterator.hasNext() ) {
			var key:Dynamic = iterator.next();
			var fam:Family = map.get( key );
			fam._setGameUpdate(_updateState);
			_setFamily(key, fam);
			
			//if (!fam.isSecondary()) _familyList.add(fam)
			//else throw
		}
		
		var list = familyMap._list;
		for (i in 0...list.length) {
			_familyList.add(list[i]);
		}
	}


	public function getDataStructure( nodeClass : Class<Dynamic> ) : Dynamic
	{
		if( _hasFamily(nodeClass) )
		{
			return _getFamily(nodeClass).getDataStructure();
		}
		else {
			if (!_extendsFromNode(Node)) {
				throw new Error("Class should extend from Node!!");
			}
			var defaultFamily : NodeListFamily = new NodeListFamily( untyped nodeClass );
		
			_setFamily( nodeClass, defaultFamily);
			defaultFamily._setGameUpdate(_updateState);
			_familyList.add(defaultFamily);

			#if !gameFixed
			var e:Entity = _entityList.head;
			while (e != null) {
				defaultFamily._addIfMatch(e);
				e = e.next;
			}
			#end
			
			return defaultFamily.getDataStructure();
		}
	}
	

	public function releaseNodeList( nodeClass : Class<Dynamic> ) : Void
	{
		if( _hasFamily(nodeClass) )
		{
			var fam:Family = _getFamily(nodeClass);
			_doDeleteFamily(fam, nodeClass);
			fam = fam._secondList;
			while (fam != null) {
				_doDeleteFamily(fam, fam.getNodeClass() );
				fam = fam.next;
			}
		}
	}
	
	private inline function _doDeleteFamily(fam:Family, nodeClass:Class<Dynamic>):Void {
		fam.cleanup();
		untyped __delete__(_familyHash, nodeClass);
		untyped __delete__(_familyHash, untyped fam.constructor);
		_deleteFamily(fam);
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