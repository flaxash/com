package com.flaxash.bouygues.quizz.view.component
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
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
		private var timerMvt:Timer;
		private var compteurMvt:uint=0;
		private var rayonClip:Number = 55;
		private var xinit:Number;

		private var maTimeline:TimelineMax;
		
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
			timerMvt = new Timer(5000,8);
			
			signalTimer = new Signal();
			timer.addEventListener(TimerEvent.TIMER,onTick);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			timerMvt.addEventListener(TimerEvent.TIMER,onTickMvt);
			timerMvt.addEventListener(TimerEvent.TIMER_COMPLETE,onEnd);
			//timer.start();
			maTimeline = new TimelineMax();
			maTimeline.append(new TweenLite(this,0.3,{scaleX:1.1,scaleY:1.1,x:"-5",ease:Quad.easeOut}));
			maTimeline.append(new TweenLite(this,0.7,{scaleX:1,scaleY:1,x:"5",ease:Bounce.easeOut}));
			maTimeline.repeat = 2;
		}
		public function start():void 
		{
			timer.reset();
			timer.start();
			timerMvt.reset();
			timerMvt.start();
			
			MonsterDebugger.trace(this,"timer démarré");
		}
		public function stopTimer():void {
			timer.stop();
			timer.reset();
			timerMvt.stop();
			timerMvt.reset();
		}
		private function onTick(te:TimerEvent):void 
		{
			redraw();
			
		}
		private function onTickMvt(te:TimerEvent):void {
			//timerMvt.removeEventListener(TimerEvent.TIMER,onStart);
			compteurMvt++;
			//MonsterDebugger.trace(this,"onTickMVt avec compteur = "+compteurMvt);
			if (compteurMvt==2 || compteurMvt==8) maTimeline.restart();
		}
		private function onEnd(te:TimerEvent):void {
			timerMvt.removeEventListener(TimerEvent.TIMER_COMPLETE,onEnd);
			maTimeline.play();
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