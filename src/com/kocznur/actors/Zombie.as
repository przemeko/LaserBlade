package com.kocznur.actors 
{
	import com.kocznur.Assets;
	import com.kocznur.World;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author pkocznur
	 */
	public class Zombie extends Sprite
	{
		private var texture:Texture;
		private var _position:Point;
		private var _speed:Number;
		private var _isOnStage:Boolean;
		private var _isOut:Boolean;
		private var _directionVector:Point;
		
		
		public function Zombie(texture:Texture) 
		{
			this.texture = texture;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(new Image(texture));
			
			_isOut = false;
			_speed = 4;
			_position = new Point();
			_directionVector = new Point();
			isOnStage = false;
			pivotX = width >> 1;
			pivotY = height >> 1;
		}
		
		public function update(dt:Number):void
		{
 			x += _directionVector.x * _speed * World.time;
			y += _directionVector.y * _speed * World.time;
			
			_isOut = false;
			if (x < 0 || x > World.WIDTH || y < 0 || y > World.HEIGHT)
			{
				_isOut = true;
			}
			
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		
		public function get isOnStage():Boolean 
		{
			return _isOnStage;
		}
		
		public function set isOnStage(value:Boolean):void 
		{
			_isOnStage = value;
			visible = value;
		}
		
		public function set directionVector(value:Point):void 
		{
			// direction of ship can be changed, so it 
			// cannot be pointer - must be clone
			_directionVector = value.clone();
		}
		
		public function get isOut():Boolean 
		{
			return _isOut;
		}
		
		public function get position():Point 
		{
 			_position.x = x;
			_position.y = y;
			return _position;
		}
		
		public function set position(value:Point):void 
		{
			_position = value;
			x = _position.x;
			y = _position.y;
		}
	
		
	}

}