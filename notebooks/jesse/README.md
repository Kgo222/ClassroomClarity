# Jesse Worklog
## 2/19/2025
- Chose USB-to-UART programmer and VS Code editor
## 2/22/2025
- Began assigning pins for system functionality
## 2/26/2025
- Assigned pins for system functionality for new chip (ESP32-S3-WROOM-1)
- Introduced debouncer circuits for programming buttons and rotary encoder
## 3/5/2025 - 3/6/2025
- Worked on design document
## 3/8/2025
- Worked on breadboard demo
- Tested rotary encoder circuit
- Assisted in debugging SPI communication with the LCD
## 3/23/2025 
- Created list of all signals
- Specified necessary GPIO configurations for each signal
## 3/31/2025
- Determined procedure for processing class understanding data for LED arrays
## 4/1/2025
- Began testing microcontroller on PCB V1
  - Communicated with the chip using the programmer successfully
  - Failed running the Breadboard Demo code
- Issue: can't drive GPIOs
## 4/5/2025
- Resolved GPIO driving
  - Cause: microcontroller was not taken out of programming mode
  - Solution: press the enable button after code is done uploading
- Continued testing microcontroller on PCB V1
  - Used a blink program to confirm ability to drive GPIO outputs
    - Tested GPIO3: indicator LED  
  - Used a new program to confirm ability to read GPIO inputs
    - Tested GPIO6: clear button
 - Issue: Screen will not display, disables GPIOs when Breadboard Demo code is attempted
## 4/7/2025
- Resolved screen display and GPIO disabling
  - Cause: apparent continuous screen reset bug in Espressif Arduino firmware
  - Solution: #define USE_HSPI_PORT   in User_Setup.h
- Recorded measurements of GPIO voltages
  - LED indicator on and off voltages
  - Clear button pressed and unpressed voltages
## 4/9/2025
- Reworked the process to light the LED arrays
  - Want to light the arrays as a unit, like a progress bar
## 4/12/2025
- Completed initial 3D model for hub housing prototype
## 4/15/2025
- Began adjustments on the 3D model for device housing
## 4/18/2025
- Continued adjustments on the main body 3D model for device housing
- Completed initial 3D model for device housing lid
## 4/22/2025
- Made adjustments on the lid and main body 3D models for device housing
  - Added vents on the main body
- Made test program to test feedback peripherals
## 4/23/2025
- Tested peripherals after resoldering chip
  - LEDs, rotary encoder, clear button, vibe motor, and screen worked without Bluetooth
- Began 3D printing main body version 3 after printer ran out of filament
## 4/25/2025
- Took measurements to ensure requirements were being met
- Conducted full test through the system to ensure everything worked
- Began and finished assembly of the full hub
## 4/28/2025
- Final demo
## 4/30/2025
- Worked on presentation for mock presentation
## 5/2/2025
- Mock presentation
## 5/5/2025
- Final presentation
## 5/6/2025
- Worked on final report
## 5/7/2025
- Finished final report

# Team Meetings
## Team Meeting 2/12/2025
- Worked on team contract and proposal
- Created Google Sheets file for organizing, planning, and tracking the status of project task items
- Took meeting notes and noted topics/tasks for next week via Google Docs
## Team Meeting 2/18/2025
- Updated team on my plan for the week via group chat
## Team Meeting 2/25/2025
- Visited supply shop to determine what parts need ordered
- Chose new microcontroller because of the number of GPIO pins on the ESP32-PICO-V3
  - ESP32-S3-WROOM-1
## Team Meeting 3/4/2025
- Discussed physical design of the hub
## Team Meeting 3/11/2025
- Set tasks to be achieved over spring break
  - I will be determining the GPIO configurations
## Team Meeting 3/25/2025
- Mobile application working
- GPIO configuration list completed
- Next task: map class understanding level to LED lighting
## Team Meetings 4/1/2025 & 4/8/2025
- Tested custom PCB board version 1
## Team Meeting 4/15/2025
- Tested custom PCB board version 2
  - Found +3V short
- Tested component fit in the housing
  - Most components need slight adjustments
## Team Meeting 4/22/2025
- Tested custom PCB board version 2
  - Found and fixed short between GPIO pins
- Test fit components in the housing version 2
  - Adjustments needed on lid for PCB mounting
  - Slight adjustment needed on main body charging hole for PCB
## Team Meeting 4/30/2025
- Worked on project presentation
## Team Meeting 5/1/2025
- Practice run of presentation for mock presentation
