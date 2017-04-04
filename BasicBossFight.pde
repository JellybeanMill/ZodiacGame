abstract class BasicBossFight
{
	BasicBossFight()
	{}
	abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
	{
		protected int corners;  //the number of corners, a triangular floater has 3   
		protected int[] xCorners;   
		protected int[] yCorners;   
		protected int myColor;   
		protected double myCenterX, myCenterY; //holds center coordinates   
		protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
		protected double myPointDirection; //holds current direction the ship is pointing in degrees    
		abstract public void setX(int x);  
		abstract public int getX();   
		abstract public void setY(int y);   
		abstract public int getY();   
		abstract public void setDirectionX(double x);   
		abstract public double getDirectionX();   
		abstract public void setDirectionY(double y);   
		abstract public double getDirectionY();   
		abstract public void setPointDirection(int degrees);   
		abstract public double getPointDirection(); 
		//Accelerates the floater in the direction it is pointing (myPointDirection)   
		public void accelerate (double dAmount)   
		{          
			//convert the current direction the floater is pointing to radians    
			double dRadians =myPointDirection*(Math.PI/180);     
				//change coordinates of direction of travel    
			myDirectionX += ((dAmount) * Math.cos(dRadians));    
			myDirectionY += ((dAmount) * Math.sin(dRadians));       
		}   
		public void rotate (int nDegreesOfRotation)   
		{     
			//rotates the floater by a given number of degrees    
			myPointDirection+=nDegreesOfRotation;   
		}   
		public void move ()   //move the floater in the current direction of travel
		{      
		//change the x and y coordinates by myDirectionX and myDirectionY       
			myCenterX += myDirectionX;    
			myCenterY += myDirectionY;     

			//wrap around screen    
			if(myCenterX >width)
			{     
				myCenterX = 0;    
			}    
			else if (myCenterX<0)
		{     
				myCenterX = width;    
			}    
			if(myCenterY >height)
			{    
			myCenterY = 0;    
			}   
			else if (myCenterY < 0)	
			{    	 
				myCenterY = height;    	
			}	   
		}   
		public void show ()  //Draws the floater at the current position  
		{             
			fill(myColor);   
			stroke(myColor);    
			//convert degrees to radians for sin and cos         
			double dRadians = myPointDirection*(Math.PI/180);                 
			int xRotatedTranslated, yRotatedTranslated;
			beginShape();         
			for(int nI = 0; nI < corners; nI++)    
			{     
				//rotate and translate the coordinates of the floater using current direction 
				xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
				yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
				vertex(xRotatedTranslated,yRotatedTranslated);    
			}   
				endShape(CLOSE);  	
		}   
	}
	class SpaceShip extends Floater  
	{
		private int warpPoint,dashCounter,dashAccelerator;
		private boolean shipSpecial,dashPress,nowDashing,statEffNoControl;
	    public SpaceShip()
	    {
	        corners = 26;
	        xCorners = new int[corners];
	        yCorners = new int[corners];
	        int [] xCornersTemp = {16,8,4,2,2 ,6 ,6 ,-6,-6,-2,-2,-4,-8,-8,-4,-2, -2, -6, -6,  6,  6,  2, 2, 4, 8,16};
	        int [] yCornersTemp = {2 ,4,8,8,10,10,14,14,10,10, 8, 8, 4,-4,-8,-8,-10,-10,-14,-14,-10,-10,-8,-8,-4,-2};
	        xCorners = xCornersTemp;
	        yCorners = yCornersTemp;
	        myColor = color(255);
	        myCenterX = 500;
	        myCenterY = 300;
	        myDirectionX = 0;
	        myDirectionY = 0;
	        myPointDirection = 0;
	        warpPoint = 0;
	        shipSpecial=false;
	        dashPress=false;
	        nowDashing=false;
	        dashCounter=0;
	        dashAccelerator=1;
	        statEffNoControl=false;
	    }
	    public void setX(int x) {myCenterX = x;}
	    public int getX(){return (int)myCenterX;}
	    public void setY(int y) {myCenterY = y;}
	    public int getY(){return (int)myCenterY;}
	    public void setDirectionX (double x){myDirectionX = x;}
	    public double getDirectionX() {return myDirectionX;}
	    public void setDirectionY (double y){myDirectionY = y;}
	    public double getDirectionY(){return myDirectionY;}
	    public void setPointDirection(int degrees){myPointDirection = degrees;}
	    public double getPointDirection(){return myPointDirection;}
	    public int getWarpPoint() {return warpPoint;}
	    public void setWarpPoint(int inputPoint){warpPoint=inputPoint;}
	    public void setNoControl(boolean statEff){statEffNoControl=statEff;}
	    public void accelerate()
	    {
	    	if(statEffNoControl==false)
	    	{
	      		if (keyW==true) {myDirectionY=-speedCont;}
	      		if (keyA==true) {myDirectionX=-speedCont;}
	      		if (keyS==true) {myDirectionY= speedCont;}
	      		if (keyD==true) {myDirectionX= speedCont;}
	      		if (keyW==false&&keyS==false&&myDirectionY!=0)
	      		{
	      			if (myDirectionY>0) {myDirectionY-=speedCont*0.05;}
	      			if (myDirectionY<0) {myDirectionY+=speedCont*0.05;}
	      			if (abs((float)myDirectionY)<speedCont*0.05) {myDirectionY=0;}
	      		}
	      		if (keyA==false&&keyD==false&&myDirectionX!=0)
	      		{
	      			if (myDirectionX>0) {myDirectionX-=speedCont*0.05;}
	      			if (myDirectionX<0) {myDirectionX+=speedCont*0.05;}
					if (abs((float)myDirectionX)<speedCont*0.05) {myDirectionX=0;}
	    	  	}
	    	}
	    }
	    public void rotate(){myPointDirection=(Math.atan2(mouseY-myCenterY,mouseX-myCenterX))/PI*180;}
	    public void move ()
	    {
	    	myCenterX += myDirectionX*dashAccelerator;
	        myCenterY += myDirectionY*dashAccelerator;
	        if(myCenterX>width-20) {myCenterX = width-20;}    
	        else if(myCenterX<20){myCenterX = 20;}    
	        if(myCenterY>height-20){myCenterY = height-20;}   
	        else if (myCenterY<20){myCenterY = 20;}
	        if (keyShift == true&&warpPoint>=30&&dashPress==false)
			{
				nowDashing=true;
	        	warpPoint-=30;
	        	dashPress=true;
	        }
	        else if(keyShift==false){dashPress=false;}
	    	if(shipFiring==false){warpPoint++;}
	    	if (warpPoint>=180){warpPoint=180;}
	    	if(warpPoint<=0){warpPoint=0;}
	    	//POWERSURGE ACTIVATOR
	    	/*if(shipSpecial==true)
	    	{
	    		if(cancerBossScreen==true)
	    		{
	    			powerSurge();
	    		}
	    	}*/
	    	if(nowDashing==true)
	    	{
	    		dash();
	    	}
	    }
		//ACTUAL POWERSURGE FUNCTION
	    /*public void powerSurge()
	    {
			for(int lp1=0;lp1<asteroidList.size();lp1++)
			{
				if(dist(asteroidList.get(lp1).getX(),asteroidList.get(lp1).getY(),(float)myCenterX,(float)myCenterY)<=(60-counter)*5)
				{
					asteroidList.get(lp1).setDead(true);
				}
			}
	    	counter++;
			noStroke();
			fill(0,200,0);
			ellipse((float)myCenterX,(float)myCenterY, (60-counter)*5, (60-counter)*5);
			if(counter==61)
			{
				counter=0;
				shipSpecial=false;
			}
	    }*/
	    public void dash()
	    {
	    	dashAccelerator=2;
	    	dashCounter++;
	    	if(dashCounter>=60)
	    	{
				dashAccelerator=1;
				nowDashing=false;
				dashCounter=0;
			}
	    }
	}
	class Bullet extends Floater
	{
		protected int fuelPoint;
		protected boolean isDead;
		public Bullet()
		{
			corners = 8;
			xCorners = new int[corners];
			yCorners = new int[corners];
			int [] xCornersTemp = {0,1,3, 1, 0,-1,-3,-1};
			int [] yCornersTemp = {3,1,0,-1,-3,-1, 0, 1};
			xCorners = xCornersTemp;
			yCorners = yCornersTemp;
			myColor = color(0,255,0);
			myCenterX = shipMagellan.getX();
			myCenterY = shipMagellan.getY();
			myDirectionX = 0;
			myDirectionY = 0;
			myPointDirection = 0;
			fuelPoint = 225;
			isDead = false;
		}
		public void setX(int x) {myCenterX = x;}
		public int getX(){return (int)myCenterX;}
		public void setY(int y) {myCenterY = y;}
		public int getY(){return (int)myCenterY;}
		public void setDirectionX (double x){myDirectionX = x;}
		public double getDirectionX() {return myDirectionX;}
		public void setDirectionY (double y){myDirectionY = y;}
		public double getDirectionY(){return myDirectionY;}
		public void setPointDirection(int degrees){myPointDirection = degrees;}
		public double getPointDirection(){return myPointDirection;}
		public void setDead(boolean inputStatus){isDead=inputStatus;}
		public boolean getDead() {return isDead;}
		public int getFuel() {return fuelPoint;}
		public void setFuel(int inputFuel) {fuelPoint = inputFuel;}
		public void rotate()
		{
			myPointDirection += 1;
			if (myPointDirection>=360) {myPointDirection=0;}
		}
		public void accelerate()
		{
			double dRadians =shipMagellan.getPointDirection()*(Math.PI/180);
			myDirectionX = (speedCont*5 * Math.cos(dRadians));
			myDirectionY = (speedCont*5 * Math.sin(dRadians));
		}
		public void move()
		{
			myCenterX+=myDirectionX;
			myCenterY+=myDirectionY;
			if (myCenterX<-20) {isDead=true;}
			if (myCenterX>width+20) {isDead=true;}
			if (myCenterY<-20) {isDead=true;}
			if (myCenterY>height+20) {isDead=true;}
			fuelPoint-=1;
			if (fuelPoint >=0) {myColor = color(0,fuelPoint,0);}
			else {isDead =true;}
		}
	}
	class Button
	{
		private int myX, myY, myWidth, myLength, myTextSize, myStrokeColorNormal, myStrokeColorHover, myFillColorNormal, myFillColorHover;
		private float myHoverConstant;
		private String myText;
		private int [] hoverRange;
		private boolean clickable;
		public Button(String inputText, int inputTextSize, int inputX, int inputY, int inputWidth, int inputLength)
		{
			myText=inputText;
			myTextSize=inputTextSize;
			myX=inputX;
			myY=inputY;
			myWidth=inputWidth;
			myLength=inputLength;
			myStrokeColorNormal = color(255,255,255);
			myFillColorNormal = color(0,0,0);
			myStrokeColorHover=myStrokeColorNormal;
			myFillColorHover=myFillColorNormal;
			myHoverConstant=1.1;
			clickable=true;
		}
		public void show()
		{
			if(clickable==false){myFillColorNormal=color(220,220,220);}
			if(isHovering()==true&&clickable==true)
			{
				stroke(myStrokeColorHover);
				fill(myFillColorHover);
				rect(myX-(0.5*myWidth*myHoverConstant),myY-(0.5*myLength*myHoverConstant),myWidth*myHoverConstant,myLength*myHoverConstant);
				fill(myStrokeColorHover);
				textSize((int)(myTextSize*myHoverConstant));
				textAlign(CENTER,CENTER);
				text(myText,myX,myY);
			}
			else
			{
				stroke(myStrokeColorNormal);
				fill(myFillColorNormal);
				rect(myX-(0.5*myWidth),myY-(0.5*myLength),myWidth,myLength);
				fill(myStrokeColorNormal);
				textSize(myTextSize);
				textAlign(CENTER,CENTER);
				text(myText,myX,myY);		
			}
		}
		public boolean isHovering()
		{
			if(mouseX>myX-(myWidth*0.5)&&mouseX<myX+(myWidth*0.5)&&mouseY>myY-(myLength*0.5)&&mouseY<myY+(myLength*0.5))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}	