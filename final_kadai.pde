float placeX;
float placeY;
float placeZ;
float midX=0;
float midY=0;
float midZ=0;
float speed=2;
float mvsp=1;
float theta=0;
float theta1=0;
float theta2=0;
float distFromCam=10;
float firstMouseX, firstMouseY, firstTheta1, firstTheta2;
int move=0;
import processing.opengl.*;
PShape IP;
void setup()
{
  size(1500,1000,P3D);
  placeX=0;
  placeY=10;
  placeZ=-100;
  theta=45;
  theta1=-90;
  theta2=270;
  firstMouseX=mouseX;
  firstMouseY=mouseY;
  firstTheta1=theta1;
  firstTheta2=theta2;
  IP = loadShape("title.obj");
}
void draw()
{
  background(173,207,252);
  // カメラの設定
  perspective(
    radians(theta), // 視野角
    float(width)/float(height), // アスペクト比
    0.1, 1000.0                   // クリッピング距離
    );
  midX=placeX+sin(radians(theta1))*cos(radians(theta2));//カメラの中心点X
  midY=placeY+cos(radians(theta1));//カメラの中心点Y
  midZ=placeZ+sin(radians(theta1))*sin(radians(theta2));//カメラの中心点Z
  theta1=theta1%360;
  theta2=theta2%360;
  camera(
    placeX, placeY, placeZ, // 視点：カメラの位置
    midX, midY, midZ, // 中心点：ここが視界の中心に映るようにする
    0, -1, 0   // 上向き：上向きにしたい軸に「-1」を入れる
    );
  // ----- ----- ----- ----- -----
  // 光源の設定

  //directionalLight(
  //  255, 255, 255,  // 照明光の色
  //  -1, -1, -1        // 照明の向き
  //);
  
  pointLight(255,255,255,placeX,placeY,placeZ);
  //XYZ();
  //surface();
  howToMove();
  object();
  println("placeX:"+placeX+",placeY:"+placeY+",placeZ:"+placeZ);
 // println("midX:"+midX+",midY:"+midY+",midZ:"+midZ);
  //println("theta1:"+theta1+",theta2:"+theta2);
  /*/
  stroke(255, 0, 0);
  strokeWeight(5);
  line(-100, 0, -8, 100, 0, -8);
  line(-100, 0, 8, 100, 0, 8);
  /**/
  
 
  if(placeZ>=100)
  {
    placeX=0;
    placeY=10;
    placeZ=-100;
  }
  
  
}
void mousePressed()
{
  firstMouseX=mouseX;
  firstMouseY=mouseY;
  firstTheta1=theta1;
  firstTheta2=theta2;
}
void keyPressed()
{
  if(key==' ')
  {
    move=1-move;
  }
}
void howToMove()
{
  /*/
   theta1=theta1+(-(float)mouseY+(float)pmouseY)/2.0;
   theta2=theta2+(-(float)mouseX+(float)pmouseX)/2.0;
  /**/
  if (theta1>-1)
  {
    theta1=-1;
  }
  if (theta1<-179)
  {
    theta1=-179;
  }
  if (theta<=1)
  {
    theta=1;
  }
  if (theta>=179)
  {
    theta=179;
  }
  /**/
  if(move==1)
  {
    placeZ+=0.2;
  }
  if (mousePressed)
  {
    theta1=firstTheta1+(mouseY-firstMouseY)/10;
    theta2=firstTheta2+(mouseX-firstMouseX)/10;
    if (theta1>0)
    {
      theta1=-1;
    }
    if (theta1<-180)
    {
      theta1=-179;
    }
  }
  /**/
  //------------------------------------------
  if (keyPressed)
  {
    if (key=='q')
    {
      theta-=speed;
    }
    if (key=='e')
    {
      theta+=speed;
    }
    if (key=='w')
    {
      placeX-=mvsp*cos(radians(theta2));
      placeZ-=mvsp*sin(radians(theta2));
      if (theta1>=0&&theta1<=180)
      {
        placeY-=mvsp*cos(radians(theta1));
      } else
      {
        placeY+=mvsp*cos(radians(theta1));
      }
    }
    if (key=='a')
    {
      placeX-=mvsp*-sin(radians(theta2));
      placeZ-=mvsp*cos(radians(theta2));
    }
    if (key=='s')
    {
      placeX+=mvsp*cos(radians(theta2));
      placeZ+=mvsp*sin(radians(theta2));
      if (theta1>=0&&theta1<=180)
      {
        placeY+=mvsp*cos(radians(theta1));
      } else
      {
        placeY-=mvsp*cos(radians(theta1));
      }
    }
    if (key=='d')
    {
      placeX-=mvsp*sin(radians(theta2));
      placeZ-=mvsp*-cos(radians(theta2));
    }
    if (keyCode==UP)
    {
      placeY+=1;
    }
    if (keyCode==DOWN)
    {
      placeY-=1;
    }
  }
}
void surface()
{
  stroke(0);
  for (int x=-10; x<=10; x+=1) {

    line( x, 0, -10, x, 0, 10 );
  }
  for (int z=-10; z<=10; z+=1) {
    line( -10, 0, z, 10, 0, z );
  }
}
void XYZ()
{
  //X軸...赤線
  stroke(255, 0, 0);
  line(-500, 0, 0, 500, 0, 0);
  //Y軸...緑線
  stroke(0, 255, 0);
  line(0, -500, 0, 0, 500, 0);
  //Z軸...青線
  stroke(0, 0, 255);
  line(0, 0, -500, 0, 0, 500);
}
void object()
{
  pushMatrix();
  shape(IP);
  popMatrix();
}
