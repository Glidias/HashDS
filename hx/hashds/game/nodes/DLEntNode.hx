package hashds.game.nodes;
import hashds.ds.IDLMixNode;
import hashds.game.Entity;
import hashds.game.IEntityMarker;
import hashds.hutil.XYZ;
import hashds.ds.Indexable;
import haxe.rtti.Generic;

/**
 * Base class generic for doubly-linked entity node
 * @author Glidias
 */

class DLEntNode<T> implements IDLMixNode<T>, implements IEntityMarker, implements Generic
// boiler-plate
#if (!entityOwns && usePolygonal) , implements Indexable #end

{
	// IEntityMarker, IDLMixNode variables
	public var entity:Entity;
	public var next:T;
	public var prev:T;
	
	// boiler-plate if supporting polygonal and family owns hash implementation
	#if (!entityOwns && usePolygonal)
	public var index:Int;
	#end
	
	
	public function new() 
	{
		
	}

	
}