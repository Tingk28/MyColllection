`include "Adder.v"

module tb;
reg [3:0] a, b;
reg cin;
wire [3:0] c;
wire cout;
integer  i, j, k, errno;
Adder adder0(
    .x(a), 
    .y(b), 
    .cin(cin),
    .s(c),
    .cout(cout)
);
initial begin
    errno = 0;
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            for (k = 0; k < 2; k = k + 1) begin
                a = i;
                b = j;
                cin = k;
                #1;
                if (i + j + k !== {cout, c}) begin
                    $display("Error: %d + %d + %d should be cout: %d, s: %d\n instead of cout: %d, s: %d",i, j, k, (i+j+k)/16, (i+j+k)%16, cout, c);
                    errno = errno + 1;
                end                 
            end
        end
    end
    if (errno == 0) begin
        $display("\n");
        $display("                                       /;    ;\\");
        $display("                                   __  \\\\____//");
        $display("                                  /{_\\_/   `'\\____");
        $display("                                  \\___   (o)  (o  }");
        $display("       _____________________________/          :--'  ");
        $display("   ,-,'`@@@@@@@@       @@@@@@         \\_    `__\\");
        $display("  ;:(  @@@@@@@@@        @@@             \\___(o'o)");
        $display("  :: )  @@@@          @@@@@@        ,'@@(  `===='       ");
        $display("  :: : @@@@@:          @@@@         `@@@:");
        $display("  :: \\  @@@@@:       @@@@@@@)    (  '@@@'");
        $display("  ;; /\\      /`,    @@@@@@@@@\   :@@@@@)");
        $display("  ::/  )    {_----------------:  :~`,~~;");
        $display(" ;;'`; :   )                  :  / `; ;");
        $display(";;;; : :   ;                  :  ;  ; :              ");
        $display("`'`' / :  :                   :  :  : :");
        $display("    )_ \\__;      \";\"          :_ ;  \\_\\       `,','");
        $display("    :__\\  \\    * `,'*         \\  \\  :  \\   *  8`;'*  *");
        $display("        `^'     \\ :/           `^'  `-^-'   \\v/ :  \\/ ");
        $display("Congratulations!");
        $display("Simulation Passed!");
        $display("\n");       
    end
    else begin
        $display("Total Error: %d", errno);
    end
end
endmodule