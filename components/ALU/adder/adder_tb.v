//module adder_tb;
    
//    // Creating inputs
//    reg [63:0]a, b;

//    // Creating outputs
//    //reg [63:0]sum;

//    // Instantiate the unit under test
//    sixty_four_bit_adder uut (a, b, sum);

//    // Set parameters
//    parameter COLUMNS = 192, ROWS = 1000, INPUTS = 128;

//    // Declare test_vector and single_vector
//    reg [COLUMNS-1:0] test_vector [0:ROWS-1];
//    reg [COLUMNS-1:0] single_vector;

//    // index and mismatch count
//    integer i, mm_count;

//	initial begin
//		$dumpfile("adder_tb.vcd");
//		$dumpvars();

//		mm_count = 0;	// zero mismatch count

//		// read test_vectors
//		$readmemb("adder_tb.txt", test_vector);
		
//		// need to loop over all of the rows using a for loop
//		for (i=0; i<ROWS; i=i+1) begin
//			// put the vector to test this loop into single_vector
//			single_vector = test_vector [i];
			
//			// now apply the stimuli to from the vector to the input signals
//			a = single_vector[COLUMNS-1:COLUMNS-64];
//			b = single_vector[COLUMNS-65:COLUMNS-128];
			
//			#10;	// wait 10 ns for inputs to settle

//			// compare to expected value
//			if (sum !== single_vector[COLUMNS-INPUTS-1:0]) begin

//				// display mismatch
//				$display("Mismatch--loop index i: %d; input: %b_%b, expected: %b, received: %b",
//					i, a, b, single_vector[COLUMNS-INPUTS-1:0], sum);

//				mm_count = mm_count + 1;	// increment mismatch count

//			end
//			#10;	// add 10 ns for symmetry
//		end	// end of for loop

//		// tell designer we're done with the simulation
//		if (mm_count == 0) begin
//			$display("Simulation complete - no mismatches!!!");
//		end else begin
//			$display("Simulation complete - %d mismatches!!!", mm_count);
//		end
//		$finish;
		
//	end	// end of initial block
//endmodule

`timescale 1ns / 1ps

module adder_tb();

    //inputs
    reg[63:0] a,b;
    reg c_in;
    
    //outputs
    wire[63:0]   sum;
    reg[63:0] expected_val;
    
    //Instantiate 64 bit adder
    sixty_four_bit_adder a1(.a(a), .b(b), .sum(sum), .c_in(c_in));
    
    //changing values every 10ns
    initial
        begin
             // check minimum values 
            #10 a=0; b=0; c_in=0; // no carry for unsigned
            expected_val = a+b+c_in;
            #10 a=3;b=4;c_in=1; //testing smaller numbers
            expected_val = a+b+c_in;
            #10 a=-2147483648 ; b=-2147483648; c_in=1; //min value for signed
            expected_val = a+b+c_in;
            // check max values
            #10 a=2147483648; b=2147483647; c_in=0; // without carry will yield 4294967295
            expected_val = a+b+c_in;
            //test overflow
            #10 a=2147483648; b=2147483647; c_in=1; // with carry will yield overflow 4294967296
            expected_val = a+b+c_in;
            #10 a=-2147483648; b=-2147483648; c_in=0;//signed overflow
            expected_val = a+b+c_in;
            //Testing Signed and Unsigned values
            #10 a=-58654565; b=7777777; c_in=1; //valid input
            expected_val = a+b+c_in;
            #10 a=64'd18446744073709551615; b=0; c_in=1;
            expected_val = a+b+c_in;
            
            #10 $finish;
        end
endmodule

