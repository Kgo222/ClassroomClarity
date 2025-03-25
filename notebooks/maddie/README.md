# Maddie Worklog

## Research and Progress

### 2/13/2025: Power conversion research
- looked into different LDOs and voltage regulators to step down 5V adapter input
- did math to figure out resister values for LDO (power conversion considerations.pdf)


### 2/26/2025: Power Conversion Reconsiderations 
- regular regulators have to high voltage drop --> look for LDOs
- looked for LDOs within the needs for our circuit --> could not find with high enough current
- Looked for DC to DC conversion modules --> found the TPSM84203EAB

### 2/26/2025: PCB Version 1 Schematic and Layout

#### The Schematic 
- started with the power management subsytem
- 

#### The Layout


### 3/8/2025: Breadboard Demo Preperations
Came into the lab with Jesse and Kait to prepare for the breadboard demo on Monday. My task was to construct the physical breadboard layout while Jesse tested the rotary encoder and LED indicators and Kait worked on the microcontroller code. Our goal is to display the functionality of the power conversion subsystem, and parts of the control and feedback sub systems. We will be powering the microcontroller and screen with the converter and displaying a message on the screen wich can be interacted with with a button. 

#### The Process
- started with the DC DC converter module and hooked up the Vin pin to the lab's DC power supply through the bannana jacks on the proto board
- connected the Vout pin (3.3V) to the dev board and the screen
- set up the clear button and it's debouncing components and connected to the microcontroller
- set up rotary controller circuit 
- wired the SPI connections between the screen and the dev board
- tested that the converter outputs 3.3V +/- 0.3V given 5V --> Passed! (pictures of multimeter in PowerVerification3Test)

### 3/24/2025: Autodesk set up 
- taking over 3D modeling from Kait so she can focus on app and bluetooth
- Fusion licence expired -> unsure why this occured
- Found new student license through the webstore
- tranfered prototype file from Kait to my laptop
- watched some fusion tutorials

## Team Meeting Notes

### 2/12/2025 Team meeting 
- Completed team contract together
- Discussed everyone's strengths and divided up tasks accordingly
      - Maddie --> Power management and PCB design
      - Jesse --> Control Signals
      - Kait --> App Design
- Started project proposal

### 2/18/2025 Team meeting
- Researched and ordered preliminary parts
- Created a budget sheet to track money spent and parts ordered

### 2/25/2025 Team meeting
- Researched GPIOs for the microcontroller
- Switched from ESP32-PICO to ESP32-WROOM to better line up with our GPIO requirements 

### 3/4/2025 Team meeting 
Discussed how the physical deisign of the hub casing should look. 
-Wanted to prioritize flexibility in user placement of the hub while also keeping portability in mind
- Presented the idea of using an ipad case as a basis for the design
    - gives ability to change angle of the screen
    - allows to fold into a less intrusive size for transport
- Discussed how we should handle the vibration motor
    - wanted to keep seperate from main hub to avoid vibrating the PCB
    - need to design a seperate casing for the motor itself
    - need to figure out how to fit the motor and casing into the hub for transport
      
### 3/11/2025 Team meeting 
- Discussed buying an android phone for ease of debugging for app development and demo
    - decided to get the phone using our own money
- Goals for the week we get back
      -Kait - bluetooth
      -Jesse - GPIO configurations
      -Maddie - assemble and test PCB
      -All - find headers and specific LED array
- Submitted order for microcontroller, resistors, and caps from the electronic services shop to TA
- Submitted order for caps and resistors that we cant get from the sevices shop from digikey

### 3/24/2025 TA meeting 
- PCB arrived!
- Need to see why my AutoDesk access expired
- Will solder and test PCB this week
- All supplies have arrived
- Next PCB order is on Monday

### 3/25/2005 Team meeting 
- Discussed lighting scheme for class engagement meeter --> assigned Jesse to polish it 
- Discussed when I would have the PCB soldered and ready to test --> Wednesday at 2PM
- Figured out how to tranfer Fusion 360 file from Kait to me
- Kait recieved pixel phone and is starting bluetooth configuration 

