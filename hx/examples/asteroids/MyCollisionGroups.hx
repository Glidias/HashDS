package examples.asteroids;
import examples.asteroids.nodes.RadialCollisionNode;

/**
 * ...
 * @author Glidias
 */

class MyCollisionGroups 
{
	public static inline var PLAYER:Int = 1;
	public static inline var SPACESHIP:Int = 2;
	public static inline var ASTEROID:Int = 4;
	public static inline var PLAYER_BULLET:Int = 8;
	
	public static var SPACESHIPS_ALL = new hashds.game.family.DLMixListFamily<RadialCollisionNode>(RadialCollisionNode, SPACESHIP );
	
	public static var ASTEROIDS_ALL = new hashds.game.family.DLMixListFamily<RadialCollisionNode>(RadialCollisionNode, ASTEROID);
	
	public static var PLAYER_BULLETS = new hashds.game.family.DLMixListFamily<RadialCollisionNode>(RadialCollisionNode,  PLAYER_BULLET);
	
	/*
	public function new() 
	{
		
	}
	*/
	
}