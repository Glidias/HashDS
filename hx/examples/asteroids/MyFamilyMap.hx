package examples.asteroids;
import examples.asteroids.nodes.DisplayPNode;
import examples.asteroids.nodes.DisplayPRNode;
import examples.asteroids.nodes.DisplayPRSANode;
import examples.asteroids.nodes.DisplayPSANode;
import examples.asteroids.nodes.LifeNode;
import examples.asteroids.nodes.MovementNode;
import hashds.game.FamilyMap;

/**
 * ...
 * @author Glidias
 */

class MyFamilyMap extends FamilyMap
{


	public function new() 
	{
		super();
		
		var renderFamily= new hashds.game.family.DLMixListFamily<DisplayPNode>(DisplayPNode);
		renderFamily.setupSecondList(
		[
			new hashds.game.family.DLMixListFamily<DisplayPRNode>(DisplayPRNode),
			new hashds.game.family.DLMixListFamily<DisplayPRSANode>(DisplayPRSANode),
			new hashds.game.family.DLMixListFamily<DisplayPSANode>(DisplayPSANode)
		]
		);
		add( renderFamily );
		
		add( new hashds.game.family.SLifeListFamily<LifeNode>(LifeNode) );
		add( new hashds.game.family.DLMixListFamily<MovementNode>(MovementNode) );
		
		// todo: quick reflection of explcitly declared families!
		add(MyCollisionGroups.ASTEROIDS_ALL);
		add(MyCollisionGroups.SPACESHIPS_ALL);
		add(MyCollisionGroups.PLAYER_BULLETS);
		
	}
	
}

