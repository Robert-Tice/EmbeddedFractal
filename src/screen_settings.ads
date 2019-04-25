with SAM.Device;
with SAM.GPIO;
with SAM.SPI;
with FT801;

package Screen_Settings is

   Screen_Width  : constant := 480;
   Screen_Height : constant := 272;
   
   Header_Height : constant := 50;
   Button_Width  : constant := 80;
   
   Image_Height  : constant := 10;
   --  Screen_Height - Header_Height;
   Image_Width   : constant := 10;
   --  Screen_Width;
   
   SPI_Port          : SAM.SPI.SPI_Port renames SAM.Device.SPI_0_Cs1;
   
   Screen_Power_Down : SAM.GPIO.GPIO_Point renames SAM.Device.PA5;
   
   Screen      : FT801.FT801_Device (Port => SPI_Port'Access,
                                     PD   => Screen_Power_Down'Access);
   
   Screen_Cfg   : FT801.Display_Settings := (Width  => Screen_Width,
                                             Height => Screen_Height,
                                             others => <>);

end Screen_Settings;
