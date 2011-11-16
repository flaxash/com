package com.flaxash.bouygues.quizz.model.VO
{
	public class QuestionVO
	{
		//une question, plusieurs réponses (2 ou 3) et un type (video, son, texte)
		public var type:String;
		public var nbReponses:uint;
		//la reponse correcte est identifiee par un index (entre 0 et nbReponses-1)
		public var reponseCorrecte:uint;
		public var reponses:Vector.<String>;
		public var question:String;
	}
}