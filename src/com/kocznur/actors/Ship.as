package com.kocznur.actors 
{
	import com.kocznur.Assets;
	import com.kocznur.utils.Filter;
	import com.kocznur.World;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	/**
	 * Ship
	 * 
	 * @author pkocznur
	 */
	public class Ship extends Sprite
	{
		// cache PI/2
		private const PI2:Number = 1.5707963267948966;
		
		// where is the ship
		private var _position:Point;
		// direction of ship
		private var _directionVector:Point;
		// where ship is currently shooting
		private var _fireDirection:Point;
		
		// velocity of ship
		private var v:Point;
		// acceleration
		private var a:Point;
		// cache the size
		private var halfSize:Point;

		// bullets are handle elsewhere, so wee need callback
		private var fireCallback:Function;
		
		/**
		 * Ship
		 */
		public function Ship() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(new Image(Assets.shipTexture));
			
			_position = new Point(x, y);
			_fireDirection = new Point(1, 0);
			pivotX = width >> 1;
			pivotY = height >> 1;
			
			v = new Point(0, 0);
			a = new Point(0.1, 0.1);
			halfSize = new Point(width >> 1, height >> 1);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
		}
		
		/**
		 * setFireCallback
		 * 
		 * @param	callback
		 */
		public function setFireCallback(callback:Function):void
		{
			fireCallback = callback;
		}
		
		/**
		 * onKeyPressed
		 * 
		 * @TODO check simultaneous ke pressed
		 * @param	e
		 */
		private function onKeyPressed(e:KeyboardEvent):void 
		{
			//trace(e.charCode);
			switch (e.charCode)
			{
				case 119: //w
					v.y = Filter.add(v.y, -a.y, -4);
					break;
				case 97: //a
					_fireDirection.setTo( -1, 0);
					break;
				case 100: //d
					_fireDirection.setTo( 1, 0);
					break;
				case 115: //s
					v.y = Filter.add(v.y, a.y, 4);
					break;
				case 32: //space
					fireCallback();
					break;
			}
		}
		
		/**
		 * update
		 * 
		 * @param	dt
		 */
		public function update(dt:Number):void
		{
			x += v.x * World.time;
			y += v.y * World.time;
			
			if (x + halfSize.x < 0)
			{
				x = stage.stageWidth + halfSize.x;
			}
			if (x - halfSize.x > stage.stageWidth)
			{
				x = -halfSize.x;
			}
			if (y + halfSize.y < 0)
			{
				y = stage.stageHeight + halfSize.y;
			}
			if (y - halfSize.y > stage.stageHeight)
			{
				y = -halfSize.y;
			}
		}
		
		/**
		 * directionVector
		 * 
		 * in future ship will be rotating 
		 * - an we will need direction
		 * 
		 */
		public function get directionVector():Point 
		{
			return new Point(Math.cos(rotation - PI2), Math.sin(rotation - PI2));
		}
		
		public function get position():Point
		{
			_position.x = x;
			_position.y = y;
			
			return _position;
		}
		
		/**
		 * fireDirection
		 * 
		 * Where bullet should go
		 */
		public function get fireDirection():Point 
		{
			return _fireDirection;
		}
		
	}

}