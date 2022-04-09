with HAL.UART;

with RP.Device;
with RP.UART;

with Pico;

package body Transmitter.UART.Pico is

   UART    : RP.UART.UART_Port renames RP.Device.UART_0;

   procedure Transmit_Control (Control : String) is
      Status        : HAL.UART.UART_Status;
      Control_Bytes : HAL.UART.UART_Data_8b (1 .. Control'Length);
      use HAL.UART;
   begin
      Standard.Pico.LED.Clear;
      for I in Control'Range loop
         Control_Bytes (I) := Character'Pos (Control (I));
      end loop;

      UART.Transmit (Control_Bytes, Status);
      if Status /= HAL.UART.Ok then
         Standard.Pico.LED.Set;
      end if;
   end Transmit_Control;

end Transmitter.UART.Pico;
