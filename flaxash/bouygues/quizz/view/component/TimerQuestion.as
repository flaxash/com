package com.flaxash.bouygues.quizz.view.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class TimerQuestion extends MovieClip
	{
		//sur la scène
		public var clipNB:MovieClip;
		public var clipCouleur:MovieClip;
		
		public var spriteMask:Sprite;
		
		public var signalTimer:Signal;

		private var timer:Timer;
		private var rayonClip:Number = 55;
		
		public function TimerQuestion()
		{
			super();
			spriteMask = new Sprite();
			//spriteMask.scaleX = spriteMask.scaleY = -1;
			spriteMask.rotation = -90;
			addChild(spriteMask);
			clipNB.mask=spriteMask;
			
			//timer toutes les 200ms et qui durent en tout 45 s;
			timer = new Timer(200,225);
			signalTimer = new Signal();
			timer.addEventListener(TimerEvent.TIMER,onTick);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			//timer.start();
		}
		public function start():void 
		{
			timer.reset();
			timer.start();
			MonsterDebugger.trace(this,"timer démarré");
		}
		private function onTick(te:TimerEvent):void 
		{
			redraw();
		}
		private function onTimerComplete(te:TimerEvent):void 
		{
			signalTimer.dispatch();
		}
		private function redraw():void 
		{
			var ratio:Number = timer.currentCount/timer.repeatCount;
			var anglePie : Number = -360 * ratio;
			drawPie(spriteMask,anglePie,rayonClip);
		}
		private function drawPie(monSprite:Sprite,angle:Number,rayon:Number):void 
		{
			monSprite.graphics.clear ();
			var segmentAngle:Number  = (angle / 8) / 180 * Math.PI;
			var controlDist:Number = rayon / Math.cos (segmentAngle / 2);
			//monSprite.graphics.lineStyle (2, 0x000000 , 100);
			monSprite.graphics.beginFill(0x000000,1);
			monSprite.graphics.moveTo(0,0);
			monSprite.graphics.lineTo(rayon,0);
			for (var e:uint = 1; e <= 8; e ++)
			{
				var endX:Number = rayon * Math.cos (e * segmentAngle);
				var endY:Number = - rayon * Math.sin (e * segmentAngle);
				var controlX:Number = controlDist * Math.cos (e * segmentAngle - segmentAngle / 2);
				var controlY:Number = - controlDist * Math.sin (e * segmentAngle - segmentAngle / 2);
				monSprite.graphics.curveTo (controlX, controlY, endX, endY);
				
			}
			monSprite.graphics.lineTo(0,0);
		}
	}
}