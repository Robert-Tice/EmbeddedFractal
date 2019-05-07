package body Fractal_Impl is

   procedure Init (Viewport : Viewport_Info) is
   begin
      Float_Julia_Fractal.Init (Viewport => Viewport);
      Fixed_Julia_Fractal.Init (Viewport => Viewport);
   end Init;
   
   procedure Compute_Image (Buffer : in out Buffer_Access)
   is
   begin
      
      case Current_Computation is
         when Fixed_Type =>
      --      Fixed_Julia_Fractal.Increment_Frame;
            Fixed_Julia_Fractal.Calculate_Image 
              (Buffer => Buffer);
         when Float_Type =>
     --       Float_Julia_Fractal.Increment_Frame;
            Float_Julia_Fractal.Calculate_Image 
              (Buffer => Buffer);
      end case;
       
   end Compute_Image;
   
   procedure Increment_Frame
   is
   begin
      if Cnt_Up then
         if Frame_Counter = UInt5'Last then
            Cnt_Up := not Cnt_Up;
            return;
         else
            Frame_Counter := Frame_Counter + 1;
            return;
         end if;
      end if;

      if Frame_Counter = UInt5'First then
         Cnt_Up := not Cnt_Up;
         return;
      end if;

      Frame_Counter := Frame_Counter - 1;
   end Increment_Frame;

   procedure RGB565_Color_Pixel (Z_Escape    : Boolean;
                                 Iter_Escape : Natural;
                                 Px          : out RGB565_Pixel)
   is
      Value : constant Integer := 765 * (Iter_Escape - 1) / Max_Iterations;
   begin
      if Z_Escape then
         if Value > 510 then
            Px := RGB565_Pixel'(Red   => UInt5'Last - Frame_Counter,
                                Green => UInt6'Last,
                                Blue  => UInt5 (Value rem Integer (UInt5'Last)));
         elsif Value > 255 then
            Px := RGB565_Pixel'(Red   => UInt5'Last - Frame_Counter,
                                Green => UInt6 (Value rem Integer (UInt6'Last)),
                                Blue  => UInt5'First + Frame_Counter);
         else
            Px := RGB565_Pixel'(Red   => UInt5 (Value rem Integer (UInt5'Last)),
                                Green => UInt6'First + UInt6 (Frame_Counter),
                                Blue  => UInt5'First);
         end if;
      else
         Px := RGB565_Pixel'(Red   => UInt5'First + Frame_Counter,
                             Green => UInt6'First + UInt6 (Frame_Counter),
                             Blue  => UInt5'First + Frame_Counter);
      end if;
   end RGB565_Color_Pixel;
   
   procedure Set_Computation_Type (Comp_Type : Computation_Enum)
   is
   begin
      Current_Computation := Comp_Type;
   end Set_Computation_Type;
   
   procedure Compute_Row (Row : Natural;
                          Buffer : in out Buffer_Access)
   is
   begin
      case Current_Computation is
         when Fixed_Type =>
 --           Fixed_Julia_Fractal.Increment_Frame;
            Fixed_Julia_Fractal.Calculate_Row (Y      => Row,
                                               Idx    => Buffer'First,
                                               Buffer => Buffer);
         when Float_Type =>
 --           Float_Julia_Fractal.Increment_Frame;
            Float_Julia_Fractal.Calculate_Row (Y      => Row,
                                               Idx    => Buffer'First,
                                               Buffer => Buffer);
      end case;
      
   end Compute_Row;
   
   
end Fractal_Impl;
