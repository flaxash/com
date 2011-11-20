package com.flaxash.bouygues.quizz.model.VO
{
	public class QuestionVO
	{
		public var numQuestion:uint;
		//une question, plusieurs réponses (2 ou 3) et un type (video, son, texte)
		public var type:String;
		public var dejaFait:Boolean;
		public var nbReponses:uint;
		
		public var reponses:Vector.<String>;
		public var question:String;
	}
}