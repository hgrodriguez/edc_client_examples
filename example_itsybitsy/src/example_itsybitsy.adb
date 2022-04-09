--===========================================================================
--
--  The main procedure for the ItsyBitsy example program.
--
--===========================================================================
--
--  Copyright 2021 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL;

with RP.Clock;
with RP.Device;
with RP.GPIO;
with RP.Timer;
with RP.UART;

with ItsyBitsy;

with Edc_Client;
with Edc_Client.Alpha;
with Edc_Client.Alpha.Block1;
with Edc_Client.Matrix.Double_Word;

with Transmitter.UART;
with Transmitter.UART.ItsyBitsy;

with Demos;

with Examples;

procedure Example_Itsybitsy is
   SHOW_DOUBLE_WORD     : constant Boolean := False;
   SHOW_SINGLE_LETTERS  : constant Boolean := True;
   SHOW_DOUBLE_LETTERS  : constant Boolean := False;
   SHOW_FOUR_LETTERS    : constant Boolean := False;
   SHOW_EIGHT_LETTERS   : constant Boolean := True;

   type Transmitter_Available is (UART_Transmitter);
   USE_TRANSMITTER  : constant Transmitter_Available := UART_Transmitter;

   use type HAL.UInt32;
   Double_Word : HAL.UInt32 := 0;

   --========================================================================
   subtype SL_Range is Integer range 1 .. 8;

   Single_Letters                        : constant array (SL_Range) of
     Edc_Client.Alpha.Single_Letter_String := (1 => "A",
                                               2 => "B",
                                               3 => "C",
                                               4 => "D",
                                               5 => "E",
                                               6 => "F",
                                               7 => "G",
                                               8 => " ");
   SL_Index : SL_Range := SL_Range'First;
   SL_Pos   : Edc_Client.Alpha.Block1.Single_Letter_Positions
     := Edc_Client.Alpha.Block1.Single_Letter_Positions'First;

   --========================================================================
   subtype DL_Range is Integer range 1 .. 4;

   Double_Letters                         : constant array (DL_Range) of
     Edc_Client.Alpha.Double_Letters_String := (1 => "AZ",
                                                2 => "BY",
                                                3 => "CX",
                                                4 => "DW");
   DL_Index : DL_Range := DL_Range'First;
   DL_Pos   : Edc_Client.Alpha.Block1.Double_Letters_Positions
     := Edc_Client.Alpha.Block1.Double_Letters_Positions'First;

   --========================================================================
   subtype FL_Range is Integer range 1 .. 2;

   Four_Letters                         : constant array (FL_Range) of
     Edc_Client.Alpha.Four_Letters_String := (1 => "AZBY",
                                              2 => "CXDW");
   FL_Index : FL_Range := FL_Range'First;
   FL_Pos   : Edc_Client.Alpha.Block1.Four_Letters_Positions
     := Edc_Client.Alpha.Block1.Four_Letters_Positions'First;

   --========================================================================
   subtype EL_Range is Integer range 1 .. 8;

   Eight_Letters                         : constant array (EL_Range) of
     Edc_Client.Alpha.Eight_Letters_String := (1 => "CXDWAZBY",
                                               2 => "        ",
                                               3 => "BYAZDWCX",
                                               4 => "        ",
                                               5 => "A C E G ",
                                               6 => "        ",
                                               7 => " B D F H",
                                               8 => "        "
                                              );
   EL_Index                              : EL_Range := EL_Range'First;

   --------------------------------------------------------------------------
   --  Definitions of the UART ports to use for the communication.
   --------------------------------------------------------------------------
   UART    : RP.UART.UART_Port renames RP.Device.UART_0;
   UART_TX : RP.GPIO.GPIO_Point renames ItsyBitsy.GP28;
   UART_RX : RP.GPIO.GPIO_Point renames ItsyBitsy.GP29;

   --------------------------------------------------------------------------
   --  All procedures below are documented in the corresponding .ads file
   --------------------------------------------------------------------------
   procedure UART_Initialize;
   procedure UART_Initialize is
   begin
      UART_TX.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.UART);
      UART_RX.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.UART);
      UART.Configure
        (Config =>
           (Baud      => Edc_Client.SERIAL_BAUD_RATE,
            Word_Size => 8,
            Parity    => False,
            Stop_Bits => 1,
            others    => <>));
   end UART_Initialize;

begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   RP.GPIO.Enable;
   ItsyBitsy.LED.Configure (RP.GPIO.Output);
   ItsyBitsy.LED.Set;

   case USE_TRANSMITTER is
      when UART_Transmitter =>
         UART_Initialize;
         Edc_Client.Initialize (T => Transmitter.
                                  UART.
                                    ItsyBitsy.
                                      Transmit_Control'Access);
   end case;

   loop
      Examples.Delay_4_Next;
      Examples.Show_Led_Pattern;

      Demos.Breathing_Xs;
      Examples.Delay_4_Next;

      Demos.Show_Speed;
      Examples.Delay_4_Next;

      Demos.Show_Incrementing_Word;
      Examples.Delay_4_Next;

      if SHOW_DOUBLE_WORD then
         Edc_Client.Matrix.Double_Word.Show_Double_Word (Double_Word);
         Examples.Delay_4_Next;
         Double_Word := Double_Word - 1;
      elsif SHOW_SINGLE_LETTERS then
         Edc_Client.
           Alpha.Block1.
             Show_Single_Letter
               (Position => SL_Pos,
                Value    => Single_Letters (SL_Index));
         Examples.Delay_4_Next;
         if SL_Index = SL_Range'Last then
            SL_Index := SL_Range'First;
            if SL_Pos = Edc_Client.
              Alpha.Block1.
                Single_Letter_Positions'Last
            then
               SL_Pos := Edc_Client.
                 Alpha.Block1.
                   Single_Letter_Positions'First;
            else
               SL_Pos := SL_Pos + 1;
            end if;
         else
            SL_Index := SL_Index + 1;
         end if;
      elsif SHOW_DOUBLE_LETTERS then
         Edc_Client.
           Alpha.Block1.
             Show_Double_Letters
               (Position => DL_Pos,
                Value    => Double_Letters (DL_Index));
         Examples.Delay_4_Next;
         if DL_Index = DL_Range'Last then
            DL_Index := DL_Range'First;
            if DL_Pos = Edc_Client.
              Alpha.Block1.
                Double_Letters_Positions'Last
            then
               DL_Pos := Edc_Client.
                 Alpha.Block1.
                   Double_Letters_Positions'First;
            else
               DL_Pos := DL_Pos + 1;
            end if;
         else
            DL_Index := DL_Index + 1;
         end if;
      elsif SHOW_FOUR_LETTERS then
         Edc_Client.
           Alpha.Block1.
             Show_Four_Letters
               (Position => FL_Pos,
                Value    => Four_Letters (FL_Index));
         Examples.Delay_4_Next;
         if FL_Index = FL_Range'Last then
            FL_Index := FL_Range'First;
            if FL_Pos = Edc_Client.
              Alpha.Block1.
                Four_Letters_Positions'Last
            then
               FL_Pos := Edc_Client.
                 Alpha.Block1.
                   Four_Letters_Positions'First;
            else
               FL_Pos := FL_Pos + 1;
            end if;
         else
            FL_Index := FL_Index + 1;
         end if;
      elsif SHOW_EIGHT_LETTERS then
         Edc_Client.
           Alpha.Block1.
             Show_Eight_Letters
               (Value    => Eight_Letters (EL_Index));
         Examples.Delay_4_Next;
         if EL_Index = EL_Range'Last then
            EL_Index := EL_Range'First;
         else
            EL_Index := EL_Index + 1;
         end if;
      end if;
   end loop;

end Example_Itsybitsy;
