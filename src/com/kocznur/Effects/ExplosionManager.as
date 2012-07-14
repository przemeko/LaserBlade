package com.kocznur.Effects 
{
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ExplosionManager
	 * 
	 * Object pool for Explosions
	 * 
	 * @author pkocznur
	 */
	public class ExplosionManager 
	{
		private var mvs:Vector.<Explosion>;
		private var mv:Explosion;
		private var mvsNum:uint;
		
		private var sprite:Sprite;
		
		/**
		 * ExplosionManager
		 * 
		 * @param	sprite
		 * @param	textures
		 * @param	maxNum
		 * @param	fps
		 */
		public function ExplosionManager(sprite:Sprite, textures:Vector.<Texture>, maxNum:uint, fps:Number = 12) 
		{
			this.sprite = sprite;
			mvs = new Vector.<Explosion>();
			
			for (var i:int = 0; i < maxNum; i++) 
			{
				mv = new Explosion(textures, fps);
				mv.pivotX = mv.width >> 1;
				mv.pivotY = mv.height >> 1;
				mv.loop = false;
				mvs.push(mv);
				sprite.addChild(mv);
				
				Starling.juggler.add(mv);
			}
		}
		
		/**
		 * run
		 * 
		 * @param	position
		 */
		public function run(position:Point):void
		{
			mvsNum = mvs.length;
			for (var i:int = 0; i < mvsNum; i++) 
			{
				mv = mvs[i];
				if (!mv.isOnStage)
				{
					mv.show(position);
					break;
				}
			}
		}
		
	}

}