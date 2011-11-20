package com.flaxash.bouygues.quizz.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.Signal;
	
	public class TimerQuestion extends MovieClip
	{
		//sur la scène
		public var clipNB:MovieClip;
		public var clipCouleur:MovieClip;
		
		public var spriteMask:Sprite;
		
		public var signalTimer:Signal;

		private var timer:Timer;
		private var rayonClip:Number = 80;
		
		public function TimerQuestion()
		{
			super();
			
			clipNB.mask = spriteMask;
			//timer toutes les 200ms et qui durent en tout 60 s;
			timer = new Timer(200,300);
			signalTimer = new Signal();
			timer.addEventListener(TimerEvent.TIMER,onTick);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
		}
		public function start():void 
		{
			timer.start();
		}
		private function onTick(te:TimerEvent):void 
		{
			redraw();
		}
		private function onTimerComplete(te:TimerEvent):void 
		{
			signalTimer.dispatch("finQuestion");
		}
		private function redraw():void 
		{
			var ratio:Number = timer.currentCount/timer.repeatCount;
			var anglePie : Number = 2*Math.PI * ratio;
			drawPie(spriteMask,anglePie,rayon);
		}
		private function drawPie(monSprite:Sprite,angle:Number,rayon:Number):void 
		{
			monSprite.graphics.clear ();
			var segmentAngle  = (angle / 8) / 180 * Math.PI;
			var controlDist = rayon / Math.cos (segmentAngle / 2);
			monSprite.graphics.lineStyle (2, 0x000000 , 100);
			monSprite.graphics.moveTo(rayon,0);
			for (var e = 1; e <= 8; e ++)
			{
				var endX:Number = rayon * Math.cos (e * segmentAngle);
				var endY:Number = - rayon * Math.sin (e * segmentAngle);
				var controlX:Number = controlDist * Math.cos (e * segmentAngle - segmentAngle / 2);
				var controlY:Number = - controlDist * Math.sin (e * segmentAngle - segmentAngle / 2);
				monSprite.graphics.curveTo (controlX, controlY, endX, endY);
				
			}
		}
	}
}