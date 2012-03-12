package examples.asteroids
{
	import examples.asteroids.systems.AgeSystem;
	import examples.asteroids.systems.DisplaySystem;
	import examples.asteroids.tick.FrameTickProvider;
	import flash.display.DisplayObjectContainer;
	import hashds.game.Game;
	import examples.asteroids.systems.CollisionSystem;
	import examples.asteroids.systems.GameManager;
	import examples.asteroids.systems.GunControlSystem;
	import examples.asteroids.systems.MotionControlSystem;
	import examples.asteroids.systems.MovementSystem;
	import examples.asteroids.systems.SystemPriorities;
	import examples.asteroids.input.KeyPoll;



	public class Asteroids
	{
		private var container : DisplayObjectContainer;
		private var game : Game;
		private var tickProvider : FrameTickProvider;
		private var gameState : GameState;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		private var width : Number;
		private var height : Number;
		
		public function Asteroids( container : DisplayObjectContainer, width : Number, height : Number )
		{
			this.container = container;
			this.width = width;
			this.height = height;
			prepare();
		}
		
		private function prepare() : void
		{
			game = new Game();
			gameState = new GameState();
			creator = new EntityCreator( game );
			keyPoll = new KeyPoll( container.stage );
			
			game.registerFamilyMap( new MyFamilyMap() );

			///*
			game.addSystem( new GameManager( gameState, creator ), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem( keyPoll ), SystemPriorities.update );
			game.addSystem( new GunControlSystem( keyPoll, creator ), SystemPriorities.update );
			game.addSystem( new AgeSystem() , SystemPriorities.update );
			game.addSystem( new MovementSystem(), SystemPriorities.move );
			game.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			game.addSystem( new DisplaySystem( container ), SystemPriorities.render );
			//*/
			
			
			gameState.width = width;
			gameState.height = height;
			tickProvider = new FrameTickProvider( container );
		}
		
		public function start() : void
		{
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;

			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}
