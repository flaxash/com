package com.flaxash.bouygues.quizz.view
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.osflash.signals.Signal;
	
	public class LoadingView extends MovieClip
	{
		public var timerMvt:Timer;
		public var signalMvt:Signal;
		private var x_init:Number;
		private var nbMvt:uint=0;
		public function LoadingView()
		{
			super();
			visible = false;
			initTimer();
		}
		public function goMouvement():void {
			timerMvt.start()
		}
		public function stopMouvement():void {
			timerMvt.stop();
		}
		private function initTimer():void {
			signalMvt = new Signal();
			timerMvt = new Timer(4000,0);	
			timerMvt.addEventListener(TimerEvent.TIMER,changeVisuel);
			x_init = this.x;
		}
		private function changeVisuel(te:TimerEvent):void 
		{
			nbMvt++;
			if (this.x>x_init-1) 
			{
				TweenLite.to(this,1,{x:x_init-520});
			}
			else {
				TweenLite.to(this,1,{x:x_init});
			}
			if (nbMvt==2) signalMvt.dispatch();
		}
	}
}