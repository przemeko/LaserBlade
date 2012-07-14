package com.kocznur.Effects 
{
	import flash.geom.Point;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author pkocznur
	 */
	public class Explosion extends MovieClip
	{
		private var _isOnStage:Boolean = false;
		
		public function Explosion(textures:Vector.<Texture>, fps:Number) 
		{
			super(textures, fps);
			stop();
			visible = false;
			this.addEventListener(Event.COMPLETE, onComplete)
		}
		
		public function show(position:Point):void
		{
			setPosition(position);
			isOnStage = true;
		}
		
		private function onComplete(e:Event):void 
		{
			isOnStage = false;
		}
		
		public function setPosition(position:Point):void
		{
			x = position.x;
			y = position.y;
		}
		
		public function get isOnStage():Boolean 
		{
			return _isOnStage;
		}
		
		public function set isOnStage(value:Boolean):void 
		{
			visible = value;
			_isOnStage = value;
			
			if (value)
			{
				play();
			}
			else 
			{
				stop();
			}
		}
		
	}

}