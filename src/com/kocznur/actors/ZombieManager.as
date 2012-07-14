package com.kocznur.actors 
{
	import starling.display.DisplayObject
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ZombieManager
	 * 
	 * Object pool for zombies actor
	 * 
	 * @author pkocznur
	 */
	public class ZombieManager 
	{
		private var zombies:Vector.<Zombie>;
		private var zombie:Zombie;
		private var sprite:Sprite;
		private var zombiesNum:uint;
		
		// collisions
		private var rect1:Rectangle;
		private var rect2:Rectangle;
		private var collisionObjects:Vector.<Zombie>;
		private var collisionObject:Zombie;
		private var collisionDetection:Boolean = false;
		private var collisionCallback:Function;
		
		/**
		 * ZombieManager
		 * 
		 * @param	sprite
		 * @param	texture
		 * @param	zombiesNum
		 */
		public function ZombieManager(sprite:Sprite, texture:Texture, zombiesNum:uint) 
		{
			this.sprite = sprite;

			zombies = new Vector.<Zombie>(texture);
			
			for (var i:int = 0; i < zombiesNum; i++) 
			{
				zombie = new Zombie(texture);
				zombies.push(zombie);
				
				sprite.addChild(zombie);
			}
		}
		
		/**
		 * run
		 * 
		 * @param	startPoint
		 * @param	directionVector
		 * @param	speed
		 */
		public function run(startPoint:Point, directionVector:Point, speed:Number = 4):void
		{
			zombiesNum = zombies.length;
			for (var i:int = 0; i < zombiesNum; i++) 
			{
				zombie = zombies[i];
				if (!zombie.isOnStage)
				{
					zombie.x = startPoint.x;
					zombie.y = startPoint.y;
					zombie.directionVector = directionVector;
					zombie.speed = speed;
					zombie.isOnStage = true;
					
					break;
				}
				
			}
		}
		
		/**
		 * update
		 * 
		 * @param	dt
		 */
		public function update(dt:Number):void
		{
			zombiesNum = zombies.length;
			for (var i:int = 0; i < zombiesNum; i++) 
			{
				zombie = zombies[i];
				if (zombie.isOnStage)
				{
					zombie.update(dt);
					
					if (zombie.isOut)
					{
						zombie.isOnStage = false;
					}
					else 
					{
						if (collisionDetection)
						{
							collision(zombie);
						}
					}
				}
			}
		}
		
		/**
		 * checkCollision
		 * 
		 * @param	objects
		 * @param	callback
		 */
		public function checkCollision(objects:Vector.<Zombie>, callback:Function):void
		{
			collisionObjects = objects;
			collisionCallback = callback;
			collisionDetection = true;
			rect1 = new Rectangle();
			rect2 = new Rectangle();
			
		}
		
		private function collision(zombie:Zombie):void
		{
			rect1 = zombie.getBounds(sprite);
			for (var i:int = 0; i < collisionObjects.length; i++) 
			{
				collisionObject = collisionObjects[i];
				if (collisionObject.isOnStage)
				{
					rect2 = collisionObject.getBounds(sprite);
					if (rect2.intersects(rect1))
					{
						collisionCallback(zombie, collisionObject);
					}
				}
			}
			
		}
		
		/**
		 * 
		 * @return Vector.<Zombie>
		 */
		public function getObjects():Vector.<Zombie>
		{
			return zombies;
		}
		
		
	}

}