package com.flaxash.bouygues.quizz.view
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class BandeauScoreView extends MovieClip
	{
		//surla scène
		public var scoreTF:TextField;
		public var cercle:MovieClip;
		private var _score:uint=0;;
		public function BandeauScoreView()
		{
			super();
		}
		
		public function majScore(newScore:uint):void {
			if (newScore!=_score) {
				_score = newScore;
				var maTimeline:TimelineLite = new TimelineLite();
				maTimeline.append(new TweenLite(cercle,0.5,{scaleX:0.01,scaleY:0.01,onComplete:majTexteScore}));
				maTimeline.append(new TweenLite(cercle,0.5,{scaleX:1,scaleY:1}));
				maTimeline.play();
				//transition à faire
			}				
			
		}
		
		private function majTexteScore():void
		{
			scoreTF.text = _score.toString();
			
		}
	}
}