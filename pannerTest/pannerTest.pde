// Panner_01.pde
// this example demonstrates how to use the Panner object
// this example extends Filter_01.pde

import beads.*;

String sourceFile;
SamplePlayer sp;

// standard gain objects
Gain g;
Glide gainValue;
// our Panner will control the stereo placement of the sound
Panner p;
// a Low-Frequency-Oscillator for the panner
WavePlayer panLFO;

void setup(){  
  size(800, 600);
  
  ac = new AudioContext();
  
  sp = getSamplePlayer("synth.mp3");

  sp.setKillOnEnd(false);
   
  // as usual, we create a gain that will control the volume
  // of our sample player
  gainValue = new Glide(ac, 0.0, 20);
  g = new Gain(ac, 1, gainValue);
  g.addInput(sp); // connect the filter to the gain
  
  // In this block of code, we create an LFO - a Low
  // Frequency Oscillator - and connect it to our panner.
  // A low frequency oscillator is just like any other
  // oscillator EXCEPT the frequency is subaudible, under
  // 20Hz.
  // In this case, the LFO controls pan position.
  // Initialize the LFO at a frequency of 0.33Hz.
  panLFO = new WavePlayer(ac, 0.33, Buffer.SINE);
  // initialize the panner. to set a constant pan position,
  // merely replace "panLFO" with a number between -1.0
  // (LEFT) and 1.0 (RIGHT)
  p = new Panner(ac, panLFO);
  p.addInput(g);
  
  // connect the Panner to the AudioContext
  ac.out.addInput(p);
  // begin audio processing
  ac.start();
  
  background(0); // draw a black background
  text("Click to hear a Panner object connected to an LFO.",50, 50); // tell the user what to do
}

void draw(){}

void mousePressed(){
  // set the gain based on mouse position and play the file
  gainValue.setValue((float)mouseX/(float)width);
  sp.setToLoopStart();
  sp.start();
}
