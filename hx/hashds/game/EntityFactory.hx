package hashds.game;
import flash.errors.Error;

/**
 * Abstract base class for entity factory, which are responsible for creating an entity and assining an IEntityPool 
 * reference to the entity to ensure it can be disposed off/reused accordinglly.
 * @author Glidias
 */

class EntityFactory 
{

	private function new(self:EntityFactory) 
	{
		
	}
	
	// defualt configuration for entity
	public function create():Entity {
		throw new Error("Please overwrite!");
		return null;
	}
	
}