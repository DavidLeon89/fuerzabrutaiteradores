with ada.Command_Line; use ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with iterador_Combinaciones;
with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones; use Ada.Calendar.Time_Zones;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Main is
   type array_Vector is array (Natural range 1..11) of Integer;
   Vector : array_Vector := (others => 0);
   onOff, SinErroresEntrada: Boolean := false;
   Start_Time  : Time;
   procedure calculoFuerzaBruta (numAMostrar : Integer)is

      --Preparo todas el iterador con las combinaciones
      --rango de posiciones a mostrar
      type Five is range 1..10;
      package Fives is new iterador_Combinaciones (Five);
      use Fives;

      --tamagno a mostrar
      X : Combination (1..numAMostrar);
      imprimir : Unbounded_String;
      conta : Integer;
      --Controlar el tiempo

   begin
      --Primera combinacion
      First (X);

      begin
         loop
            --contador para solo se impriman los que coincidan con cantidad a mostrar
            --ya que si no, al solo mostrar los pares veriamos combinaciones de diferentes tamagno

            conta :=  1;
            imprimir := to_unbounded_string("");

            --Nos quedaremos con las combinaciones que el primer elemento sea par
            for K in X'Range loop
               if X(K) > 0 and then vector(Integer (X(K))) mod 2 = 0 then
                  imprimir := imprimir & to_unbounded_string(vector(Integer (X(K)))'Img);
                  conta := conta + 1;
               end if;
            end loop;
            if numAMostrar =  conta then
               Put_Line(to_string(imprimir));
            end if;
            --avanzamos a la siguiente combinacion
            Next (X);
         end loop;



         --controlamos posibles excepciones
      exception
         when Fin_Combinaciones =>
            null;
      end;


   end calculoFuerzaBruta;

   procedure readComandLine is
      F_Entrada         : File_Type;
      Línea             : String(1..1);
      Lon_Línea       : Natural;
      Con : Integer := 1; Reloj : Boolean := false;

   begin
      if Argument_Count > 2 or Argument_Count < 1 then
         Put_Line("Parametros Incorrectos. Ejemplos: 1) fichero.txt 2) -t fichero.txt");
         return;
      end if;

      if Argument_Count = 2 then
         if Argument(Con) = "-t" then
            onOff := true;
            Con := Con + 1;
         else
            Put_Line("Parametros Incorrectos. Ejemplos: 1) fichero.txt 2) -t fichero.txt");
            return;
         end if;
      end if;

      --se abren los ficheros
      Open(F_Entrada,Mode => In_File,Name => Argument(Con));

      SinErroresEntrada := true;
      Con := 1;
      while not End_Of_File(F_Entrada) loop
         Get_Line(F_Entrada,Línea,Lon_Línea);
         if Línea(1..Lon_Línea) /= " " then
            Vector(Con) := integer'Value(Línea(1..Lon_Línea));
            Con := Con + 1;
         end if;
      end loop;
      --se cierran el fichero
      Close(F_Entrada);
   end readComandLine;

begin

   readComandLine;

   if SinErroresEntrada then
      for I in 2..10 loop
         --activo reloj si corresponde
         if onOff then
            Start_Time := Clock;
         end if;
         Put_Line("Combinaciones tomadas de: " & Integer'Image (I - 1) & " Elementos.");
         calculoFuerzaBruta(I);

         --muestro tiempo
         if onOff then
            Put_Line("Combinaciones para" & Integer'Image (I - 1) & " ha tardado: " & Duration'Image(Clock - Start_Time));
         end if;

      end loop;

   end if;

end Main;
