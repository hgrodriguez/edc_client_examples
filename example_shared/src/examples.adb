with Edc_Client.LED;

package body Examples is

   procedure Delay_4_Next is
   begin
      RP.Timer.Delay_Milliseconds (This => Examples.My_Timer,
                                   Ms   => DELAY_IN_BETWEEN);
   end Delay_4_Next;

   LEDs_On : Boolean := True;

   procedure Show_Led_Pattern is
   begin
      if SHOW_LEDS then
         if LEDs_On then
            Edc_Client.LED.Red_On;
            Delay_4_Next;
            Edc_Client.LED.Amber_On;
            Delay_4_Next;
            Edc_Client.LED.Green_On;
            Delay_4_Next;
            Edc_Client.LED.White_On;
            Delay_4_Next;
            Edc_Client.LED.Blue_On;
            Delay_4_Next;
         else
            Edc_Client.LED.Red_Off;
            Delay_4_Next;
            Edc_Client.LED.Amber_Off;
            Delay_4_Next;
            Edc_Client.LED.Green_Off;
            Delay_4_Next;
            Edc_Client.LED.White_Off;
            Delay_4_Next;
            Edc_Client.LED.Blue_Off;
            Delay_4_Next;
         end if;
         LEDs_On := not LEDs_On;
      end if;
   end Show_Led_Pattern;

end Examples;
