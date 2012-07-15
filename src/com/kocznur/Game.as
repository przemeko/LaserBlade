package com.kocznur 
{
	import com.kocznur.actors.LaserBlade;
	import com.kocznur.actors.Ship;
	import com.kocznur.actors.Zombie;
	import com.kocznur.actors.ZombieManager;
	import com.kocznur.Effects.ExplosionManager;
	import com.kocznur.utils.SoundManager;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author pkocznur
	 */
	public class Game extends Sprite
	{
		private var ship:Ship;
		private var laserBlade:LaserBlade;
		
		private var bulletsManager:ZombieManager;
		private var enemiesManager:ZombieManager;
		private var explosionsManager:ExplosionManager;
		
		private var dt:Number;
		private var currentTime:int;
		private var getTimerTmp:int;
		
		private var touch:Touch;
		private var touchPos:Point;
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Assets.init();
			addChild(new Image(Assets.bgTexture));
			
			ship = new Ship();
			ship.setFireCallback(onFire);
			addChild(ship);
			ship.x = World.WIDTH >> 1;
			ship.y = World.HEIGHT >> 1;
			
			bulletsManager = new ZombieManager(this, Assets.bulletTexture, World.MAX_BULLETS_ON_STAGE);
			enemiesManager = new ZombieManager(this, Assets.enemyTexture, World.MAX_ENEMIES_ON_STAGE);
			explosionsManager = new ExplosionManager(this, Assets.explosionTextures, World.MAX_ENEMIES_ON_STAGE);
			laserBlade = new LaserBlade(this);
			
			enemiesManager.checkCollision(bulletsManager.getObjects(), enemyHit);
			laserBlade.checkCollision(enemiesManager.getObjects(), enemyHitByLaserBlade);
			currentTime = getTimer();

			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function onTouch(event:TouchEvent):void 
		{
			touch = event.getTouch(stage, TouchPhase.BEGAN);
			if (touch)
			{
				touchPos = touch.getLocation(stage);
				World.time = 0.1; // we are diving in the bullet time baby :)
				laserBlade.show = true;
			}
			
			touch = event.getTouch(stage, TouchPhase.ENDED);
			if (touch)
			{
				touchPos = touch.getLocation(stage);
				World.time = 1;
				laserBlade.show = false;
			}
		}
		
		private function onFire():void 
		{
			bulletsManager.run(new Point(ship.x, ship.y), ship.fireDirection);
		}
		
		private function onUpdate(e:Event):void 
		{
			getTimerTmp = getTimer();
			dt = getTimerTmp - currentTime;
			currentTime = getTimerTmp;
			
			ship.update(dt);
			bulletsManager.update(	dt);
			enemiesManager.update(dt);
			laserBlade.update(ship.position, touchPos);
			
			if (Math.random() * 300 < 10)
			{
				enemiesManager.run(new Point(Math.random() * World.WIDTH, World.HEIGHT), new Point(0, -0.2), 2+ Math.random()*6);
			}
		}
		
		private function enemyHit(enemy:Zombie, bullet:Zombie):void
		{
			bullet.isOnStage = false;
			enemy.isOnStage = false;
			explosionsManager.run(enemy.position);
		}
		
		private function enemyHitByLaserBlade(enemy:Zombie):void
		{
			enemy.isOnStage = false;
			explosionsManager.run(enemy.position);
		}
		
		
	}

}