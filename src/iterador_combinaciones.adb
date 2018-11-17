with Ada.Text_IO; use Ada.Text_IO;

package body iterador_Combinaciones is
   
   procedure First (X : in out Combination) is
   begin
      X (1) := Integers'First;
      for I in 2..X'Last loop
         X (I) := X (I - 1) + 1;
      end loop;
   end First;
   
   procedure Next (X : in out Combination) is
   begin
      for I in reverse X'Range loop
         if X (I) < Integers'Val (Integers'Pos (Integers'Last) - X'Last + I) then
            X (I) := X (I) + 1;
            for J in I + 1..X'Last loop
               X (J) := X (J - 1) + 1;
            end loop;
            return;
         end if;
      end loop;
      raise Fin_Combinaciones;
   end Next;
   
   procedure Put (X : Combination) is
   begin
      for I in X'Range loop
         Put (X (I)'Img);
      end loop;
   end Put;
   
end iterador_Combinaciones;
