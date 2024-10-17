// Module Declaration
module t1b_cd_fd (
    input  clk_1MHz, cs_out,
    output reg [1:0] filter, color,
    output reg [15:0] pulse_counter,   // Output pulse_counter for waveform analysis
    output reg enable_counter,         // Output enable_counter for waveform analysis
    output reg [1:0] state_prev,       // Output state_prev for waveform analysis
    output reg [9:0] timer_500us,       // Output timer_500us for waveform analysis
	 output reg prev_enable_counter,
	 output reg [15:0] red_freq,        // Output red frequency for waveform analysis
    output reg [15:0] green_freq,      // Output green frequency for waveform analysis
    output reg [15:0] blue_freq        // Output blue frequency for waveform analysis
);

// red   -> color = 1;
// green -> color = 2;
// blue  -> color = 3;

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////

// Filter codes (based on S2 and S3)
parameter F_3   = 2'b11;  // Filter 3 green
parameter F_0   = 2'b00;  // Filter 0 red
parameter F_1   = 2'b01;  // Filter 1 blue
parameter F_2   = 2'b10;  // Filter 2 clear

// FSM state register
reg [1:0] state;



initial begin
    // Initial states
    filter = F_3;      // Start with filter 3
    color = 0;     // No color detected initially
    timer_500us = 0;  // Initialize 500 µs timer
    state = F_3;       // Set initial state to filter 3
	 pulse_counter = 0;
	 red_freq = 0; green_freq = 0; blue_freq = 0;
	 enable_counter = 1;  // Enable counting
	 state_prev = F_3;    // Initialize state_prev
	 prev_enable_counter = 1;
end

// Always block for FSM and timing logic
always @(posedge clk_1MHz) begin

	// Check the current state
    if ((state == F_2 && timer_500us == 1) || (state != 2 && timer_500us == 500)) begin
	 
                case (state)
                    F_3: begin
						  // Green Filter: Store frequency and move to Red Filter (0)
								green_freq <= pulse_counter;
								
                        filter <= F_0;   // Apply filter 0
                        state <= F_0;    // Move to next filter (0)
							end
						  
						  
                    F_0: begin
						  // Red Filter: Store frequency and move to Blue Filter (1)
							red_freq <= pulse_counter;	
							
                        filter <= F_1;   // Apply filter 1
                        state <= F_1;    // Move to next filter (1)
                    end
						  
						  
                   F_1: begin
								 // Blue Filter: Store frequency, then perform color detection
								 blue_freq <= pulse_counter;  // Update blue_freq with the current pulse_counter value
								 
								 // Perform color detection after Blue Filter
								 if (pulse_counter >= red_freq && pulse_counter >= green_freq) begin
									  color <= 3;  // Blue
								 end else if (red_freq >= pulse_counter && red_freq >= green_freq) begin
									  color <= 1;  // Red
								 end else if (green_freq >= red_freq && green_freq >= pulse_counter) begin
									  color <= 2;  // Green
								 end else begin
									  color <= 0;  // Default/Unknown (including the case where all frequencies are equal)
								 end
								 
								 filter <= F_2;   // Apply filter 2
								 state <= F_2;    // Move to next filter (2)    
							end
						  
						  
						  F_2: begin
						  //clear filter: for 1us 
								filter <= F_3;   // Apply filter 3
								state <= F_3;		//move to next state filter(3)
								
									
							end
                endcase
					 
					 timer_500us <= 1; // Reset timer for the next filter
		end
					
				else begin
					timer_500us <= timer_500us + 1;
					end
					 
            end
				
	// Always block to detect state change and switch enable_counter
always @(state) begin			
        enable_counter <= ~enable_counter;   // Disable counting when state changes

end

// Always block for counting pulses and resetting pulse_counter
always @(posedge cs_out) begin
        
    if (enable_counter != prev_enable_counter) begin
	 		  prev_enable_counter <= enable_counter;
	
        pulse_counter <= 0;  // Reset pulse counter when enable_counter is switched
    end else begin
	 pulse_counter <= pulse_counter + 1;  // Increment pulse counter when enabled
	 end
end



//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule