#Kaitlin Notebook:
#_Table of Contents:_
1. [Worklog](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#kaitlin-worklog)
   - [2/17/2025: App Design](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#2172025-app-design)
   - [2/28/2025: Circuit Design](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#2282025-circuit-design)
   - [3/8/2025: Breadboard Demo](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#382025-breadboard-demo)
   - [3/25/2025: Bluetooth Dev](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#3252025-bluetooth-dev)
   - [3/28/2025: Bluetooth Dev Cont.](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#3282025-bluetooth-dev-cont)
   - [3/31/2025: Bluetooth Dev Cont.](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#3312025-bluetooth-dev-cont)
   - [4/1/2025: Bluetooth Dev Cont.](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#412025-bluetooth-dev-cont)
   - [4/7/2025: Password Implementation](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#472025-password-implementation)
   - [4/8/2025: Password Implementation Cont.](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#482025-password-implementation-cont)
   - [4/9/2025: Password Implementation Cont.](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#492025-password-implementation-cont)
   - [4/13/2025: Bluetooth and Microcontroller Controls Merge](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#4132025-bluetooth-and-microcontroller-merge)
   - [4/21/2025: Bluetooth and Microcontroller Controls Merge](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#4212025-mock-demo)
   - [4/25/2025: Fix Final Bugs](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#4252025-fixing-the-final-bugs)
2.  [R/V Mobile App](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#requirement-and-verification-for-mobile-app-subsystem)
3. [Team Meeting Notes](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#team-meeting-notes)
   - [R/Vs for Control, Power, and Feedback Subcircuits](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#4252025-team-meeting-requirement-and-verification-testing-for-control-power-and-feedback-circuits)
5. [Team Meeting Notes](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/Notebook.md#team-meeting-notes)
# Kaitlin Worklog
## 2/17/2025: App Design
Features we want to include in the app design:
- scaled rating where students can input what level of understanding they have of the current topic
- A way to submit text questions (anonymously and non-anonymously)
- A way for students to indicate they are raising their hand for a question
- A password students must input to be accepted to hub connection
- Bluetooth connect to hub
- Teacher side of app that allows them to choose hub settings
### Implementation ideas
1)  submit text questions (anonymously and non-anonymously)
   - Have a drop down where they can choose anonymous or non-anonymous
2) Teacher side:
  - when first enter app, have a screen to select "sign in as student" or "sign in as teacher"
  - "sign in as student" will ask them to input name and then password to the hub they select
  - "sign in as teacher" will ask them to input a password for teacher specifically
  - Features on hub teacher could change: font size, allow anonymous questions or not
### Visual Aid of Student Only App - didn't add Teacher side yet
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/app%20Design%20flow.jpg)

## 2/28/2025: Circuit Design
### Research:
#### 1) Screen
- Can use 3.3V --> might impact the brightness
- Reviews on product say that if using it with a 3.3V microcontroller, you should also power screen with 3.3V otherwise need to consider a level shifter to do voltage differences
- Level Shifter: microcontroller connected to low side and Screen to high side
#### 2) ESP 32
- Can provide up to 20mA of current per GPIO --> If want to run something >20mA need to consider different power method
#### 3) Software vs Hardware pullup resistor
- Software Pros: less components, easier to implement  
- Software Cons: Less noise immunity, weaker pullup  
Good with things that don't require very specific signals (Ex. buttons)  
- Hardware Pros: stronger pullup, less voltage drop  
- Hardware Cons: more components, more space, harder to implement  
Good with things that need specific signals (ex. rotary encorder)  
#### 4) Software vs Hardware debouncer
- Software Pros: Easier to implement, less components  
- Software Cons: MCU has to continuously check for interrupts  
- Hardware Pros: more reliable  
- Hardware Cons: more components, more space on PCB  
#### 5) Current Measurements
Based off of current measurements:  
Microcontroller + rotary encoder + motor + Screen $= 800mA + 1mA + 80mA + 50mA = 931 mA$ --> 1.5A source works
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/current%20measures.png)

### Design Rough Drafts:
*Note: GPIO numbers don't correlate to the actual ESP 32 connections, they are just used for differentiation between connections
#### Rotary Encoder
- When contact is open = need pull ups (pink) to ensure GPIO reads HIGH
- When contact is closed = need pull down to ensure GPIO reads LOW
- Added capacitors for debounce

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/Rotary_draft1.jpg"
   alt="Rotary Encoder Circuit Plan" width="300" height="200">,
#### Push Button
- When pressed = GPIO LOW
- When pressed = GPIO HIGH
- Debounce can be done in software or add a cap between button and GND
#### Screen
- Don't need to hook up the touch screen or SD since we aren't using those
- Screen can run on 3.3V/5V --> run on 3.3V because microcontroller is 3.3V = signal consistency

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/Screen_draft1.jpg"
   alt="Screen Circuit Plan" width="300" height="200">,
  
#### Vibration Motor
- Requires more tham 20mA of current, so must pull directly from 3.3V, 1.5A source.
- Use a MOSFET to control the signal and motor interaction: GPIO connects to gate so that when GPIO HIGH, FET closes and motor runs.
- Need to add a flyback diode to protect MOSFET from the motors sudden start and stops (potential voltage spikes)

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/Motor_draft1.jpg"
   alt="Vibration Motor Circuit Plan" width="300" height="200">,
  
#### LEDs
##### 1) Single LED for question notification:
- Could add a current limiting resistor between the GPIO and LED, however that might limit current too much
- LED needs 20mA to run at optimal conditions, and the peak current is 30mA. The GPIO only gives 20mA and any current spikes will likely be less than peak current
- LED has forward voltage of ~3.3V, so we need the full 3.3V from microcontroller for LED to work, so best to leave resistor off

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/LEDsingle_draft1.jpg"
   alt="Single LED (Notification LED) Circuit Plan" width="300" height="200">,

##### 2) LED array for engagement rating display (x3):
- Each individual LED array needs ~10mA to run at optimal conditions. We can run 2 LED in parellel with 1 GPIO.
- LED peak current is 30mA so we don't need to current limiting resistor

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/LEDarray_draft1.jpg"
   alt="LED arrays Circuit Plan" width="300" height="200">,

### Full Design Draft
<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/fullCircuit_draft1.jpg"
   alt="Full Circuit Plan" width="900" height="500">,

## 3/8/2025: Breadboard Demo
- Goals: Get screen to display questions, have rotary encoder flip through questions on the screen, have button clear the question on the screen, and an LED indicate if there are still questions in queue
- Screen: Use TFT library in Arduino, had to edit the library file to work with specific screen type and pin assignments, but worked after that
- Rotary Encoder: having trouble with bi-directionly switching. It can decrease just fine but trying to increase position has a bug that it increases the immediately decreases so it looks like there is no change. Since the actual position doesn't matter, I added some logic in the code to filter this so rotary encoder works as intended

## 3/25/2025: Bluetooth Dev
- USE BLE not classic Bluetooth
- Currently testing with flutter_blue_plus --> loads onto the app without errors, but doesn't currently pick up on ESP32 BLE
- ESP32 is setup with Arduino to service BLE and it is confirmed to be working via a Bluetooth scanner which can pick it up and connect to it, therefore the connection problem likely lies in the flutter_blue_plus application

## 3/28/2025: Bluetooth Dev Cont.
- Confirmed through Serial monitor print outs that the ESP32 Dev board is correctly connecting and disconnecting from app when prompted by the app
- Through Android Studio terminal, it looks like the question data is sending however on the Arduino side, the serial monitor isn't indicating any recieved data

To do:
1. Debug sending/recieving data: likely because of flutter side bluetooth_handler write method --> check UUIDs match correctly
2. Debug the back arrow problem on the starting login screen: when user signs out a back arrow appears on login screen that goes back to homepage (not intended functionality)
3. Try sending the engagement level rating data through bluetooth

## 3/31/2025: Bluetooth Dev Cont.
- Added the connecting and disconnecting functionality to the instructor login on the app. The button works at intended and the BLE connects quickly
- Updated the LED buttons to be on a scale of 1-5 instead of 1-10. This allows for easier understanding on the student's part to quickly decide which relates to how they are following the lesson. It also allows for the responses to better show on the LEDs since we have 15 LEDs and 15 is easily divided by 5.
- Decided that instead of just sending the new engagement level when a student selects a button, I will also send the previously selected level in order to make the math easier. Since the LEDs rely on the avg. we will need to track the sum of engagement levels therefore having the previous selected level sent from the app will allow up to do sum = sum-previous+current. This means the app will be responsible to remembering the previous data and not the microcontroller. This choice was also made because the app's device has more memory capability than the microcontroller so we want to maximize the microcontroller space available.
- I solved the back arrow problem by removing the automatic back arrow and replacing it with a back button. This allows me to control where the back button takes the user and what happens when they press it including disconnecting from the BLE.

To do:
1. Debug sending/recieving data: the UUIDs do match so not the problem. Recheck the bluetoothWrite function in the app code and check if the correct services are setup for ESP

## 4/1/2025: Bluetooth Dev Cont.
- The question and rating data sent correctly over bluetooth! The problem was that I was trying to do a no response write mode, but the ESP was setup with normal write mode property so it never passed the if statement checking for writing capabilities.
- I also added 3 different bluetoothWrite functions, one for each of the UUIDs: engagment level, question, and settings. The settings was just added on the instuctor side of the app to adjust font size and to turn ON/OFF silent mode

## 4/7/2025: Password Implementation
- Goal: Implement 2 separate student and instructor passwords that allow access to those sides of the app
- I added 2 new GPIOs: PI and PS so it is obvious whether the student password or instructor password was sent from the app to the ESP
- Originally thought I could do all the password logic within the ESP, however realized I need to have ESP --> app communication in order to tell the user if the password worked or not.The other option is to force a diconnect from BLE if the password is wrong and then just continuously update the UI state, however that would likely be unstable and not very user friendly since getting the password wrong once would make you have to restart the connection process
- I can recieve a password sent from the app and print out on the Ardunino Serial monitor if it is correct or not, but i can't get the ESP to tell the app if it was correct or not

To do:
1. Debug the ESP--> app communication. I have notify functionality turned on for PI and PS and have then notify the app once the ESP logic decides whether the accept or deny the password. From print statements I can tell the notify function is being called, but it is just not being recieved. Check the subscribeNotification function in the app
2. Note: When I send a password to the ESP, it returns with a copy of what it recieved but from the question or rating UUIDs.l So maybe the subscribeNotification isn't the problem but how I am setting up the UUID characteristics

## 4/8/2025: Password Implementation Cont.
- The ESP --> App communication works!
- The problem was in the UUID characteristic setup. It seemed like there were too many notify UUIDs to listen for that the app couldn't process the responses fast enough, therefore I removed the notification characteristic from all the UUIDs I didn't need it for (question, engagement level, settings, password) and kept it only on the esp UUID that i added to handle ESP --> App communication. I also removed the BLE209 desciption from the other UUIDS since it is only necessary for notification and would help limit any potential confusion.

To Do:
1. Debug the password: I can successfully recieve on the app whether the submitted password was right or wrong, but it will not update the UI to accomidate for the change in password status. I want it to change the "incorrect password" or "correct, please press continue to enter the hub" depending on the response. Check the setStatus() call to see why it might not be working.

## 4/9/2025: Password Implementation Cont.
- UI update now works!
- The Problem was the setState() was being called in subscribeNotifications since that is where the studentAuthenticated and instructorAuthenticated variables change depending on the password. This, however, doesn't call the correct setState() that is associated with the login screen. The necessary setState() is the once associated with the instuctorLogin page or the studentLogin page depending on which password input the user it at. Therefore, I added a small delay from when the submit button is pressed to when the setState() is called in order to allow the BLE time to respond to the submitted password.
- App basic functionality is completed. Anything else add will be extra for this project's scope.

## 4/13/2025: Bluetooth and microcontroller merge
- I added the bluetooth communication I developed for ESP--> App to the code that also has the various input and output logic of the components.
- The passwords should now be displayed at the top left of the screen along with the questions that are displayed in the center so that the professor can easily read the passwords.

To do:
1. Try uploading the code to the Dev board and see if the screen is formatted correctly. Check at different font size selection as well
2. Try upload the code the the PCB microcontroller.

## 4/21/2025: Mock Demo
- Want to showcase the bluetooth + screen + notif LED + clear button
- Debug: When I tried to load the code the ESP dev board kept resetting itself and giving an error message that indicated the ESP couldn't finish setup() or loop(). Upon further inspect I realized that in the setup() I was trying to assign pins that didn't exsist on the dev board and once I commented out that, it works!

## 4/25/2025: Fixing the final bugs 
- When testing the final project, we noticed certain senarios that when done caused a problem:
1. When the student logs out and logs back in, the LED arrrays never light up again: this was caused by a problem in the math were when the student logged out the LED math would get the ratingSum to 0 and then the math wouldn't work anymore. I fixed this by changing how the app handles a signout where instead of senting a current rating of 0 and the last rating to remove the student from the total sum, now it sends a current rating of 5 and the last rating so the microcontroller is reset to full LEDs.
2. If a student sends more that 200 character, there would be overflow on the screen. Therefore I added a character limit to the text field.

## Requirement and Verification for Mobile App Subsystem:
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/RV_data/RV_mobileApp.png)
### Requirement 1 Verification:
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/RV_data/TImingTable.png)

### Requirement 2 Verification:
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/RV_data/DataAccuracy.png)

### Requirement 3 Verified with qualitative testing:
- For LED functionality watch "LEDadjust.MOV"
- For Type Question functionality watch "TypeQuestion.MOV"
- For Raise Hand Button functionality watch "RaiseHand.MOV"

## Requirement 4 
- Couldn't be verified due to lack of access to a second phone that could accept the code (no Mac for Xcode to upload to iPhone and no extra Android phone) 

# Team Meeting Notes
## 2/12/2025 Team Meeting
- Worked on proposal and team contract
- Discussed the basic plan for division of work and areas people feel most comfortable executing 
### To Do
1. Pick OLED screen --> will determine if need another voltage regulator + battery size
2. Team Contract

## 2/18/2025 Team Meeting
### What we did in the meeting: 
1. Divided up tasks
2. Finalized Component Choice + got links for any we need to order
4. Got rough estimate of minimum budget

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/ComponentList.png"
   alt="Budget Estimate" width="900" height="600">,

### For next meeting:
1. Jesse →  control & physical casing, Look into what programmer we need for the microcontroller
2. Kait → App and coding + Work on Schedule for Design Document
3. Maddie → Power and PCB (Idea for power PCB design) 

## 2/25/2025 Team Meeting
### Important Decisions:
- Swapped to a ESP32-S3-WROOM-1-N16: Has the correct amount of GPIO and SPI functionally pins for what we need + it is in the Electronic Services Shop

## 4/22/2025 Team Meeting:
Fixes
- Motor, Clear btn, and Green LED pins of microcontroller likely shorted under the pin because they all turn on = need to resolder
- Lid PCB holes are 10 mm too close together

## 4/25/2025 Team Meeting: Requirement and Verification testing for Control, Power, and Feedback Circuits
Yellow = Rot A, Green = Rot B
Clockwise:

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/RV_data/Clockwise.jpg"
   alt="Budget Estimate" width="500" height="300">,

CounterClockwise:

<img src="https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/RV_data/CounterClockwise.jpg"
   alt="Budget Estimate" width="500" height="300">,

Control, Feedback, and Power Measured Values:
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/RV_data/control_power_feedback_RV.png) 

# Final Design Information
## Physical Design
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/finalResults/HubPicture.png)

## Internal Subcircuits
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/finalResults/final_BlockDiagram.png)

## Microcontroller Control Flowchart
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/finalResults/ControlsFlowchart_ESP.png)

## Mobile App Flowchart
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/finalResults/MobileAppFlow.png)

## App Layout
### Student
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/finalResults/StudentAppLayout.png)

### Instructor
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/finalResults/InstructorAppLayout.png)


