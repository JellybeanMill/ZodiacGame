class CancerBossPlayScreen extends BasicBossFight
{
	private boolean levelWon
	private ArrayList <Asteroid> asteroidList = new ArrayList <Asteroid>();
	public CancerBossPlayScreen()
	{
		levelWon = false;
		for(int lp1=asteroidList.size()-1;lp1>=0;lp1--){asteroidList.remove(lp1);}
		for(int i =0;i<2;i++)
		{
			asteroidList.add(new Asteroid(4,(int)(Math.random()*1360)-180,-80));
		}
		mainCancerHead = new CancerHead();
		bossBattleTrue = true;
	}
	public void screenMove()
	{
		if (frameCounter%100==0&&levelWon==false){generateAsteroids();}
		for (int i=0;i<asteroidList.size();i++)
		{
			asteroidList.get(i).move();
			asteroidList.get(i).rotate();
		}
		shipMove();
		if(shipHealth>0&&winScreen==false){hitSomethingCancer();}
		if(winScreen==false){mainCancerHead.show();}
		destroyAsteroids();
		if(mainCancerHead.getHealth()<=0)
		{
			frameCounter=0;
			winScreen=true;
			mainCancerHead.setHealth(0);
		}
	}
	public void screenShow()
	{
		background(0);
		for(int i=0;i<asteroidList.size();i++)
		{
			if (asteroidList.get(i).getDead()==false)
			{
				asteroidList.get(i).show();
			}
		}
	}
	class CancerHead
	{
		private int maxHealth,myHealth,cdLine,cdSpray,abCounter,targetX,targetY;
		private boolean abLine,abSpray;
		public CancerHead()
		{
			maxHealth=720;
			myHealth=maxHealth;
			cdLine=0;
			cdSpray=0;
			abCounter=0;
		}
		public void setHealth(int inputHealth){myHealth=inputHealth;}
		public int getHealth(){return myHealth;}
		public int getTargetX(){return targetX;}
		public int getTargetY(){return targetY;}
		public void show()
		{
			stroke(255,0,255);
			fill(255,0,255);
			ellipse(500,-866,2000,2000);
			stroke(255);
			fill(255);
			rect(319,54,362,12);
			stroke(255,0,255);
			fill(255,0,255);
			rect(320,55,(int)(myHealth/(maxHealth/360.0)),10);
			if(abLine==false){cdLine++;}
			if(abSpray==false){cdSpray++;}
			if((cdLine*Math.random())>60+(myHealth*2)&&abSpray==false&&abLine==false)
			{
				abLine=true;
				targetX=shipMagellan.getX();
				targetY=shipMagellan.getY();
				cdLine=0;
			}
			if(abLine==true){fireLine();}
			if((cdSpray*Math.random())>100+(myHealth*2*1.6)&&abLine==false&&abSpray==false)
			{
				abSpray=true;
				cdSpray=0;
			}
			if(abSpray==true){fireSpray();}
		}
		public void fireLine()
		{
			abCounter++;
			if((abCounter>=0)&&(abCounter%12==0)){asteroidList.add(new Asteroid(2,500,110,targetX,targetY));}
			if(abCounter>=65)
			{
				abLine=false;
				abCounter=0;
			}
		}
		public void fireSpray()
		{
			abCounter++;
			if((abCounter>=0)&&(abCounter%20==0))
			{
				asteroidList.add(new Asteroid(2,500,110,0,110));
				asteroidList.add(new Asteroid(2,500,110,67,360));
				asteroidList.add(new Asteroid(2,500,110,250,543));
				asteroidList.add(new Asteroid(2,500,110,500,610));
				asteroidList.add(new Asteroid(2,500,110,750,543));
				asteroidList.add(new Asteroid(2,500,110,933,360));
				asteroidList.add(new Asteroid(2,500,110,1000,110));
			}
			if(abCounter>=65)
			{
				abSpray=false;
				abCounter=0;
			}
		}
	}
	class Asteroid extends Bullet
	{
		private int astdSize, targetX, targetY;
		private boolean astdSpecial;
		public Asteroid(int inputSize, double inputX, double inputY)
		{
		corners = 8;
		astdSize = inputSize;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = astdSize*15;
		yCorners[0] = 0;
		xCorners[1] = astdSize*10;
		yCorners[1] = astdSize*10;
		xCorners[2] = 0;
		yCorners[2] = astdSize*15;
		xCorners[3] = astdSize*-10;
		yCorners[3] = astdSize*10;
		xCorners[4] = astdSize*-15;
		yCorners[4] = 0;
		xCorners[5] = astdSize*-10;
		yCorners[5] = astdSize*-10;
		xCorners[6] = 0;
		yCorners[6] = astdSize*-15;
		xCorners[7] = astdSize*10;
		yCorners[7] = astdSize*-10;
		myCenterX = inputX;
		myCenterY = inputY;
		myColor = color(255,0,0);
		myPointDirection=0;
		fuelPoint = 225;
		isDead=false;
		astdSpecial=false;
		accelerate();
		}
		public Asteroid(int inputSize, double inputX, double inputY,int inputTargetX, int inputTargetY)
		{
			corners = 8;
			astdSize = inputSize;
			xCorners = new int[corners];
			yCorners = new int[corners];
			xCorners[0] = astdSize*15;
			yCorners[0] = 0;
			xCorners[1] = astdSize*10;
			yCorners[1] = astdSize*10;
			xCorners[2] = 0;
			yCorners[2] = astdSize*15;
			xCorners[3] = astdSize*-10;
			yCorners[3] = astdSize*10;
			xCorners[4] = astdSize*-15;
			yCorners[4] = 0;
			xCorners[5] = astdSize*-10;
			yCorners[5] = astdSize*-10;
			xCorners[6] = 0;
			yCorners[6] = astdSize*-15;
			xCorners[7] = astdSize*10;
			yCorners[7] = astdSize*-10;
			myCenterX = inputX;
			myCenterY = inputY;
			myColor = color(255,0,0);
			myPointDirection=0;
			fuelPoint = 225;
			isDead=false;
			astdSpecial=true;
			targetX=inputTargetX;
			targetY=inputTargetY;
			accelerate();
		}
		public void setSize(int inputSize){astdSize=inputSize;}
		public int getSize() {return astdSize;}
		public void setDead (boolean inputDead){isDead=inputDead;}
		public void accelerate()
		{
			double dRadians;
			if(astdSpecial==true)
			{
				dRadians = (atan2(targetY-60,targetX-500));
				myDirectionX = 5*(speedCont/((float)(astdSize)) * Math.cos(dRadians));
				myDirectionY = 5*(speedCont/((float)(astdSize)) * Math.sin(dRadians));
			}
			else
			{
			dRadians =((int)(Math.random()*361))*(Math.PI/180);
				myDirectionX = (0.75*speedCont/((float)(astdSize)) * Math.cos(dRadians));
				myDirectionY = (0.75*speedCont/((float)(astdSize)) * Math.sin(dRadians));
			}
			}
		public void move()
		{
			myCenterX+=myDirectionX;
			myCenterY+=myDirectionY;	
			if (myCenterX<-80) 	
			{
				myCenterX=width+80;
				if(astdSpecial==true){isDead=true;}
				else{fuelPoint=225;}
			}
			else if (myCenterX>width+80) 
			{
				myCenterX=-80;
				if(astdSpecial==true){isDead=true;}
				else{fuelPoint=225;}	
			}
			if (myCenterY<-80) 
			{
				myCenterY=width+80;
				if(astdSpecial==true){isDead=true;}
				else{fuelPoint=225;}
			}
			else if (myCenterY>width+80)
			{
				myCenterY=-80;
				if(astdSpecial==true){isDead=true;}
				else{fuelPoint=225;}
			}
			if (fuelPoint<=0)
			{
				isDead=true;
				if(astdSpecial==true)
				{
					asteroidList.add(new Asteroid(astdSize-1,myCenterX,myCenterY,targetX,targetY));
				}
				else if(astdSize>1)
				{
					asteroidList.add(new Asteroid(astdSize-1,myCenterX,myCenterY));
					asteroidList.add(new Asteroid(astdSize-1,myCenterX,myCenterY));
				}
			}
			else{myColor = color(255,255-fuelPoint,0);}
		}
	}
}