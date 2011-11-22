package com.flaxash.bouygues.quizz.view
{
	import flash.display.MovieClip;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVisuelVO;
	
	public class QuestionVisuelView extends QuestionView
	{
		//scène
		public var cible:MovieClip;
		
		public function QuestionVisuelView()
		{
			super();
		}
		override public function majView(value:QuestionVO):void 
		{
			super.majView(value);
			var question:QuestionVisuelVO = value as QuestionVisuelVO;
			
		}

	}
}