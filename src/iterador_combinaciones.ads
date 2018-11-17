
generic 
   type Integers is range <>;
package iterador_Combinaciones is
   type Combination is array (Positive range <>) of Integers;
   procedure First (X : in out Combination);
   procedure Next (X : in out Combination);
   type array_Vector is array (Natural range 1..10) of Integer;
   procedure Put (X : Combination);
   
   Fin_Combinaciones : Exception;


end iterador_Combinaciones;
