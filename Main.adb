with Text_Io;
use Text_Io;

with Msort;
use Msort;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Integer_Text_IO; 
use Ada.Integer_Text_IO;

procedure Main is
Arr: ArrType(1..LENGTH);
Sum: Integer;
lo,hi:Integer;

	task Reader is
		entry StartRead;
	end Reader;

	task Summation is
		entry FindSum;
	end Summation;

	task Printer is 
		entry Print;
	end Printer;

	task body Reader is
	begin
		accept StartRead do
	    for I in 1..LENGTH loop
	        Arr(I) := Integer'Value(Get_Line);
	    end loop;
	    end StartRead;
	end Reader;

	task body Summation is
	begin
	accept FindSum;
		Sum:=0;
	    for I in 1..LENGTH loop
	    	Sum:=Sum+Arr(I);
	    end loop;
	    Printer.Print;
	end Summation;

	task body Printer is
	begin
		accept Print;
		Put_Line("The sorted array is:");
		for Q in 1..LENGTH loop
		    Put(Arr(Q));
		end loop;

		New_Line(1);
		accept Print;
		Put_Line("The sum is: ");
	    Put(Sum);
	end Printer;

begin
	Reader.StartRead;
	lo:=Arr'first;
	hi:=Arr'last;
	Sort(Arr,lo,hi);
	Summation.FindSum;
	Printer.Print;
end Main;