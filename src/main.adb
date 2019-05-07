with Ada.Real_Time; use Ada.Real_Time;

with System;

with SAM.Device;

with HAL; use HAL;
with HAL.GPIO;
with HAL.SPI; use HAL.SPI;

with SAM.GPIO;
with SAM.SPI;
with FT801;
with FT801.Coproc;
with FT801.Display_List;

with Fractal_Impl; use Fractal_Impl;
with Image_Types;

with Screen_ISR;
with Screen_Settings; use Screen_Settings;

procedure Main
is
   use RGB565_Image_Types;
   
   Viewport    : Viewport_Info := (Width  => Image_Width,
                                   Height => Image_Height,
                                   Zoom   => 12,
                                   Center => (X => Image_Width / 2,
                                              Y => Image_Height / 2)); 

   MISO  : SAM.GPIO.GPIO_Point renames SAM.Device.PD20;
   MOSI  : SAM.GPIO.GPIO_Point renames SAM.Device.PD21;
   SPCK  : SAM.GPIO.GPIO_Point renames SAM.Device.PD22;
   NPCS1 : SAM.GPIO.GPIO_Point renames SAM.Device.PD25;

   SPI_Cfg_Init : SAM.SPI.Configuration := (Baud           => 10_000_000,
                                            Tx_On_Rx_Empty => False,
                                            Cs_Beh         => SAM.SPI.Keep_Low,
                                            others         => <>);
   
   SPI_Cfg      : SAM.SPI.Configuration := (Baud           => 30_000_000,
                                            Tx_On_Rx_Empty => False,
                                            Cs_Beh         => SAM.SPI.Keep_Low,
                                            others         => <>);
   
   procedure Wait (Period : Time_Span)
   is
   begin
      delay until (Period + Clock);
   end Wait;
   
   procedure Initialize_GPIOs is
      use SAM.GPIO;
   begin
      Enable_Clock (SAM.Device.GPIO_A);
      Enable_Clock (SAM.Device.GPIO_C);
      
      SAM.GPIO.Configure_IO (This => Screen_ISR.Interrupt_Line,
                             Config => SAM.GPIO.GPIO_Port_Configuration'(Mode   => Mode_In,
                                                                         others => <>));
      
      SAM.GPIO.Enable_Interrupt (This => Screen_ISR.Interrupt_Line,
                                 Trigger => Falling_Edge);

      Screen_Power_Down.Configure_IO
        (Config => GPIO_Port_Configuration'(Mode        => Mode_Out,
                                            Resistors   => <>,
                                            Output_Type => Push_Pull));
   end Initialize_GPIOs;

   procedure Initialize_SPI is
      use SAM.GPIO;
   begin
      MISO.Configure_IO (Config => (Mode => Mode_AF,
                                    Resistors      => <>,
                                    AF_Output_Type => Push_Pull,
                                    AF             => Periph_B));
      MOSI.Configure_IO (Config => (Mode => Mode_AF,
                                    Resistors      => <>,
                                    AF_Output_Type => Push_Pull,
                                    AF             => Periph_B));
      SPCK.Configure_IO (Config => (Mode => Mode_AF,
                                    Resistors      => <>,
                                    AF_Output_Type => Push_Pull,
                                    AF             => Periph_B));
      NPCS1.Configure_IO (Config => (Mode => Mode_AF,
                                     Resistors      => <>,
                                     AF_Output_Type => Push_Pull,
                                     AF             => Periph_B));

      SAM.SPI.Configure (This => Screen_Settings.SPI_Port,
                         Cfg  => SPI_Cfg_Init);
   end Initialize_SPI;
   
   procedure Initialize_Fractal
   is
   begin
      Fractal_Impl.Init (Viewport => Viewport);
   end Initialize_Fractal;                                
   
   procedure Initialize_Screen
   is
   begin
      FT801.Initialize (This => Screen,
                        Settings => Screen_Cfg);
      
      SAM.SPI.Configure (This => Screen_Settings.SPI_Port,
                         Cfg  => SPI_Cfg);
      
      FT801.Display_On (This => Screen);
        
   end Initialize_Screen;
   
   Screen_Data : UInt8_Array (1 .. Natural (Fractal_Impl.Buffer_Size))
     with Address => RawDataRow.all'Address;
begin

   Initialize_GPIOs;
   Initialize_SPI;
   Initialize_Fractal;
   
   Initialize_Screen;
   
   loop
      for I in 1 .. Image_Height loop
         Fractal_Impl.Compute_Row (Row    => I,
                                   Buffer => RawDataRow);
         FT801.Fill_G_Ram (This   => Screen,
                           Start  => UInt22 (I - 1) * UInt22 (Buffer_Size),
                           Buffer => Screen_Data);
      end loop;
      Fractal_Impl.Increment_Frame;
   
      FT801.Coproc.Send_Coproc_Cmds (This => Screen,
                                     Cmds => (FT801.Coproc.CMD_DLSTART,
                                              FT801.Display_List.Clear'(Color   => True,
                                                                        Stencil => True,
                                                                        Tag     => True,
                                                                        others  => <>).Val,
                                              FT801.Display_List.Bitmap_Source'(Addr    => FT801.RAM_G_Address,
                                                                                others  => <>).Val,
                                              FT801.Display_List.Bitmap_Layout'(Format     => Ft801.RGB565,
                                                                                Linestride => UInt10 (Linestride),
                                                                                Height     => Image_Height,
                                                                                others     => <>).Val,
                                              FT801.Display_List.Bitmap_Size'(Filter  => FT801.Display_List.NEAREST,
                                                                              Wrapx   => FT801.Display_List.BORDER,
                                                                              WrapY   => FT801.Display_List.BORDER,
                                                                              Width   => Image_Width,
                                                                              Height  => Image_Height,
                                                                              others  => <>).Val,
                                              FT801.Display_List.Cmd_Begin'(Prim    => FT801.Display_List.BITMAPS,
                                                                            others  => <>).Val,
                                              FT801.Display_List.ColorRGB'(Red    => 255,
                                                                           Blue   => 255,
                                                                           Green  => 255,
                                                                           others => <>).Val,
                                              FT801.Display_List.Vertex2ii'(X      => Image_Pos_X,
                                                                            Y      => Image_Pos_Y,
                                                                            Handle => 0,
                                                                            Cell   => 0,
                                                                            others => <>).Val,
                                              FT801.Display_List.Cmd_End'(others => <>).Val,
                                              FT801.Display_List.Display'(others => <>).Val,
                                              FT801.Coproc.CMD_DLSWAP));
      FT801.Wait_For_Coproc_Sync (This => Screen);
      Wait (Period => Milliseconds (2));

   end loop;

end Main;
