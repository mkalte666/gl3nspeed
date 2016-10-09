import std.stdio,std.datetime,std.conv;

import gl3n.linalg;

double stdToSec(long std) 
{
    return cast(double)(std)*0.0000001;
}

void speedyFunc(bool simd)(long loopCount)
{
    long clk,clk2;
    alias ftype = Vector!(float,4,simd);
    static assert(simd==ftype.hasSimd);
    alias dtype = Vector!(double,4,simd);
    writeln("Doing tests with SIMD=" ~ to!string(simd) ~ "and LC=" ~ to!string(loopCount));


    writeln("Speed of the += operator on float (vec4+=vec4)");
    
    clk = Clock.currStdTime();
    ftype a = 1234.000001;
    ftype b = 1234.0000001;
    ftype c = 1234.0000001;
    for( long i = 0; i <loopCount; i++) {
        a+=b;
        a+=c;
        c+=b;
    } 
    clk2 = Clock.currStdTime();
    writeln("took: " ~ to!string(stdToSec(clk2-clk)) ~ "s!");

    writeln("Speed of the magnitude operation on float |vec4|");
    a = ftype(123.0);
    clk = Clock.currStdTime();
    for(long i = 0; i < loopCount; i++) {
        cast(void)a.magnitude;
    }
    clk2 = Clock.currStdTime();
    writeln("took: " ~ to!string(stdToSec(clk2-clk)) ~ "s");
}


void main()
{
    writeln("Enter loop count");
    long loopCount = 0;
    readf("%d\n",&loopCount);
    
    speedyFunc!false(loopCount);
    speedyFunc!true(loopCount);
}
