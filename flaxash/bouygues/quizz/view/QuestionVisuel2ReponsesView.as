package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVisuelVO;
	
	import flash.display.MovieClip;
	
	public class QuestionVisuel2ReponsesView extends QuestionView
	{
		//scène
		public var cible:MovieClip;
		
		public function QuestionVisuel2ReponsesView()
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