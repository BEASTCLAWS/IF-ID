module IF_tb;

    logic clk, reset, stall, and_out;
    logic [31:0] pc_signed_offset, address, pc_new;

    IF uut (.*);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        stall = 0;
        and_out = 0;
        pc_signed_offset = 0;

        #10 reset = 0;

        #10;
        $display("PC = %h, PC+4 = %h", address, pc_new);

        // Normal PC increment
        #10;
        $display("PC = %h", address);

        // Branch
        and_out = 1;
        pc_signed_offset = 32'h8000_0010;

        #10;
        and_out = 0;
        $display("Branch PC = %h", address);

        // Stall
        stall = 1;

        #10;
        $display("Stalled PC = %h", address);

        $finish;
    end

endmodule
