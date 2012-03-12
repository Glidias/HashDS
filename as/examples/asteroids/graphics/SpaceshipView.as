package examples.asteroids.graphics
{
	import flash.display.Shape;
	
	public class SpaceshipView extends Shape
	{
		public function SpaceshipView()
		{
			graphics.beginFill( 0xFFFFFF );
			graphics.moveTo( 8, 0 );
			graphics.lineTo( -7, 7 );
			graphics.lineTo( -4, 0 );
			graphics.lineTo( -7, -7 );
			graphics.lineTo( 10, 0 );
			graphics.endFill();
		}
		
	}
}
