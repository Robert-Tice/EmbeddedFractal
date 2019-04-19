with SAM.Device;
with SAM.GPIO;
with SAM.SPI;
with FT801;

package Screen_Settings is

   Screen_Width  : constant := 480;
   Screen_Height : constant := 272;
   
   Header_Height : constant := 50;
   Button_Width  : constant := 80;
   
   Image_Height  : constant := Screen_Height - Header_Height;
   Image_Width   : constant := Screen_Width;

end Screen_Settings;
