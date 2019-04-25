with System;

with SAM.Device;

with HAL; use HAL;
with HAL.GPIO;
with HAL.SPI; use HAL.SPI;

with SAM.GPIO;
with SAM.SPI;
with FT801;

with Fractal_Impl; use Fractal_Impl;
with Image_Types; use Image_Types;

with Screen_ISR;
with Screen_Settings; use Screen_Settings;

procedure Main
is
   
   Viewport    : Image_Types.Viewport_Info := (Width  => Image_Width,
                                               Height => Image_Height,
                                               Zoom   => <>,
                                               Center => (X => Image_Width / 2,
                                                          Y => Image_Height / 2)); 

   MISO  : SAM.GPIO.GPIO_Point renames SAM.Device.PD20;
   MOSI  : SAM.GPIO.GPIO_Point renames SAM.Device.PD21;
   SPCK  : SAM.GPIO.GPIO_Point renames SAM.Device.PD22;
   NPCS1 : SAM.GPIO.GPIO_Point renames SAM.Device.PD25;

   SPI_Cfg_Init : SAM.SPI.Configuration := (Baud           => 10_000_000,
                                            Tx_On_Rx_Empty => False,
                                            others         => <>);
   
   SPI_Cfg      : SAM.SPI.Configuration := (Baud           => 30_000_000,
                                            Tx_On_Rx_Empty => False,
                                            others         => <>);
   
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
                                            Output_Type => Open_Drain));
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
      Offset : Buffer_Offset;
      Screen_Data : UInt8_Array (1 .. Fractal_Impl.Buffer_Size)
        with Address => RawData.all'Address;
   begin
      FT801.Initialize (This => Screen,
                        Settings => Screen_Cfg);
      
      SAM.SPI.Configure (This => Screen_Settings.SPI_Port,
                         Cfg  => SPI_Cfg);
      
      FT801.Display_On (This => Screen);

      --        FT801.Draw_Rectangle (This => Screen,
      --                              Lower_Left => FT801.Screen_Coordinate'(X => 0,
      --                                                               Y => Header_Height),
      --                              Upper_Right => FT801.Screen_Coordinate'(X => Screen_Width,
      --                                                                Y => 0),
      --                              Fill => True);
      --  This is the fixed point button
      --  Screen.Draw_Button ();
      --  this is the floating point button
      -- Screen.Draw_Button ();
      
      --  this is the reset zoom button
      --      Screen.Draw_Button ();
      
      Offset := Fractal_Impl.Compute_Image;
      FT801.Draw_Bitmap (This => Screen,
                         Format => Ft801.PALETTED,
                         Width => Image_Width,
                         Height => Image_Height,
                         Img => Screen_Data);
   end Initialize_Screen;
   
begin

   Initialize_GPIOs;
   Initialize_SPI;
   Initialize_Fractal;
   
   Initialize_Screen;
   
   loop
      null;
   end loop;
end Main;
