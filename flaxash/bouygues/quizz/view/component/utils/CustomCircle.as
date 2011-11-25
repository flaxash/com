package com.flaxash.bouygues.quizz.view.component.utils
	/**
	 * Copyright (c) 2009 Flash-square
	 * http://www.flash-square.com
	 * All rights reserved. 
	 */
	
	{
		// + ----------------------------------------
		// 			[ IMPORTS ]
		// + ----------------------------------------
		
		import flash.display.Graphics;
		import flash.display.Shape;
		import flash.display.Sprite;
		import flash.geom.Point;
		
		import flash.events.Event;
		
		/**
		 * _radius:Number,   --> rayon du cercle
		 * angleMin:Number, --> angle minimum de 0 a 360
		 * angleMax:Number, --> angle maximum de 0 a 360
		 * initValue:Number --> valeur initiale en pourcentage de 0 a 1
		 * 
		 * STYLE SETTINGS : 
		 * _colorBorderCircle 	--> _circle border color, uint
		 * _isFillCircle			--> is th cicrle _center fill in, boolean
		 * _colorCentreCircle		--> color of _center filling, uint
		 * _thicknessBorderCircle --> thickness of the border, in px			
		 * _colorCursor			--> color of the cursor, uint
		 * _radiusCursor			--> _radius of the cursor
		 * _colorBorderCursor		--> cursor border color
		 * _thicknessBorderCursor	--> cursor thickness border
		 */
		
		public class CustomCircle extends Sprite
		{
			
			//settings 			
			private var _angleMin				: int 	= 0;
			private var _angleMax				: int 	= 360;
			private var _radius					: int 	= 75;
			private var _colorBorderCircle		: uint	= 0xffffff;
			private var _colorCenterCircle		: uint	= 0xcccccc;
			private var _thicknessBorderCircle	: Number= 0.1;			
			private var _currentAngle			: int 	= 0;
			private var _intervalTransition		: int 	= 0;
			
			//elements 
			private var _oDatas					: Object;
			private var _center 				: Sprite; 
			private var _circle 				: Shape;		
			
			public function CustomCircle(radius:int,angleMin:Number,angleMax:Number,color:uint):void
			{
				
				_radius				= radius;
				_angleMin			= angleMin;	
				_angleMax			= angleMax;
				_currentAngle 		= angleMin;
				_colorCenterCircle  = color;
				
				this.addEventListener(Event.ADDED_TO_STAGE,init,false,0,true)
			}
			
			private function builtItem():void
			{
				//_circle
				_circle = new Shape();
				this.addChild(_circle);
				
				//_center
				_center = new Sprite();
				this.addChild(_center);
				
				
				var minInRadian		:Number = Math.PI * 2 * (_angleMin / 360);
				var currentRadian	:Number = Math.PI * 2 * (_currentAngle / 360);			
				var maxEndRadian	:Number = Math.PI * 2 * (_angleMax / 360);			
				
				_circle.graphics.clear();
				_circle.graphics.lineStyle(_thicknessBorderCircle,_colorBorderCircle);
				_circle.graphics.beginFill(_colorCenterCircle);
				_circle.graphics.lineTo(0, 0);			
				drawArc(0, 0,minInRadian, maxEndRadian,1,_circle.graphics); 
				_circle.graphics.lineTo(0, 0);			
				_circle.graphics.endFill();
				
				//buildInfoPieChart();
			}
			//drawing the _circle        
			private function drawArc(centerX:Number, centerY:Number, startAngle:Number, endAngle:Number, direction:int, target:Graphics):void
			{ 
				var difference:Number 		= Math.abs(endAngle - startAngle);        
				var divisions:Number 		= Math.floor(difference / (Math.PI / 4))+1;         
				var span:Number    			= direction * difference / (2 * divisions);     
				var controlRadius:Number    = _radius / Math.cos(span);         
				var controlPoint:Point;     
				var anchorPoint:Point;			
				target.moveTo(centerX + (Math.cos(startAngle)*_radius), centerY + Math.sin(startAngle)*_radius);
				for(var i:Number=0; i<divisions; ++i){         
					endAngle    = startAngle + span;         
					startAngle  = endAngle + span;                
					controlPoint = new Point(centerX+Math.cos(endAngle)  * controlRadius, centerY+Math.sin(endAngle)*controlRadius);         
					anchorPoint  = new Point(centerX+Math.cos(startAngle)* _radius, centerY+Math.sin(startAngle)*_radius);
					target.curveTo(controlPoint.x, controlPoint.y, anchorPoint.x, anchorPoint.y);   
				}
			}
			private function buildInfoPieChart():void
			{
				var angleMoyen			:	int = (_angleMin+(_angleMax-_angleMin)/2);
				var angleMoyenRadian	: 	Number = Math.PI * 2 * (angleMoyen / 360);			
				
			}
			public function get angleMoyen():Number
			{
				var angleMoyen			:	int = (_angleMin+(_angleMax-_angleMin)/2);
				var angleMoyenRadian	: 	Number = Math.PI * 2 * (angleMoyen / 360);	
				return angleMoyenRadian;
			}
			
			/*---------------------------------------------------------*/	
			/*+       	    	      [ HANDLERS ]  		          +*/
			/*---------------------------------------------------------*/
			private function init(e:Event):void
			{
				this.removeEventListener(Event.ADDED_TO_STAGE,init);
				builtItem();
			}
		}
	}