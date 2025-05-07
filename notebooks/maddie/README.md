# Maddie Worklog

## Research and Progress

### 2/13/2025: Power conversion research
- Looked into different LDOs and voltage regulators to step down 5V adapter input
- Did math to figure out resistor values for LDO
- Created block diagram for Power Management Subsystem 
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/Resistor%20Math.png)

![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/Power%20Management%20Block%20Diagram%20%20(1).png)

### 2/26/2025: Power Conversion Reconsiderations 
- Regular regulators have to high voltage drop --> look for LDOs
- Looked for LDOs within the needs for our circuit --> could not find with high enough current
- Looked for DC to DC conversion modules --> found the TPSM84203EAB
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/LDO%20considerations.png)


### 2/26/2025: PCB Version 1 Schematic and Layout

#### The Schematic 
- Started with the power management subsytem
- Moved on to microcontroller footprint and added all the IOs given to me by Jesse
- Placed all relevant components on the board after that and sorted them into their respective subsystems
- Added button and rotary debounce based on Jesse's calculations
- Added in dividers and text to frame the dubsytems and increase readability of schematic
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/Ver1%20Schematic.PNG)

#### The Layout
- Placed microcontroller central on the board then placed components around it
- Made a box with the maximum size for the pcb ordering software and made sure to stay well within the guidelines
- Placed headers in a way so that there were little to no overlapping signals
- Added ground stitching vias 
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/Ver1%20PCB%20layout.PNG)

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

### 3/26/2025: PCB soldering 
- used reflow oven to solder surfacemount parts and microcontroller chip

### 3/30/2025: PCB soldering & Testing 
- soldered through hole components
- programmed microcontroller with breadboard demo test code
- ensured function and measured some important signals
- Created and sent in PCB Version 2 

#### Changes for Next PCB Version
- 5V on the rotary encoder circuit needs to become 3.3V
- Change some GPIOs for the screen
- Fix button footprint
- Fix test point footprint
- Remove extra 0.1uF cap on button debounce → unnecessary complexity
- pull up clear button to be consistent with programming buttons
- change clear button cap to 1uF
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/Ver%202%20Schematic.PNG)
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/Ver2%20Layout.PNG)

### 3/31/2025 PCB Debugging
#### Power management system 
- Problem: Barrel jack is not providing the correct input voltage
    - Used multimeter to check voltage at various test points on pcb → DC DC converter not receiving power
    - Used a spare barrel jack to test AC adapter  away from the pcb → functioned correctly (+5V)
    - Placed new barrel jack onto pcb → back to incorrect function 
        - Most likely a wiring issue on the board 
    - Checked resistance to ground using multimeter for different points
        -Between 3v3 test point and GND test point → in megaohms (good)
        - Between Vo and GND pins of DC DC converter → in kiloohms (bad → should be same as test points)
        - Between testpoint GND and GND pin → 1.5 megaohms (bad → should be almost zero) 
        - Conclusion: bad connection between GND pin on DC DC converter and ground plane
    - Resoldered pad → resistance issues fixed 

- Problem: Barrel jack still is not providing correct input 
    - Disconnected AC adapter and used DC power supply to provide +5V  by soldering wires to barrel jack pins
    - DC supply provides correct voltage
    - DC DC converter functioning properly
    - Conclusion → problem with AC adapter 

- Problem: AC Adapter not Supplying Power 
    - Hypothesis: current spike at plug in is triggering overcurrent protection
 
### 4/7/2025 PCB Testing and Debugging 
- Attempted to add capacitor across input to fix adapter issue --> did not work
    - Putting this to the side for now to focus on the rest of the board
- Tested voltage across motor, seemed a bit off
    - Programmed a test to have motor on for 30 seconds, off for 30s
    - was successful, strange voltage was from floating pin in the code
 
### 4/14/2025 Version 2 Soldering 
- Collected new board and parts
- Focused on keeping components straight and soldering clean
    - Want to have this be the final board
- Since reflow oven did not work as desired last time, I used solder paste and hot air to solder on microcontroller and usb connector
    - Note: this can be an easy point of failure due to the fact that the groound pads are under the microcontroller. Be aware of this if any errors occur when testing, solder paste may not have melted
- Had to remove DC/DC converter from version 1 board since component has since gone into backorder
- Finished soldering components, happy with the results
- Will test functionality tomorrow at team meeting 

### 4/18/2025 Version 2 Testing 
- Soldered an LED array for testing
- desoldered some pins for screen connection
    - Pad from PCB for screen connection came off & trace peeled back
    - tried to soler wire directly to microcontroller pin but connection to screen didnt seem to be working
    - Determined that a new board needed to be soldered
- Began soldering components onto new board
- DC/DC converter is now on backorder so we have to live with the 2 converters we have

### 4/23/2025 More Version 2 Testing 
- Re-soldered the microcontroller
- Retesting peripherals
    - DC/DC conversion --> functional
    - Indicator light --> functional
    - Red LED array --> functional
    - Yellow LED array --> functional
    - Green LED --> functional!!
    - Motor --> functional!!
- Soldered on jumper wires for screen then tested functionality using breadboard demo code
    - functional!!
    - also tests rotary encoder --> functional
- All peripherals are now functional 
- Now we are moving on to testing final code that brings everything together
    - First pass did not work --> having trouble with screen setup
    - changed some user set up pin numbers
    - solution: programmer was not supplying enough current --> switched to power adapter
- Tested bluetooth --> functioning
- Everything is working!!!
- Now all we have is code debugging between the app and the hub

#### R&V Testing for the Power Management Subsystem 
- Adapter & converter voltages were well within acceptable threshold
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/Ver2%20Measurements.png)
- Temperatures were well below safe human touch limit 
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/TemperatureTest.png)
- Oscilloscope showed no concerning voltage variations
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/maddie/O%20scope%20pic%20(1).png)

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
- Wanted to prioritize flexibility in user placement of the hub while also keeping portability in mind
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
    - Kait - bluetooth
    - Jesse - GPIO configurations
    - Maddie - assemble and test PCB
    - All - find headers and specific LED array
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

### 4/1/2025 Team meeting
- Tried to view current spike on oscilloscope --> current probe did not function
- moved on to programming microcontroller
- the microcontroller will program but a werid override issue is stopping us from using some pins
- figuring out why IO and pins don't seem to be matching 

### 4/7/2025 TA Meeting 
- updated TA on overall progress
- She says we are on time, if even a bit ahead of schedule

### 4/8/2025 Team Meeting 
- Kait --> Working on hub password mechanism
- Jesse --> Working on LED array code
- Maddie:
    - Soldered and tested red LED array
    - Researched and ordered new power supply options
        - Found a USB-C to DC cord that matches pcb's barrel jack and can connect to adapter block from pixel phone that provides 5V 3A
        - This may fix the current spike issue and allows for flexibility to try different blocks if the one we try doesn't work
        - Rated higher than required current --> good because then the circuit can draw as much as it needs
     
### 4/14/2025 TA Meeting 
- Tested new power adapter
    - Works!!!
    - determined issue that caused previous to not work: reversed polarity (negative on inside)
    - current spike was not the problem 
- Prepared for prototype casing print
- Confirmed with Aishee that we are on schedule

### 4/22/2025 Team Meeting
- Testing newly soldered version 2 board
- DC/DC conversion --> functional 
- Indicator light --> functional
- Red LED array --> functional
- Yellow LED array --> functional
- Green LED --> not functional
    - suspected short between array and motor signal (close together on microcontroller)
- Will fix microcontroller short later tonight 
