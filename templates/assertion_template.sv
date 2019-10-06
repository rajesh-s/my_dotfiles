`timescale 1ns/1ps
module module_name();

/* Wire taps from design */
wire a    = instace_top.sub_module_top.signal;

/* Other declarations used within the checker module */
int limit_count = 0;
bit chk_stop = 1'b0;
bit chk_start = 1'b1;
logic en ;  // Enable switch for assertion

/* Procedural statements are supported */
always @(posedge clock)
begin
  if(chk_start == 1'b1)
  begin
    if(limit_count > 10000)
      begin
        chk_stop=1; chk_start=0;
      end
    else
      limit_count = limit_count+1;
  end
end

initial
begin
    en = <source> ; // Source of enable for checker. Usually passed from cmdline or env specific options
end


// Concurrent Assertion that uses assume property
property property1;
  real clk_curr; // Sample format
  disable iff(chk_stop || ~en || limit_count < 'd3 ) // Disable conditions
    (1,clk_curr = $realtime) |=> ((($realtime-clk_curr)*1000>(<time_period_ns>)) && (($realtime-clk_curr)*1000<(<time_period_ns>))); // Perioid checking assertion 
endproperty: property1

PROPERTY1_LABEL: assert property(@(posedge clock) property1) 
               else
               `notifier("Error Message","Error category",`DEFAULT_ERROR_LEVEL)

// Cover Property Example
cover_property_label : cover property (property1) ;

// Example of immediate assertion in a procedural block
always
    begin
        if (en)
            assert( a && b)
            else
                `notifier("Error Message","Error category",`DEFAULT_ERROR_LEVEL)
    end

endmodule
