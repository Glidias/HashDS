package hashds.game.nodes;
import hashds.ds.IDead;
import hashds.ds.IDLMixNode;
import hashds.ds.ISLMixNode;
import hashds.game.Entity;
import hashds.game.IEntityMarker;
import hashds.hutil.XYZ;
import hashds.ds.Indexable;
import haxe.rtti.Generic;

/**
 * Base class generic for singly-linked list entity node with a dead flag.
 * @author Glidias
 */

class SLEntLifeNode<T> implements ISLMixNode<T>, implements IEntityMarker, implements Generic, implements IDead
// boiler-plate
#if (!entityOwns && usePolygonal) , implements Indexable #end

{
	// IEntityMarker, IDLMixNode variables
	public var entity:Entity;
	public var next:T;

	public var dead:Bool;
	
	
	// boiler-plate if supporting polygonal and family owns hash implementation
	#if (!entityOwns && usePolygonal)
	public var index:Int;
	#end
	
	
	public function new() 
	{
		
	}

	
}