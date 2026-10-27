module ID_tb;

    logic clk, reset, reg_write;
    logic [4:0] rs1_sel, rs2_sel, rd_sel;
    logic [31:0] wb_data, rs1_data, rs2_data;

    ID uut (.*);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        reg_write = 0;
        rs1_sel = 0;
        rs2_sel = 0;
        rd_sel = 0;
        wb_data = 0;

        #10 reset = 0;

        // Write 100 to x1
        @(negedge clk);
        reg_write = 1;
        rd_sel = 1;
        wb_data = 100;

        // Write 200 to x2
        @(negedge clk);
        rd_sel = 2;
        wb_data = 200;

        // Read x1 and x2
        @(negedge clk);
        reg_write = 0;
        rs1_sel = 1;
        rs2_sel = 2;

        #1;
        $display("x1 = %0d, x2 = %0d", rs1_data, rs2_data);

        $finish;
    end

endmodule
