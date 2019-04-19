package body Fractal_Impl is

   procedure Init (Viewport : Viewport_Info) is
   begin
      Float_Julia_Fractal.Init (Viewport => Viewport);
      Fixed_Julia_Fractal.Init (Viewport => Viewport);
   end Init;
   
   function Compute_Image return Buffer_Offset
   is
      Ret : Buffer_Offset;
   begin
      
      case Comp_Type is
         when Fixed_Type =>
            Fixed_Julia_Fractal.Increment_Frame;
            Fixed_Julia_Fractal.Calculate_Image 
              (Buffer => RawData);
            Ret := Fixed_Julia_Fractal.Get_Buffer_Size;
         when Float_Type =>
            Float_Julia_Fractal.Increment_Frame;
            Float_Julia_Fractal.Calculate_Image 
              (Buffer => RawData);
            Ret := Float_Julia_Fractal.Get_Buffer_Size;
      end case;
       
      return Ret;
   end Compute_Image;
   
   
end Fractal_Impl;
