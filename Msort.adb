with Text_Io;
use Text_Io;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Integer_Text_IO; 
use Ada.Integer_Text_IO;

package body Msort is

	global:ArrType(1..LENGTH);
	temp:ArrType(1..LENGTH);

	task type CSort1 is
		entry Start1(lo,hi:in out Integer);
	end CSort1;

	task body CSort1 is
	l,m,h:Integer;
	begin
		loop
			select
			accept Start1(lo,hi:in out Integer) do
				l:=lo;
				h:=hi;
			end Start1;
			m:=0;
------------Recursive call to TaskCall
			TaskCall(l,m,h);
			or
			terminate;
			end select;
		end loop;
	end CSort1;

	task type CSort2 is
		entry Start2(lo,hi:in out Integer);
	end CSort2;

	task body CSort2 is
	l,m,h:Integer;
	begin
	loop
		select
			accept Start2(lo,hi:in out Integer) do
				l:=lo;
				h:=hi;	
			end Start2;
			m:=0;
------------Recursive call to TaskCall
			TaskCall(l,m,h);
			or
			terminate;
			end select;
		end loop;
	end CSort2;

	procedure Caller(lo,mid,mid2,hi:in out Integer) is 
	leftsort:CSort1;
	rightsort:CSort2;
	begin
--------Creating the 2 tasks
		leftsort.Start1(lo,mid);
		rightsort.Start2(mid2,hi);
	end;

	procedure TaskCall(lo,mid,hi: in out Integer) is
	mid2:Integer;	
	begin
		if lo<hi then
			mid:=(lo+hi)/2;
			mid2:=mid+1;
------------Caller will initiate the 2 tasks
			Caller(lo,mid,mid2,hi);
			Merge(global,lo,mid,hi);			
		end if;
	end;

	procedure Sort(A: in out ArrType;lo,hi: in out Integer) is
	mid: Integer;
	begin
--------assign local array to global array
		global:=A;
		mid:=(A'first+A'last)/2;
		TaskCall(lo,mid,hi);
		A:=global;
	end;

	procedure Merge(A: in out ArrType; lo,mid,hi: in out Integer) is
	i,j,k:Integer:=1;
	begin
		i:=lo;
		j:=mid+1;
		k:=lo;

--------compare and add elements
		while i<=mid and then j<=hi loop
			if A(i)<=A(j) then
				temp(k):=A(i);
				k:=k+1;
				i:=i+1;
			else
				temp(k):=A(j);
				k:=k+1;
				j:=j+1;
			end if;
		end loop;

--------add remaining elements
		while i<=mid loop
			temp(k):=A(i);
			k:=k+1;
			i:=i+1;
		end loop;

		while j<=hi loop
			temp(k):=A(j);
			k:=k+1;
			j:=j+1;
		end loop;

--------copy temp array into global array
		for i in lo..hi loop
				global(i):=temp(i);
		end loop;

	end;

end Msort;