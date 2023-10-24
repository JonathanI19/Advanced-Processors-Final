module adder_tb;

    // Creating inputs
    logic [63:0]a, b;

    // Creating outputs
    logic [63:0]sum;

    // Instantiate the unit under test
    sixty_four_bit_adder uut (.*);

    // Set parameters
    parameter COLUMNS = 192, ROWS = 1000, INPUTS = 128;

    // Declare test_vector and single_vector
    logic [COLUMNS-1:0] test_vector [0:ROWS-1];
    logic [COLUMNS-1:0] single_vector;

    // index and mismatch count
    integer i, mm_count;

	initial begin
		$dumpfile("adder_tb.vcd");
		$dumpvars();

		mm_count = 0;	// zero mismatch count

		// read test_vectors
		$readmemb("adder_tb.txt", test_vector);
		
		// need to loop over all of the rows using a for loop
		for (i=0; i<ROWS; i=i+1) begin
			// put the vector to test this loop into single_vector
			single_vector = test_vector [i];
			
			// now apply the stimuli to from the vector to the input signals
			{c_in, a, b} = single_vector[COLUMNS-1:COLUMNS-INPUTS];
			#10;	// wait 10 ns for inputs to settle

			// compare to expected value
			if (sum !== single_vector[COLUMNS-INPUTS-1:0]) begin

				// display mismatch
				$display("Mismatch--loop index i: %d; input: %b_%b_%b, expected: %b, received: %b",
					i, c_in, a, b, single_vector[COLUMNS-INPUTS-1:0], sum);

				mm_count = mm_count + 1;	// increment mismatch count

			end
			#10;	// add 10 ns for symmetry
		end	// end of for loop

		// tell designer we're done with the simulation
		if (mm_count == 0) begin
			$display("Simulation complete - no mismatches!!!");
		end else begin
			$display("Simulation complete - %d mismatches!!!", mm_count);
		end
		$finish;
		
	end	// end of initial block
endmodule




