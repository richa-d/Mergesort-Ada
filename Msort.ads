package Msort is
	LENGTH: constant Integer := 40;
	type ArrType is array (Integer range <>) of Integer range -300..300;
	procedure Sort(A: in out ArrType; lo,hi:in out Integer);
	procedure Merge(A: in out ArrType; lo,mid,hi: in out Integer);
	procedure TaskCall(lo,mid,hi:in out Integer);
	procedure Caller(lo,mid,mid2,hi:in out Integer);
end Msort;