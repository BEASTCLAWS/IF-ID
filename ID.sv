module ID(
    input logic clk, reset, reg_write,
    input logic [4:0] rs1_sel, rs2_sel, rd_sel,
    input logic [31:0] wb_data,
    output logic [31:0] rs1_data, rs2_data
);

    logic [31:0] reg_file [0:31];
    integer i;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                reg_file[i] <= 32'b0;
        end
        else if (reg_write && rd_sel != 0) begin
            reg_file[rd_sel] <= wb_data;
        end
    end

    always_comb begin
        rs1_data = (rs1_sel == 0) ? 32'b0 : reg_file[rs1_sel];
        rs2_data = (rs2_sel == 0) ? 32'b0 : reg_file[rs2_sel];
    end

endmodule
