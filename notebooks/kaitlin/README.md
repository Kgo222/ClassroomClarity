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
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/app%20Design%20flow.jpg)

## 2/28/2025: Circuit Design
### Research:
#### 1) Screen
- Can use 3.3V --> might impact the brightness
- Reviews on product say that if using it with a 3.3V microcontroller, you should also power screen with 3.3V otherwise need to consider a level shifter to do voltage differences
- Level Shifter: microcontroller connected to low side and Screen to high side
#### 2) ESP 32
- Can provide up to 20mA of current per GPIO --> If want to run something >20mA need to consider different power method
#### 3) Software vs Hardware pullup resistor
Software Pros: less components, easier to implement
Software Cons: Less noise immunity, weaker pullup 
Good with things that don't require very specific signals (Ex. buttons)
Hardware Pros: stronger pullup, less voltage drop
Hardware Cons: more components, more space, harder to implement
Good with things that need specific signals (ex. rotary encorder)
#### 4) Software vs Hardware debouncer
Software Pros: Easier to implement, less components
Software Cons: MCU has to continuously check for interrupts
Hardware Pros: more reliable
Hardware Cons: more components, more space on PCB
### Design Rough Drafts:
*Note: GPIO numbers don't correlate to the actual ESP 32 connections, they are just used for differentiation between connections
#### Rotary Encoder
- When contact is open = need pull ups (pink) to ensure GPIO reads HIGH
- When contact is closed = need pull down to ensure GPIO reads LOW
- Added capacitors for debounce
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/Rotary_draft1.jpg)
#### Push Button
- When pressed = GPIO LOW
- When pressed = GPIO HIGH
- Debounce can be done in software or add a cap between button and GND
#### Screen
- Don't need to hook up the touch screen or SD since we aren't using those
- Screen can run on 3.3V/5V --> run on 3.3V because microcontroller is 3.3V = signal consistency 
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/Screen_draft1.jpg)
#### Vibration Motor
- Requires more tham 20mA of current, so must pull directly from 3.3V, 1.5A source.
- Use a MOSFET to control the signal and motor interaction: GPIO connects to gate so that when GPIO HIGH, FET closes and motor runs.
- Need to add a flyback diode to protect MOSFET from the motors sudden start and stops (potential voltage spikes)
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/Motor_draft1.jpg)
#### LEDs
##### 1) Single LED for question notification:
- Could add a current limiting resistor between the GPIO and LED, however that might limit current too much
- LED needs 20mA to run at optimal conditions, and the peak current is 30mA. The GPIO only gives 20mA and any current spikes will likely be less than peak current
- LED has forward voltage of ~3.3V, so we need the full 3.3V from microcontroller for LED to work, so best to leave resistor off
  ![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/LEDsingle_draft1.jpg)
##### 2) LED array for engagement rating display (x3):
- Each individual LED array needs ~10mA to run at optimal conditions. We can run 2 LED in parellel with 1 GPIO.
- LED peak current is 30mA so we don't need to current limiting resistor
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/LEDarray_draft1.jpg)
### Full Design Draft
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/DesignRefs/fullCircuit_draft1.jpg)

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
![Image](https://github.com/Kgo222/ClassroomClarity/blob/main/notebooks/kaitlin/ComponentList.png)
### For next meeting:
1. Jesse →  control & physical casing, Look into what programmer we need for the microcontroller
2. Kait → App and coding + Work on Schedule for Design Document
3. Maddie → Power and PCB (Idea for power PCB design) 

## 2/25/2025 Team Meeting
### Important Decisions:
- Swapped to a ESP32-S3-WROOM-1-N16: Has the correct amount of GPIO and SPI functionally pins for what we need + it is in the Electronic Services Shop
