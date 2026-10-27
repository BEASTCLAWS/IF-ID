module IF(
    input logic clk, reset, stall, and_out,
    input logic [31:0] pc_signed_offset,
    output logic [31:0] address, pc_new
);

    logic [31:0] pc_next;

    assign pc_new = address + 32'd4;

    always_comb begin
        if (and_out)
            pc_next = pc_signed_offset;
        else
            pc_next = pc_new;
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            address <= 32'h8000_0000;
        else if (!stall)
            address <= pc_next;
    end

endmodule
