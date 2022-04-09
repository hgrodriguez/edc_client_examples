with HAL;

with Edc_Client.Alpha.Block1;
with Edc_Client.Alpha.Block2;
with Edc_Client.Matrix.Word;

with Examples;

package body Demos is

   Four_Spaces                         : constant
     Edc_Client.Alpha.Four_Letters_String := "    ";

   Eight_Spaces                         : constant
     Edc_Client.Alpha.Eight_Letters_String := "        ";

   procedure Breathing_Xs is
      subtype EL_Range is Integer range 1 .. 11;
      Eight_Letters : constant array (EL_Range) of
        Edc_Client.Alpha.Eight_Letters_String := (1 => Eight_Spaces,
                                                  2 => "XXXXXXXX",
                                                  3 => " XXXXXX ",
                                                  4 => "  XXXX  ",
                                                  5 => "   XX   ",
                                                  6 => Eight_Spaces,
                                                  7 => "   XX   ",
                                                  8 => "  XXXX  ",
                                                  9 => " XXXXXX ",
                                                  10 => "XXXXXXXX",
                                                  11 => Eight_Spaces
                                                 );
   begin
      for I in EL_Range'Range loop
         Edc_Client.
           Alpha.Block1.
             Show_Eight_Letters
               (Value => Eight_Letters (I));
         Examples.Delay_4_Next;
         Examples.Delay_4_Next;
      end loop;
   end Breathing_Xs;

   --
   procedure Show_Speed is
      Eight_Letters                         : constant
        Edc_Client.Alpha.Eight_Letters_String := "V[m/s]: ";
      Four_Letters                          : constant
        Edc_Client.Alpha.Four_Letters_String := "8.32";
   begin
      Edc_Client.
        Alpha.Block2.
          Show_Four_Letters
            (Value => Four_Letters);
      Examples.Delay_4_Next;
      Edc_Client.
        Alpha.Block1.
          Show_Eight_Letters
            (Value => Eight_Letters);
      Examples.Delay_4_Next;
      Examples.Delay_4_Next;
      Examples.Delay_4_Next;
      Examples.Delay_4_Next;
      Edc_Client.
        Alpha.Block1.
          Show_Eight_Letters
            (Value => Eight_Spaces);
      Examples.Delay_4_Next;
      Edc_Client.
        Alpha.Block2.
          Show_Four_Letters
            (Value => Four_Spaces);
      Examples.Delay_4_Next;
      Examples.Delay_4_Next;
   end Show_Speed;

   use type HAL.UInt16;
   Word : HAL.UInt16 := 0;

   procedure Show_Incrementing_Word is
   begin
      Edc_Client.Matrix.Word.Show_Word (Word);
      Word := Word + 1;
      Examples.Delay_4_Next;
      Examples.Delay_4_Next;
   end Show_Incrementing_Word;

end Demos;
