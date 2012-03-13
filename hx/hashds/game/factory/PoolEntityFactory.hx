package hashds.game.factory;
import hashds.game.Entity;
import hashds.game.EntityFactory;
import hashds.game.IEntityPool;

/**
 * This factory pools entities, but disposes off their component configurations.
 * @author Glidias
 */

class PoolEntityFactory extends EntityFactory, implements IEntityPool
{
	private var pool:Entity;

	public function new() 
	{
		super(this);
	}
	
		
	override public function create():Entity {
		var ent:Entity;
		if (pool != null) {
			ent = pool;
			pool = pool.next;
		}
		else {
			ent = new Entity();
			ent._construct();
			ent.pool = this;
		}
		return ent;
	}
	
	/* INTERFACE hashds.game.IEntityPool */
	
	public function dispose(ent:Entity):Void 
	{
		ent._resetComponents();
		ent.next = pool;
		pool = ent;
	}
	
}