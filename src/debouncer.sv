//-----------------------------------------------------
// File Name   : debouncer.sv
// Function    : Switch input debouncer for readyIn signal
// Clock syncronises input and debounces it (16 cycle hold time)
// Version: 1
// Author:  wf2g20
// Last rev. 1 Apr. 24
//-----------------------------------------------------
`ifndef DEBOUNCER_SV
`define DEBOUNCER_SV

module sync (
    input logic clk, nReset, in,
    output logic out
);
    reg sync1, sync2;

    always @(posedge clk or negedge nReset) begin
        if (!nReset) begin
            sync1 <= 1'b0;
            sync2 <= 1'b0;
        end else begin
            sync1 <= in;
            sync2 <= sync1;
        end
    end

    assign out = sync2;

endmodule

// size sets the number of cycles to debounce for (4 -> 16 cycles)
module debounce #(parameter size = 4) (
    input logic clk, nReset, in,
    output reg debounced
);

    reg [size-1:0] counter;
    reg last_in;

    always @(posedge clk or negedge nReset) begin
        if (!nReset) begin
            counter <= 0;
            last_in <= 1'b0;
        end else begin
            if (in == last_in) begin
                if (counter != {size{1'b1}}) begin
                    counter <= counter + 1'b1;
                end
            end else begin
                counter <= 0;
            end
            last_in <= in;
        end
    end

    assign debounced = (counter == {size{1'b1}}) ? last_in : 1'b0;

endmodule

module debouncer (
    input logic clk, nReset, in,
    output logic out
);

    wire sync_out;
    sync u_sync (
        .clk(clk),
        .nReset(nReset),
        .in(in),
        .out(sync_out)
    );

    debounce u_debounce (
        .clk(clk),
        .nReset(nReset),
        .in(sync_out),
        .debounced(out)
    );

endmodule

`endif