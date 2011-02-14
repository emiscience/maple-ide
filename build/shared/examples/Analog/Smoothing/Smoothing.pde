/*
  Smoothing

  Reads repeatedly from an analog input, calculating a running average
  and printing it to the computer.  Keeps ten readings in an array and
  continually averages them.

  The circuit:
  * Analog sensor (potentiometer will do) attached to pin 15

  Created 22 April 2007
  By David A. Mellis  <dam@mellis.org>

  http://www.arduino.cc/en/Tutorial/Smoothing

  Ported to Maple 27 May, 2010 by Bryan Newbold
*/

// Define the number of samples to keep track of.  The higher the number,
// the more the readings will be smoothed, but the slower the output will
// respond to the input.  Using a constant rather than a normal variable lets
// use this value to determine the size of the readings array.
const int numReadings = 10;

int readings[numReadings];      // the readings from the analog input
int index = 0;                  // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average

int inputPin = 15;

void setup() {
  // Declare the input pin as INPUT_ANALOG:
  pinMode(inputPin, INPUT_ANALOG);

  // Initialize all the readings to 0:
  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
}

void loop() {
  // Subtract the last reading:
  total = total - readings[index];
  // Read from the sensor:
  readings[index] = analogRead(inputPin);
  // Add the reading to the total:
  total = total + readings[index];
  // Advance to the next position in the array:
  index = index + 1;

  // If we're at the end of the array...
  if (index >= numReadings) {
    // ...wrap around to the beginning:
    index = 0;
  }

  // Calculate the average:
  average = total / numReadings;
  // Send it to the computer (as ASCII digits)
  SerialUSB.println(average, DEC);
}
