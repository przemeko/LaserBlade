package com.kocznur 
{
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author pkocznur
	 */
	public class Assets 
	{
		[Embed(source = "../../../res/ship2.png")]
        private static var ship:Class;
		public static var shipTexture:Texture;
		
		[Embed(source = "../../../res/bullet.png")]
        private static var bullet:Class;
		public static var bulletTexture:Texture;
		
		[Embed(source = "../../../res/enemy.png")]
        private static var enemy:Class;
		public static var enemyTexture:Texture;
		
		[Embed(source="../../../res/laser.png")]
		private static var laser:Class;
		public static var laserBitmap:Bitmap;
		
		[Embed(source="../../../res/bg.png")]
		private static var background:Class;
		public static var bgTexture:Texture;
		
		[Embed(source="../../../res/explosion.xml", mimeType="application/octet-stream")]
		private static var explosionXml:Class;
		[Embed(source="../../../res/explosion.png")]
		private static var explosionTexture:Class;
		public static var explosionTextures:Vector.<Texture>;
		
		public static function init():void
		{
			shipTexture = Texture.fromBitmap(new ship());
			bulletTexture = Texture.fromBitmap(new bullet());
			enemyTexture = Texture.fromBitmap(new enemy());
			laserBitmap = new laser();
			bgTexture = Texture.fromBitmap(new background()); 
			
			// create explosion atlas
			var texture:Texture = Texture.fromBitmap(new explosionTexture());
			var xml:XML = XML(new explosionXml());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			explosionTextures = atlas.getTextures('explode-1-00-');
		}
		
		
	}

}