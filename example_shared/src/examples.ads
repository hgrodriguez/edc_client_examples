with RP.Timer;

package Examples is

   SHOW_LEDS : constant Boolean := True;

   DELAY_IN_BETWEEN : constant Integer := 100;
   My_Timer  : RP.Timer.Delays;
   procedure Delay_4_Next;

   procedure Show_Led_Pattern;

end Examples;
