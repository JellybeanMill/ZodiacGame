//NESSESSARY OBJECT DECLARATIONS
SpaceShip shipMagellan;
Bullet [] bulletList;
AriesHead mainAriesHead;
CancerHead mainCancerHead;
ArrayList <Asteroid> asteroidList = new ArrayList <Asteroid>();
//INPUT VARIABLES
boolean keyW = false;
boolean keyA = false;
boolean keyS = false;
boolean keyD = false;
boolean keySpace = false;
boolean keyShift = false;
//GLOBAL VARIABLES
float speedCont = 5;
int bulletListLength = 0;
int frameCounter = 0;
int shipHealth = 50;
int stayCounter = 0;
boolean shipFiring = false;
//SCREENS AND COUNTERS
boolean titleScreen = true;
boolean bossSelectScreen = false;
boolean ariesBossScreen = false;
boolean cancerBossScreen = false;
boolean bossBattleTrue = false;
boolean deathScreen = false;
int dsCounter = 0;
boolean winScreen = false;
//BUTTONS
Button aquariusStart;
Button piscesStart;
Button ariesStart;
Button taurusStart;
Button geminiStart;
Button cancerStart;
Button leoStart;
Button virgoStart;
Button libraStart;
Button scorpioStart;
Button sagittariusStart;
Button capricornStart;
Button returnToMainMenu;
public void setup() 
{
	size(1000,600);
	shipMagellan = new SpaceShip();
	bulletList = new Bullet[300];
	cancerStart = new Button("CANCER",20,860,150,200,150);
	ariesStart = new Button("ARIES",20,140,150,200,150);
	returnToMainMenu = new Button("Main Menu",20,500,450,150,50);
}
public void draw()
{
	if(titleScreen==true){titleDraw();}
	else if(bossSelectScreen==true){bossSelectDraw();}
	else if(deathScreen==true){deathScreenDraw();}
	else if(winScreen==true){winScreenDraw();}
	else if(ariesBossScreen==true){ariesBossDraw();}
	else if(cancerBossScreen==true){cancerBossDraw();}
}
public void mouseClicked()
{
	if(titleScreen==true)
	{
		titleScreen=false;
		bossSelectScreen=true;
		frameCounter=0;
	}
	else if(bossSelectScreen==true)
	{
		if(ariesStart.isHovering()==true)
		{
			bossSelectScreen=false;
			ariesEnterDraw();
			ariesBossScreen=true;
		}
		else if(cancerStart.isHovering()==true)
		{
			bossSelectScreen=false;
			cancerEnterDraw();
			cancerBossScreen=true;
		}
	}
	else if(bossBattleTrue==true&&returnToMainMenu.isHovering()==true&&(winScreen==true||deathScreen==true))
	{
		cancerBossScreen=false;
		winScreen=false;
		deathScreen=false;
		bossSelectScreen=true;
		bossBattleTrue=false;
		shipHealth=50;
	}
}
public void titleDraw()
{
	background(0);
	textAlign(CENTER,CENTER);
	fill(255);
	textSize(20);
	text("Click anywhere to start",500,500);
}
public void bossSelectDraw()
{
	background(0);
	cancerStart.show();
	ariesStart.show();
}
public void shipMove()
{
	frameCounter++;
	if(shipHealth>0)
	{
		if (mousePressed==true)
		{
			shipFiring=true;
			if(frameCounter%((int)(180.0/(shipMagellan.getWarpPoint()/2+5))+1)==0)
			{
				shipMagellan.setWarpPoint(shipMagellan.getWarpPoint()-1);
				fireBullet();
			}
		}
		else if(mousePressed==false){shipFiring=false;}
		if (frameCounter>=600){frameCounter=0;}
		for (int i=0;i<bulletListLength;i++)
		{
			bulletList[i].move();
			bulletList[i].rotate();
			if (bulletList[i].getDead()==false)
			{
				bulletList[i].show();
			}
		}
		shipMagellan.rotate();
		if(winScreen==false)
		{
			shipMagellan.move();
			shipMagellan.accelerate();
		}
		shipMagellan.show();
	}
	loadBar();
    if(shipHealth<=0)
    {
    	deathScreen=true;
    	shipHealth=0;
    }
}
public void ariesEnterDraw()
{
	mainAriesHead = new AriesHead();
	bossBattleTrue = true;
}
public void ariesBossDraw()
{
	background(0);
	shipMove();
	mainAriesHead.show();
}
/* MOVED
public void cancerEnterDraw()
{
	for(int lp1=asteroidList.size()-1;lp1>=0;lp1--){asteroidList.remove(lp1);}
	for(int i =0;i<2;i++)
	{
		asteroidList.add(new Asteroid(4,(int)(Math.random()*1360)-180,-80));
	}
	mainCancerHead = new CancerHead();
	bossBattleTrue = true;
}
public void cancerBossDraw()
{
	background(0);
	if (frameCounter%100==0&&winScreen==false){generateAsteroids();}
	for (int i=0;i<asteroidList.size();i++)
	{
		asteroidList.get(i).move();
		asteroidList.get(i).rotate();
		if (asteroidList.get(i).getDead()==false)
		{
			asteroidList.get(i).show();
		}
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
}*/
public void deathScreenDraw()
{
	dsCounter++;
	if(cancerBossScreen==true&&dsCounter%5==0)
	{
		cancerBossDraw();
	}
	if(dsCounter%5==0)
	{
		fill(255);
		textSize(100);
		textAlign(CENTER,CENTER); 
		text("YOU DIED",500,275);
	}
	if(dsCounter>=5){dsCounter=0;}
	returnToMainMenu.show();
}
public void winScreenDraw()
{
	dsCounter++;
	if(cancerBossScreen==true&&dsCounter%5==0)
	{
		cancerBossDraw();
	}
	if(dsCounter%5==0)
	{
		fill(255);
		textSize(100);
		textAlign(CENTER,CENTER); 
		text("YOU WON",500,275);
	}
	if(dsCounter>=5){dsCounter=0;}
	returnToMainMenu.show();
}
public void fireBullet()
{
	int bulletNum=1024;
	for(int i=0;i<bulletListLength;i++)
	{
		if(bulletList[i].getDead()==true) {bulletNum = i;}
	}
	if (bulletNum!=1024)
	{
		bulletList[bulletNum] = new Bullet();
		bulletList[bulletNum].accelerate();
	}
	else
	{
		bulletList[bulletListLength] = new Bullet();
		bulletList[bulletListLength].accelerate();
		bulletListLength+=1;
	}
}
public void keyPressed()
{
	if ((key == 'w')||(key=='W')) {keyW = true;}
	if ((key == 's')||(key=='S')) {keyS = true;}
	if ((key == 'a')||(key=='A')) {keyA = true;}
	if ((key == 'd')||(key=='D')) {keyD = true;}
	if ((key == ' ')) {keySpace = true;}
	if (key == CODED)
	{
		if(keyCode == SHIFT){keyShift = true;}
	}
}
public void keyReleased()
{
	if ((key == 'w')||(key=='W')) {keyW = false;}
	if ((key == 's')||(key=='S')) {keyS = false;}
	if ((key == 'a')||(key=='A')) {keyA = false;}
	if ((key == 'd')||(key=='D')) {keyD = false;}
	if ((key == ' ')) {keySpace = false;}
	if (key == CODED)
	{
		if(keyCode == SHIFT){keyShift = false;}
	}
}
public void loadBar()
{
	stroke(0,0,255);
	noFill();
	rect(810,579,181,11);
	stroke(255);
	rect(9,579,181,11);
	noStroke();
	fill(0,0,255);
	rect(811,580,shipMagellan.getWarpPoint(),10);
	fill(255);
	rect(10,580,(int)(shipHealth*3.6),10);
}
public void hitSomethingAries()
{
	//HIT ARIES
	
}
public void hitSomethingCancer()
{
	//BULLET ASTEROID CONTACT
	for (int loop1=0;loop1<bulletListLength;loop1++)
	{
		for (int loop2=0;loop2<asteroidList.size();loop2++)
		{
			if (dist(bulletList[loop1].getX(),bulletList[loop1].getY(),asteroidList.get(loop2).getX(),asteroidList.get(loop2).getY())<=(asteroidList.get(loop2).getSize()*15.0))
			{
				if(bulletList[loop1].getFuel()/10.0<asteroidList.get(loop2).getFuel())
				{
					asteroidList.get(loop2).setFuel(asteroidList.get(loop2).getFuel()-((int)(bulletList[loop1].getFuel()/(float)(asteroidList.get(loop2).getSize()))));
					bulletList[loop1].setFuel(0);
				}else
				{
					bulletList[loop1].setFuel(bulletList[loop1].getFuel()-(asteroidList.get(loop2).getFuel()*asteroidList.get(loop2).getSize()));
					asteroidList.get(loop2).setFuel(0);				}
			}
		}
	}
	//SHIP ASTEROID CONTACT
	for (int loop1=0;loop1<asteroidList.size();loop1++)
	{
		if(dist(asteroidList.get(loop1).getX(),asteroidList.get(loop1).getY(),shipMagellan.getX(),shipMagellan.getY())<=(asteroidList.get(loop1).getSize()*13)+8&&asteroidList.get(loop1).getDead()==false)
		{
			shipHealth-=asteroidList.get(loop1).getSize();
			asteroidList.get(loop1).setFuel(0);
		}
	}
	//BULLET BOSS HEAD CONTACT
	for(int lp2=0;lp2<bulletListLength;lp2++)
	{
		if(dist(500,-866,bulletList[lp2].getX(),bulletList[lp2].getY())<1002&&bulletList[lp2].getDead()==false)
		{
			mainCancerHead.setHealth(mainCancerHead.getHealth()-1);
			bulletList[lp2].setDead(true);
		}
	}
	//SHIP BOSS HEAD CONTACT
	if(dist(500,-866,shipMagellan.getX(),shipMagellan.getY())<=1005)
	{
		stayCounter++;
		if(stayCounter>=30)
		{
			shipHealth--;
			stayCounter=0;
		}
	}
	else
	{
		stayCounter=0;	
	}
}
public void generateAsteroids()
{
	int [] astdSizeCount = new int[4];
	for (int lp1=0;lp1<asteroidList.size();lp1++){astdSizeCount[asteroidList.get(lp1).getSize()-1]++;}
	if(astdSizeCount[0]<=2&&asteroidList.size()<=64){asteroidList.add(new Asteroid(4,(int)(Math.random()*1200)-100,-100));}
	if(astdSizeCount[1]<=4&&asteroidList.size()<=64){asteroidList.add(new Asteroid(3,(int)(Math.random()*1200)-100,-100));}
	if(astdSizeCount[2]<=8&&asteroidList.size()<=64){asteroidList.add(new Asteroid(2,(int)(Math.random()*1200)-100,-100));}
	if(astdSizeCount[3]<=16&&asteroidList.size()<=64){asteroidList.add(new Asteroid(1,(int)(Math.random()*1200)-100,-100));}
}
public void destroyAsteroids()
{
	for(int lp1=0;lp1<asteroidList.size();lp1++)
	{
		if(asteroidList.get(lp1).getDead()==true)
		{
			asteroidList.remove(lp1);
			lp1--;
		}
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
}/*MOVED
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
}*/
class AriesHead
{
	private int cdCharge, abCounter;
	private double myX, myY, radDirection, myHealth, maxHealth, lockedRadDirection,secTravelDist;
	private boolean abCharge;
	public AriesHead()
	{
		myX=500;
		myY=100;
		radDirection=radians(270);
		lockedRadDirection=radDirection;
		maxHealth=720;
		myHealth=maxHealth;
		cdCharge=0;
		abCounter=0;
	}
	public void show()
	{
		radDirection=atan2((float)(shipMagellan.getY()-myY),(float)(shipMagellan.getX()-myX));
		noStroke();
		fill(128,128,128);
		ellipse((float)myX,(float)myY,100,100);
		fill(255,0,0);
		if(abCharge==false)
		{
			ellipse((float)(myX+(30*Math.cos(radDirection))),(float)(myY+(30*Math.sin(radDirection))),10,10);
			cdCharge++;
		}
		else{ellipse((float)(myX+(30*Math.cos(lockedRadDirection))),(float)(myY+(30*Math.sin(lockedRadDirection))),10,10);}
		if(Math.random()*cdCharge>60+(myHealth))
		{
			abCharge=true;
			secTravelDist=(dist((float)myX,(float)myY,shipMagellan.getX(),shipMagellan.getY()))/10.0;
			lockedRadDirection=radDirection;
			cdCharge=0;
		}
		if(abCharge==true){fireCharge();}
	}
	public void fireCharge()
	{
		abCounter++;
		if(abCounter>45)
		{
			myX=myX+(secTravelDist*Math.cos(lockedRadDirection));
			myY=myY+(secTravelDist*Math.sin(lockedRadDirection));
		}
		if(dist(shipMagellan.getX(),shipMagellan.getY(),(float)myX,(float)myY)<=70)
		{
			shipMagellan.setNoControl(true);
			shipHealth-=10;
			float launchDirection=(float)(Math.atan2(shipMagellan.getY()-myY,shipMagellan.getX()-myX));
			shipMagellan.setDirectionX(secTravelDist*2*Math.cos(launchDirection));
			shipMagellan.setDirectionY(secTravelDist*2*Math.sin(launchDirection));
		}
		if(abCounter>=55)
		{
			abCharge=false;
			abCounter=0;
			shipMagellan.setNoControl(false);
		}
	}
}/* MOVED
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
}*/
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