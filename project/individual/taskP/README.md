# EE2026 – Individual Basic Task P

**Done by:** Joshua Yeo

---

## Task Description

### 🔹 Initial Display
- A **solid white circle** (radius = 8 pixels) shown at the **top-left corner** of the OLED.  
- The **2nd rightmost digit** is displayed on the **left side** of the OLED in **red**.  
- The **1st rightmost digit** is displayed on the **right side** of the OLED in **green**.  

### 🔹 Operation
- **Left Button (`btnL`)**  
  - Circle turns magenta (if button press held), else white
  - First press → the left digit disappears.  
  - Second press → the left digit reappears in **red**.  
  - This behavior toggles infinitely on each press.  


- **Right Button (`btnR`)**  
  - Circle turns magenta (if button press held), else white
  - First press → the right digit disappears.  
  - Second press → the right digit reappears in **green**.  
  - This behavior toggles infinitely on each press.  

### 🔹 Note
- **200 ms counter** implemented for each pushbutton to address signal debouncing
- Each button press is counted **only once**, even if held longer than 200 ms.  

---

## Summary of Functionality
- Circle: **always displayed**.  
- Digits: **toggle on/off** with button presses.   