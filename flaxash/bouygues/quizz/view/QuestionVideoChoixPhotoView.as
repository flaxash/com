package com.flaxash.bouygues.quizz.view
{
	import flash.display.MovieClip;
	
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVideoChoixPhotoVO;
	
	
	public class QuestionVideoChoixPhotoView extends QuestionView
	{
		//sur la scène
		public var cibleVideo:MovieClip;
		
		public function QuestionVideoChoixPhotoView()
		{
			super();
		}
		override public function majView(value:QuestionVO):void 
		{
			//super.majView(value);
			var question:QuestionVideoChoixPhotoVO = value as QuestionVideoChoixPhotoVO;
			
		}
	}
}