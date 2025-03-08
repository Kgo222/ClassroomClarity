# Maddie Worklog

## Research and Progress

### Week of 2/23/2025: Work on version 1 of PCB

### 3/8/2025: Breadboard Demo Preperations
Came into the lab with Jesse and Kait to prepare for the breadboard demo on Monday. My task was to construct the physical breadboard layout while Jesse tested the rotary encoder and Kait worked on the microcontroller code. Our goal is to display the functionality of the power conversion subsystem, and parts of the control and feedback sub systems. We will be powering the microcontroller and screen with the converter and displaying a message on the screen wich can be interacted with with a button. 

#### The Process
- started with the DC DC converter module and hooked up the Vin pin to the lab's DC power supply through the bannana jacks on the proto board
- connected the Vout pin (3.3V) to the dev board and the screen
- set up the clear button and it's debouncing components and connected to the microcontroller
- wired the SPI connections between the screen and the dev board
- Tested that the converter outputs 3.3V --> Passed! (pictures of multimeter in PowerVerification3Test)



## Team Meeting Notes

### 3/4/2025: Team meeting 
Discussed how the physical deisign of the hub casing should look. 
-Wanted to prioritize flexibility in user placement of the hub while also keeping portability in mind
- Presented the idea of using an ipad case as a basis for the design
    - gives ability to change angle of the screen
    - allows to fold into a less intrusive size for transport
- Discussed how we should handle the vibration motor
    - wanted to keep seperate from main hub to avoid vibrating the PCB
    - need to design a seperate casing for the motor itself
    - need to figure out how to fit the motor and casing into the hub for transport
