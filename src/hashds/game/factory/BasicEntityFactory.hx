package hashds.game.factory;
import de.polygonal.ds.HashKey;
import hashds.game.Entity;
import hashds.game.EntityFactory;
import hashds.game.IEntityPool;

/**
 * ...
 * @author Glidias
 */

class BasicEntityFactory extends EntityFactory, implements IEntityPool
{

	public function new() 
	{
		super(this);
	}
	
	override public function create():Entity {
		var ent:Entity = new Entity();
		ent._construct();
		ent.pool = this;
		return ent;
	}
	
	/* INTERFACE hashds.game.IEntityPool */
	
	public function dispose(ent:Entity):Void 
	{
		ent._free();
	}
	
}