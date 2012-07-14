package com.kocznur
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	/**
	 * ...
	 * @author pkocznur
	 */
	[SWF(width="320",height="560",frameRate="60",backgroundColor="#222222")]
	
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var starling:Starling = new Starling(Game, stage);
			starling.showStats = true;
			starling.start();
		}
	
	}

}