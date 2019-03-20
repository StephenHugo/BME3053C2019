/*
 * This is some example code:
 * The goal here is to set up a simple serial connection
 * between matlab and the arduino
 */

/* 
 * These are examples of libraries you might need 
 */
//#include <Wire.h>
//#include <I2Cdev.h>
//#include <MPU6050.h>

/* This would set up an object 'mpu' with the address 0x68
 * The 0x__ denotes a hexidecimal value taking up 1 byte
 * 0x68 would be 0b01101000, which is 104 in decimal
 * Used here it just references a pin address
 */ 
// MPU6050 mpu(0x68); 

int16_t x[6]; // This creates a valiable
char val = 0; // This creates another

/*
 * The setp loop runs once at the beginning of code 
 * or if the main loop crashes. There is usually a reset button
 * on most Arduino models that will force this to rerun
 */

void setup() {

  // Wire.begin(); This would set up the wire library

/*
 * The number below is the baud rate 
 * It must match matlab!!
 * If you click the serial monitor in the Arduino IDE, the 
 * default baud rate may be different, producing funky symbols
 */
  
  Serial.begin(115200); 

  pinMode(LED_BUILTIN, OUTPUT);
  
  delay(100); // programming delay
  
  // mpu.initialize(); // initializes sensor
  
  // delay(100); // wait for that too

  /*
   * Sometimes you want to test whether your sensors and other
   * components are awake, so you'd run something like the
   * code below. In this example, we only need the 
   * serial connection setup up, i.e. Serial.begin(#####);
   */

  /*
  if(!mpu.testConnection()){
    Serial.println("not running...");
  }
  */
}

void loop() {

// check the serial connection for messages
  if(Serial.available())
  {
    // read the value
    val = Serial.read();
    delay(10);

    // do something if there is a match
    if(val=='R') // from the matlab code, 'R' is arbitrary

    /* 
     * talk to the component to get data 
     */
      // mpu.getMotion6(&x[0],&x[1],&x[2],&x[3],&x[4],&x[5]);

      /*
       * This is where code to read and write off the arduino 
       * pins would be
       */
      Serial.println("potatoes"); // send data, not potatoes
      Serial.println("chomatoes"); // check format on matlab side
      delay(1000); // arbitrary delay
      /*
       * This read 6 values from the MPU accelerometer 
       * and sent them back to matlab via serial connection
      for(int i;i<6;i++){
        //send data back to MATLAB through the serial connection
        Serial.println(x[i]);
      }
      */
  } else {
      digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
      delay(100);                       // wait for a second
      digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
      delay(90);   
  }

  // don't lock up the arduino if no messages have been sent
  delay(10);
  
}
