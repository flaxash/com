package com.flaxash.bouygues.quizz.view
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class BandeauScoreView extends MovieClip
	{
		//surla scène
		public var scoreTF:TextField;
		
		public function BandeauScoreView()
		{
			super();
		}
		
		public function majScore(newScore:uint):void {
			//transition à faire
			scoreTF.text = newScore.toString();
		}
	}
}