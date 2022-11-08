function sonCartasIguales (a, b :TCarta) : boolean;
{El resultado es true si y solo si a y b son la misma carta}
Var resu: boolean;
begin
resu:=false;
If (a.comodin=true) and (b.comodin=true) then
resu:=true;
If (a.comodin=false) and (b.comodin=false) then begin
   If (a.numero=b.numero) and (a.palo=b.palo) then
   resu:=true;
end;
If (a.comodin=true) and (b.comodin=false) then
resu:=false;
If (a.comodin=false) and (b.comodin=true) then
resu:=false;
sonCartasIguales:=resu;
end;

procedure armarTablero (mazo: TMazo; cantCols: TRangoCols; var t : TTablero);

var j,i,v,w: integer;
   

begin
t.tope:=cantCols;
v:=1;{ para contar la cantidad de cartas }
w:=1; { filas de cartas en TColumna}
For i:=1 to cantCols do begin
t.columnas[i].tope:=0;
end;
{Controlar que no se salga de rango (no intente poner más cartas de las que hay}
While (v <= mazo.tope) do begin
{Copia en las primeras cantCols columnas del tablero t las cartas de mazo y 
va aumentando el tope}
     For j:=1 to cantCols do begin
         If (v<= mazo.tope) then begin
            t.columnas[j].tope:=t.columnas[j].tope+1;
            t.columnas[j].cartas[w]:=mazo.cartas[v]; 
           v:=v+1;
          end
          else
          begin
          end;
         
             
     end;
     w:=w+1
end;

end;

procedure levantarTablero (t : TTablero; var mazo : TMazo);

Var i, j: integer;
    
begin
{inicio el tope del mazo en 0}
mazo.tope:=0;
{Copia las cartas del tablero t en mazo y va aumentando el tope}
For j:=1 to (t.tope) do begin
   For i:=1 to (t.columnas[j].tope) do begin
       mazo.tope:=mazo.tope+1;
       mazo.cartas[mazo.tope]:=t.columnas[j].cartas[i];
       
   end;
   
end;

end;

function enQueColumna (carta : TCarta; t: Ttablero): TRangoCols;
var i,j,resultado: integer;
    cartaencontrada: boolean;
    
begin
{asignacion de variables}
cartaencontrada:=false;
i:=1;
j:=1;
{Determina en qué columna del tablero t está carta}
While (i<= t.tope) and (cartaencontrada=false)  do begin
     While (j<=t.columnas[i].tope) and (cartaencontrada=false) do begin
      If sonCartasIguales(t.columnas[i].cartas[j],carta) then begin
           cartaencontrada:=true;
           resultado:= i
      end
           else
           begin
           cartaencontrada:=false;
           j:=j+1;
           end;
           
     end;      
     j:=1;
     i:= i + 1;
end;

enQueColumna:=resultado;
  
end;

procedure estanEnAmbos (columna : TColumna; var mazo : TMazo);
var i, j:integer;
    encontrado: boolean;
    mazoauxiliar: TMazo;
begin
{le asigno el mazo a un mazo auxiliar para no perder la copia}
mazoauxiliar:=mazo;
mazo.tope:=0;
encontrado:=false;
{Deja en mazo solo las cartas que también están en columna}
For i:=1 to mazoauxiliar.tope do begin
    For j:=1 to columna.tope do begin
        If sonCartasIguales(columna.cartas[j], mazoauxiliar.cartas[i]) then begin
        encontrado:=true;
        mazo.tope:= mazo.tope+1;
        mazo.cartas[mazo.tope]:= mazoauxiliar.cartas[i];
        end
        else
        begin
        encontrado:=false;
        end;
        
    end;
end;
end;

{Procedimiento Auxiliar para el procedimiento convertirTablero}
procedure Agreelem(var ccolumna: TColumnaL; carta: TCarta);
var a,b : TColumnaL;
begin 
new(a); 
a^.carta:= carta; 
a^.sig:= nil; 
if (ccolumna = nil) then 
    ccolumna:= a
    else 
    begin
    b:= ccolumna;
    While (b^.sig <> nil) do 
           b:= b^.sig;
           b^.sig:= a;
    end;
end;



procedure convertirTablero (t : TTablero; var tl : TTableroL);
var i,j: integer;
 
begin
tl.tope:=t.tope;
{Convierte el tablero t, implementado con arreglos con tope, en el tablero tl, que está implementado con listas}
For i:= 1 to tl.tope do begin
    tl.columnas[i]:=nil;
    {va agregando un elemento al final de la lista cada vez que itera hasta llegar 
    al tope de columnas del tablero}
    For j:= 1 to t.columnas[i].tope do begin
    Agreelem(tl.columnas[i],t.columnas[i].cartas[j])
    end;
end;
end;
