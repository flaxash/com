package com.flaxash.bouygues.quizz.view.component
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	public class BoutonChoixQuestion extends MovieClip
	{
		//sur la scène
		public var visuels:MovieClip;
		
		public function BoutonChoixQuestion()
		{
			super();
			initBouton();
		}
		public function intro():void 
		{
			//TweenLite.from(this,2,{x:"-50"});
		}
		private function initBouton():void {
			this.buttonMode=true;
		}
	}
}