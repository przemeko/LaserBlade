package com.kocznur 
{
	/**
	 * World
	 * Define main properties of game
	 * 
	 * @author pkocznur
	 */
	public class World 
	{
		/**
		 * Width
		 */
		public static const WIDTH:uint = 320;
		
		/**
		 * Height
		 */
		public static const HEIGHT:uint = 560;
		
		/**
		 * how many bullets can be rendered at one time
		 */
		public static const MAX_BULLETS_ON_STAGE:uint = 60;
		
		/**
		 * how many enemies can be rendered at one time
		 */
		public static const MAX_ENEMIES_ON_STAGE:uint = 30;
		
		/**
		 * Internal time of game. Use for bullet time mode
		 */
		public static var time:Number = 1;
		
	}

}