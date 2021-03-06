package com.flaxash.bouygues.quizz.view.component
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class BandeauBas extends MovieClip
	{
		private var monTimer:Timer;
		private var x_init:Number;
		public function BandeauBas()
		{
			super();
			initTimer();
		}
		private function initTimer():void {
			monTimer = new Timer(10000,0);	
			monTimer.addEventListener(TimerEvent.TIMER,changeVisuel);
			monTimer.start();
			x_init = this.x;
		}
		private function changeVisuel(te:TimerEvent):void 
		{
			if (this.x>x_init-1) 
			{
				TweenLite.to(this,1,{x:x_init-535,overwrite:0,onComplete:majPosGauche});
			}
			else {
				TweenLite.to(this,1,{x:x_init,overwrite:0,onComplete:majPosDroite});
			}
		}
		private function majPosGauche():void {
				this.x=x_init-535;
			}
		private function majPosDroite():void {		
				this.x=x_init;
		}
	}
	
}