package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.model.VO.QuestionVO;
	import com.flaxash.bouygues.quizz.model.VO.QuestionVisuelVO;
	
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import flash.utils.*;
	import com.demonsters.debugger.MonsterDebugger;
	
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
			while (cible.numChildren>0) cible.removeChildAt(0);
			MonsterDebugger.trace(this,question.nomVisuel);
			insereVisuel(question.nomVisuel);
			
		}
		private function insereVisuel(nom:String):void {
			
			var Visuel:Class = getDefinitionByName(nom) as Class;
			//MonsterDebugger.trace(this,);
			var monBD:BitmapData = new Visuel();
			var monImage:Bitmap = new Bitmap(monBD);
			monImage.x = -monImage.width/2;
			monImage.y = -monImage.height/2;
			MonsterDebugger.trace(this,monImage.width + "x" + monImage.height);
			cible.addChild(monImage);
		}

	}
}