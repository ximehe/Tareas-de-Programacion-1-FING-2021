function generadora (n: integer): integer;
type
RangoArreglo=1..3;
Arreglo= array [RangoArreglo] of integer;
var a,b,max,min,med,i,j,max1,max2,min1,min2,med1: integer;
{C = cifras de n}
C:Arreglo; 
begin
C[1]:= n DIV 100;
C[2]:= (n MOD 100) DIV 10;
C[3]:= n MOD 10;
i:=1;
j:=1;
While i<=3 do begin
    if (C[i]>=C[1]) and (C[i]>=C[2]) and (C[i]>=C[3]) then 
    max:=C[i];
    if (C[i]>=C[1]) and (C[i]>=C[2]) and (C[i]>=C[3]) then 
    min:=C[i];
    i:=i+1;
end;
for j:=1 to 3 do begin
if (C[j]<=max) and (C[j]>=min) then
    med:=C[j];
end;
max1:= max * 100;
med1:= med * 10;
min1:= min * 1;
max2:= max * 1;
min2:= min * 100;
a:= max1+med1+min1;
b:= max2+med1+min2;
generadora:= a-b;  
end.

function longitud (semilla: integer; limite: integer): integer;
var semillan,cont,long:integer;
begin
cont:=1
    repeat
    semilla:=generadora(semilla);
    cont:=cont+1;
    semn:=generadora(semilla);
    until semilla=semn
if cont>limite then
    long:=-1;
else
    long:=cont;
longitud:=long
end.
