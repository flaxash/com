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
		public var clipScore:MovieClip;
		public var cercle:MovieClip;
		private var _score:uint=0;
		private var gagne:Boolean=false;
		private var scoreChanged:Boolean=false;
		public function BandeauScoreView()
		{
			super();
		}
		
		public function majScore(_newScore:uint):void {
				if (_score<_newScore) {
					gagne=true;
					scoreChanged = true;
				} else {
					gagne=false
				}
				_score = _newScore;
				
				
				var maTimeline:TimelineLite = new TimelineLite();
				maTimeline.append(new TweenLite(cercle,0.5,{scaleX:0.01,scaleY:0.01,onComplete:tweenScore}));
				maTimeline.append(new TweenLite(cercle,0.5,{scaleX:1,scaleY:1}),2.5);
				//maTimeline.play();
				//transition à faire
						
			
		}
		
		private function tweenScore():void
		{
			
			var maTimeline:TimelineLite = new TimelineLite();
			maTimeline.append(new TweenLite(clipScore,0.5,{x:gagne?"110":"-110",onComplete:majTexteScore}));
			maTimeline.append(new TweenLite(clipScore,0.5,{x:gagne?"-110":"110"}),2);
		
			maTimeline.play();
			
		
			
		}
		private function majTexteScore():void {
			clipScore.scoreTF.text = _score.toString();
		}
	}
}