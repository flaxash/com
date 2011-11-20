package com.flaxash.bouygues.quizz.view
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	
	public class Navigation
	{
		public var signalTransition:Signal = new Signal();
		//states
		public var currentState:String;
		private var statesArray:Array = new Array("pageGo","choixQuestion","question","amis","loading");
		
		public function Navigation()
		{
			//constructeur
			
		}
		public function makeTransition(lastClip:MovieClip, newClip:MovieClip) 
		{
			//effectue une transition entre 2 movieClips
			var maTransition:TimelineLite = new TimelineLite({onComplete:transitionFinie});
			maTransition.append(new TweenLite(lastClip,1,{alpha:0}));
			maTransition.append(new TweenLite(newClip,1,{alpha:1}));
			maTransition.play();
		}
		public function rotationBandeau():void 
		{
			//change le visuel du bandeau
		}

		private function transitionFinie(e:Event):void 
		{
			signalTransition.dispatch("fin");	
		}
	}
}