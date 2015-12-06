class Cube {
  
  float x,y,z;
  float x_default,y_default,z_default;
  boolean inUse =false;
  Cube(float x,float y,float z){
      x_default = x;
      y_default  = y;
      z_default = z;
      //rotateX(PI/6); 
    
  }
  
  void create(float x_, float y_, float z_){
    x = x_;
    y = y_;
    z = z_;
  pushMatrix();
  translate(x, y, z);
  box(50,50,50);
  popMatrix();
  }
  
  
  void moveToFace(int face){
    switch(face){
      //Right Face
      case 1:
        x = 50;
        y = 0;
        z = -25;
        break;
      //Left Face
      case 2:
        x = -50;
        y = 0;
        z = -25;
        break;
      //Bottom
      case 3:
        x = 0;
        y = 50;
        z = -25;
        break;
      //Top
      case 4:
        x = 0;
        y = -50;
        z = -25;
        break;
      //Front
      case 5:
        x = 0;
        y = 0;
        z = 25;
        break;
    }
    //x = x_;
    //y = y_;
    //z = z_;
  pushMatrix();
  translate(x, y, z);
  box(50,50,50);
  popMatrix();
  }
  void transFormToDefault(){
    x = x_default;
    y = y_default;
    z =z_default;
  pushMatrix();
  translate(x, y, z);
  box(50,50,50);
  popMatrix();
  }
  
  //void transformX (float x_){
  //  x = x_;
  //  pushMatrix();
 
  //  translate(x,y,z);
  //  popMatrix();
  //}
}