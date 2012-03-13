package examples.asteroids;
import examples.asteroids.systems.DisplaySystem;
import hashds.game.Game;
import hashds.game.HashDSGame;
import hashds.signals.Signal0;
import hashds.signals.Signal1;
import hashds.signals.Signal2;
import hashds.signals.Signal3;
import hashds.signals.SignalAny;

/**
 * ...
 * @author Glidias
 */

class MainHaxe 
{
	static function main() 
	{
		// Families
		MyCollisionGroups;
		MyFamilyMap;
		
		// Systems
		DisplaySystem;
		
		
		// HashDS
		HashDSGame;

	}
	public function new() 
	{
		// Signal types
		new Signal1<Float>();
	}
	
}