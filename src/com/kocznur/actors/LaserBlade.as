package com.kocznur.actors 
{
	import com.kocznur.Assets;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * LaserBlade
	 * 
	 * @author pkocznur
	 */
	public class LaserBlade
	{
		private var sprite:Sprite;
		private var lasers:Vector.<Image>;
		private var laser:Image;
		private var steps:uint = 80;
		private var direction:Point;
		private var density:Number;
		private var _show:Boolean;
		
		// collisions
		private var rect1:Rectangle;
		private var rect2:Rectangle;
		private var collisionObjects:Vector.<Zombie>;
		private var collisionObject:Zombie;
		private var collisionDetection:Boolean = false;
		private var collisionCallback:Function;
		
		/**
		 * LaserBlade
		 * 
		 * @param	sprite - container for generated lasers
		 */
		public function LaserBlade(sprite:Sprite) 
		{
			this.sprite = sprite;
			init();
		}
		
		private function init():void 
		{
			direction = new Point();
			lasers = new Vector.<Image>();
			for (var i:int = 0; i < steps; i++) 
			{
				laser = Image.fromBitmap(Assets.laserBitmap); 
				lasers.push(laser);
				sprite.addChild(laser);
			}
		}
		
		/**
		 * update
		 * 
		 * @param	start
		 * @param	end
		 */
		public function update(start:Point, end:Point):void
		{
			if (!_show)
			{
				return;
			}
			
			direction.x = end.x - start.x;
			direction.y = end.y - start.y;
			density = direction.length / steps;
			direction.normalize(1);
			
			
			for (var i:int = 0; i < steps; i++) 
			{
				laser = lasers[i];
				laser.x = start.x + i*density*direction.x;
				laser.y = start.y + i * density * direction.y;
				
				if (collisionDetection)
				{
					collision(laser);
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
		
		private function collision(laser:Image):void
		{
			rect1 = laser.getBounds(sprite);
			for (var i:int = 0; i < collisionObjects.length; i++) 
			{
				collisionObject = collisionObjects[i];
				if (collisionObject.isOnStage)
				{
					rect2 = collisionObject.getBounds(sprite);
					if (rect2.intersects(rect1))
					{
						collisionCallback(collisionObjects[i]);
					}
				}
			}
			
		}
		
		private function visible(isVisible:Boolean):void
		{
			for (var i:int = 0; i < steps; i++) 
			{
				lasers[i].visible = isVisible;
			}
		}
		
		public function get show():Boolean 
		{
			return _show;
		}
		
		public function set show(value:Boolean):void 
		{
			visible(value);
			_show = value;
		}
		
		
	}

}