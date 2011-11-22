package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionSonVO;
	
	public class QuestionSonView extends QuestionView
	{
		public function QuestionSonView()
		{
			super();
		}
		override public function majView(value:QuestionVO):void 
		{
			super.majView(value);
			var question:QuestionSonVO = value as QuestionSonVO;
			
		}

	}
}