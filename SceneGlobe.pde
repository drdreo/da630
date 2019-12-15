
class SceneChangingNature extends Scene {

  SceneManager sm;
  int duration  = 0;

  int Nmax = 1200 ; 
  float M = 100 ; 
  float H = 0.4 ; 
  float HH = 0.01 ;
  float X[] = new float[Nmax+1] ; 
  float Y[] = new float[Nmax+1] ; 
  float Z[] = new float[Nmax+1] ;
  float V[] = new float[Nmax+1] ; 
  float dV[] = new float[Nmax+1] ; 
  float L ; 
  float R = 2*sqrt((4*PI*(400*400)/Nmax)/(2*sqrt(3))) ;
  float Lmin ; 
  int N ; 
  int NN ; 
  float KX ; 
  float KY ; 
  float KZ ; 
  float KV ; 
  float KdV ; 
  int K ;
  
  float scale = .75;

  SceneChangingNature(SceneManager sm) {  
    println("Scene Globe created!");
    this.sm = sm;

    for ( N = 0; N <= Nmax; N++ ) {
      X[N] = random(-600, +600) ;
      Y[N] = random(-600, +600) ;
      Z[N] = random(-600, +600) ;
    }
  }

  void checkPlayerLocation() {
    for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
    {
      Player p = playersEntry.getValue();
      println(p.x, p.y);
      this.createNatureChange(p.x, p.y);
    }
  }

  void doDraw() {
    background(0, 0, 0) ;


    for ( N = 0; N <= Nmax; N++ ) {
      for ( NN = N+1; NN <= Nmax; NN++ ) {
        L = sqrt(((X[N]-X[NN])*(X[N]-X[NN]))+((Y[N]-Y[NN])*(Y[N]-Y[NN]))) ;
        L = sqrt(((Z[N]-Z[NN])*(Z[N]-Z[NN]))+(L*L)) ;
        if ( L < R ) {
          X[N] = X[N] - ((X[NN]-X[N])*((R-L)/(2*L))) ;
          Y[N] = Y[N] - ((Y[NN]-Y[N])*((R-L)/(2*L))) ;
          Z[N] = Z[N] - ((Z[NN]-Z[N])*((R-L)/(2*L))) ;
          X[NN] = X[NN] + ((X[NN]-X[N])*((R-L)/(2*L))) ;
          Y[NN] = Y[NN] + ((Y[NN]-Y[N])*((R-L)/(2*L))) ;
          Z[NN] = Z[NN] + ((Z[NN]-Z[N])*((R-L)/(2*L))) ;
          dV[N] = dV[N] + ((V[NN]-V[N])/M) ;
          dV[NN] = dV[NN] - ((V[NN]-V[N])/M) ;
          stroke(250+(Z[N]/2), 250+(Z[N]/2), 250+(Z[N]/2)) ; 
          line(X[N]*scale*(400+V[N])/400+dsm.windowWidth/2, Y[N]*scale*(400+V[N])/400+dsm.wallHeight/2, X[NN]*scale*(400+V[NN])/400+dsm.windowWidth/2, Y[NN]*scale*(400+V[NN])/400+dsm.wallHeight/2) ;
        }
        if ( Z[N] > Z[NN] ) {
          KX = X[N] ; 
          KY = Y[N] ; 
          KZ = Z[N] ; 
          KV = V[N] ; 
          KdV = dV[N] ; 
          X[N] = X[NN] ; 
          Y[N] = Y[NN] ; 
          Z[N] = Z[NN] ; 
          V[N] = V[NN] ; 
          dV[N] = dV[NN] ;  
          X[NN] = KX ; 
          Y[NN] = KY ; 
          Z[NN] = KZ ; 
          V[NN] = KV ; 
          dV[NN] = KdV ;
        }
      }
      L = sqrt((X[N]*X[N])+(Y[N]*Y[N])) ;
      L = sqrt((Z[N]*Z[N])+(L*L)) ;
      X[N] = X[N] + (X[N]*(400-L)/(2*L)) ;
      Y[N] = Y[N] + (Y[N]*(400-L)/(2*L)) ;
      Z[N] = Z[N] + (Z[N]*(400-L)/(2*L)) ;
      KZ = Z[N] ; 
      KX = X[N] ;
      Z[N] = (KZ*cos(float(30)/10000))-(KX*sin(float(30)/10000)) ;
      X[N] = (KZ*sin(float(30)/10000))+(KX*cos(float(30)/10000)) ;
      KZ = Z[N] ; 
      KY = Y[N] ;
      Z[N] = (KZ*cos(float(30)/10000))-(KY*sin(float(30)/10000)) ;
      Y[N] = (KZ*sin(float(30)/10000))+(KY*cos(float(30)/10000)) ;
      dV[N] = dV[N] - (V[N]*HH) ; 
      V[N] = V[N] + dV[N] ; 
      dV[N] = dV[N] * H ;
    }

    this.checkPlayerLocation();

    // our random end declaration
    duration++;

    if (duration >= 500) {
      this.end();
    }
  }
  
  boolean isInCircle(float x, float y) {
    
    return true;
  }

  void createNatureChange(float x, float y) {
    float wallY = y - dsm.wallHeight;

    int constant = 200;
    Lmin = 600 ; 
    NN = 0 ;
    for ( N = 0; N <= Nmax; N++ ) {
      L = sqrt(((x-(constant+X[N]))*(x-(constant+X[N])))+((wallY-(constant+Y[N]))*(wallY-(constant+Y[N])))) ;
      if ( Z[N] > 0 && L < Lmin ) { 
        NN = N ; 
        Lmin = L ;
      }
    }
    if ( K == 0 ) { 
      dV[NN] = -500 ; 
      K = 1 ;
    } else { 
      dV[NN] = +500 ; 
      K = 0 ;
    }
  }

  void end() {
  }
}
