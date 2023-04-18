int terms = 10;

float x0, y0;
float[] x = new float[terms+1];
float[] y = new float[terms+1];
float[] omega = new float[terms];
float[] theta = new float[terms];
float[] A = new float[terms];
float t;

float start_signal;

ArrayList<Float> x_points = new ArrayList<>();
ArrayList<Float> y_points = new ArrayList<>();

void setup() {
  fullScreen();
  
  start_signal = 2 * width/5;
  
  for (int i=0;i<terms;i++) {
    A[i] = 100 * ((4 / PI) * (1 / ((2.0 * (i + 1)) - 1)));
    omega[i] = 2 * PI * (2 * (i + 1) - 1);
    print(A[i], omega[i] + "\n");
  }
  
  x[0] = width/5;
  y[0] = 0;
  
  noFill();
  stroke(255);
}

void draw() {
  background(0);
  textSize(40);
  text("TERMS OF SERIES: " + terms, 20, 60);
  
  translate(0, height/2);
  
  t = frameCount * 0.005;
 
  noFill();
  stroke(255);
  for (int i=0;i<terms;i++) {
    strokeWeight(0.5);
    circle(x[i], y[i], A[i]*2);
    
    theta[i] = omega[i] * t;

    x[i+1] = x[i] + A[i] * cos(theta[i]);
    y[i+1] = y[i] + A[i] * sin(theta[i]);
    
    strokeWeight(2);
    line(x[i], y[i], x[i+1], y[i+1]);
  }
  
  strokeWeight(1);
  line(start_signal, 2*A[0], start_signal, -2*A[0]);
 
  
  x_points.add(start_signal + frameCount);
  y_points.add(y[terms]);
  
  strokeWeight(0.5);
  line(x[terms], y[terms], x_points.get(x_points.size() - 1), y[terms]);
   
  strokeWeight(2);
  for (int i=1;i<x_points.size();i++) {
    line(x_points.get(i-1), y_points.get(i-1), x_points.get(i), y_points.get(i));
  }
}
