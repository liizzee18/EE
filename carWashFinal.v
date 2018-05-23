`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Company: UTEP
// Engineer: Elizabeth Barragan, Sergio Munoz
//
// Create Date:    10:21:56 11/2282017
// Module Name:    FinalProject
// Project Name:  carWashFinal
// Description: Car wash state machine
// Dependencies: carWash.ucf
//
// Revision 1.01 - Final Version
// Additional Comments: A simple state machine that utilizes an external clock
//                      signal to change to different states.
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module carWashFinal(clk,coin,reset_program,basic_program,extra_cleaning_program,platinum_program,Lssd,Rssd
);

//Declare I/O 
input clk,coin,reset_program,basic_program,extra_cleaning_program,platinum_program;
output reg [6:0] Rssd, Lssd;
reg [3:0] state;

//Declare States as 4 bits
parameter S0=4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,
    S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,
    S8=4'b1000,S9=4'b1001,S10=4'b1010,S11=4'b1011,
    S12=4'b1100,S13=4'b1101,S14=4'b1110,S15=4'b1111;

always@ (posedge clk)begin


    //Case: basic program
    case (basic_program)

        1: begin

            if(coin) begin
                case(state)
                    S0:  state=S1;
                    S1:  state=S5;
                    S5:  state=S11;
                    S11: state=S6;
                    S6:  state=S12;
                    S12: state = S0;


                    default: state=S0;

                endcase
            end
        end

    endcase


    //Case: extra cleaning program
    case (extra_cleaning_program)

        1: begin

            if(coin) begin
                case(state)
                    S0:  state = S2;
                    S2:  state = S4;
                    S4:  state = S11;
                    S11: state = S5;
                    S5:  state = S13;
                    S13: state = S6;
                    S6:  state = S12;
                    S12: state = S0;

                    default: state=S0;

                endcase
            end
        end

    endcase

    //Case: Platinum program
    case (platinum_program)

        1: begin


            if (coin) begin

                case (state)
                    S0:  state = S3;
                    S3:  state = S4;
                    S4:  state = S11;
                    S11: state = S5;
                    S5:  state = S13;
                    S13: state = S6;
                    S6:  state = S7;
                    S7:  state = S14;
                    S14: state = S15;
                    S15: state = S8;
                    S8:  state =S9;
                    S9:  state = S10;
                    S10: state = ID;
                    S12: state = S0;

                    default: state=S0;

                endcase
            end
        end

    endcase

    //Case: Reset Program - Start Again
    case (reset_program)

        1:begin

            state=S0;
        end

    endcase

    //Case: Choose state
    case (state)

        //Display On Board

        S0:   begin Lssd=7'b0000001; Rssd=7'b0000001; end
        S1:   begin Lssd=7'b0011111; Rssd=7'b1100111; end
        S2:   begin Lssd=7'b1001111; Rssd=7'b1100111; end
        S3:   begin Lssd=7'b1100111; Rssd=7'b1100111; end
        S4:   begin Lssd=7'b1100111; Rssd=7'b1011011; end
	  S5:   begin Lssd=7'b1011011; Rssd=7'b1000111; end
        S6:   begin Lssd=7'b0000101; Rssd=7'b0110000; end
        S15:  begin Lssd=7'b0000101; Rssd=7'b0110000; end
        S7:   begin Lssd=7'b0111110; Rssd=7'b0111110; end
	  S8:   begin Lssd=7'b0000000; Rssd=7'b0111101; end
        S9:   begin Lssd=7'b0000101; Rssd=7'b1011011; end
        S10:  begin Lssd=7'b1011011; Rssd=7'b0110111; end
        S11:  begin Lssd=7'b0000000; Rssd=7'b1001110; end
        S13:  begin Lssd=7'b0000000; Rssd=7'b1001110; end
        S14:  begin Lssd=7'b0000000; Rssd=7'b1001110; end
        S12:  begin Lssd=7'b1111110; Rssd=7'b1111111; end
        default: begin Lssd=7'b0000001; Rssd=7'b0000001; end

    endcase
end

endmodule
