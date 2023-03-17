# Pong_Game
# Verilog Implementation of Single Player Pong on a Nexys-3 Board

Introduction and Requirement
The purpose of this project is to design and implement a single-player Pong game on a Nexys-3 FPGA development board using Verilog hardware description language. Pong is a classic arcade game in which a player moves a paddle vertically to bounce a ball off walls and prevent it from leaving the screen. The game will be displayed on a VGA monitor, and the player will interact with the game using buttons on the development board.

Design requirements for this project include:
Implement the game on a Nexys-3 FPGA development board
Control the paddle using buttons (BTNU for up, BTND for down) on the development board
Use a VGA monitor to display the game, utilizing the provided red, green, blue, h_sync, and v_sync signals
Gradually increase the game speed over time as controlled by the game_clk module
Paused state where movement will be stopped (controlled by button)
Implement a simple scoring system to track successful paddle hits
Reset the game using a dedicated button (BTNR) on the development board
Restarting the when a player has lost (ball goes past paddle)

Design Description
The single-player Pong game implementation utilizes a modular approach, consisting of the following key modules:

clock_divider.v: Generates a slower clock from the input clock based on the div_value parameter. This module is responsible for providing the main clock for the system and supplying a 25 MHz clock for VGA synchronization.
game_clk.v: Generates a game clock signal that starts at an initial frequency and gradually increases depending on the score of the user. The game_clk module controls the speed of the game and the ball movement meaning both the ball and paddle will move at the same speed.
horizontal_counter.v: Implements a horizontal counter for the VGA display, generating the h_sync signal and an enable signal (v_enable) for the vertical counter. This module will go through every pixel of the current row.
vertical_counter.v: Implements a vertical counter for the VGA display, incrementing when the v_enable signal is high and resetting when it reaches its maximum value (524). This module will increment when the horizontal_counter reaches the end of its current row and will go down to the next row to ensure every pixel on the display is visited. 
top.v: This is our top level module that takes in our other modules as well as implements our logic for the game. This module controls the display (score, ball, paddle) and buttons (pause and movement). The logic for the display works by passing through and changing the colors for every pixel on the screen and then refreshing it to be displayed on the screen. 

The interactions among these modules are as follows:

The clock_divider module supplies the main clock for the system, which is used by the game_clk module to control the game speed.
The game_clk module generates a game clock signal that is utilized by the top-level module (not provided) to control the ball's movement.
The horizontal_counter and vertical_counter modules generate the timing signals required for proper VGA display synchronization. These two modules work together to help go through every individual pixel on the display.
The top-level module integrates all these modules and is responsible for handling the game logic, paddle control, VGA display output, and button inputs for controlling the paddle and resetting the game.
The top-level module connects the outputs of the clock_divider, game_clk, horizontal_counter, and vertical_counter modules to their respective inputs. In addition, it connects the red, green, blue signals to the corresponding pins on the Nexys-3 board as specified in the nexys3.ucf file.

Simulation Documentation 
Simulation efforts include testing the following requirements:

Clock generation and division: Ensuring that the clock_divider and game_clk modules generate the correct output clock signals based on their input parameters.
Horizontal and vertical counter functionality: Verifying that the horizontal_counter and vertical_counter modules generate the correct timing signals for the VGA display, following the VGA synchronization standards.

Test cases include:

Varying the div_value parameter to ensure correct clock division in the clock_divider module and generating the required 25 MHz clock signal.
Verifying the game clock frequency and its gradual increase in the game_clk module, ensuring smooth ball movement and speed increase.
Checking the horizontal and vertical counter signals in the horizontal_counter and vertical_counter modules for correct VGA timing, ensuring proper display output.

During simulation, any identified bugs should be documented, analyzed, and resolved to ensure the correct functioning of the game. Simulation waveforms can be captured using a waveform viewer such as ModelSim or Vivado's integrated simulator, providing visual confirmation of the correct functionality of each module.

Conclusion 
In conclusion, the single-player Pong game has been successfully implemented in Verilog on a Nexys-3 FPGA development board. The modular design approach allowed for efficient development and testing of individual components, such as the clock_divider, game_clk, horizontal_counter, and vertical_counter modules. Interactions among the modules were well defined, and the top-level module was responsible for integrating these components and handling the overall game logic and VGA display output.

Some difficulties encountered during the project included managing the VGA synchronization signals and ensuring smooth paddle control using the development board's buttons. These challenges were overcome through careful design, simulation, and debugging. The display was also difficult to properly implement. The blanking period for both the horizontal and vertical directions were something that were sometimes forgotten about but a simple fix when we found out they were missing in our offset. 


In general, the project was successful, and the implemented single-player Pong game provided a good learning experience in designing and developing FPGA-based systems using Verilog. To further improve the project, additional features such as multi-player support, sound effects, or more advanced scoring mechanisms could be considered for future implementations.
