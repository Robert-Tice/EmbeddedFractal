with Computation_Type;
with Image_Types;
with Fractal;
with Julia_Set;
with Screen_Settings; use Screen_Settings;

with HAL; use HAL;

package Fractal_Impl is
   
   type RGB565_Pixel is record
      Red : UInt5;
      Green : UInt6;
      Blue  : UInt5;
   end record
     with Size => 16;
   
   for RGB565_Pixel use record
      Red at 0 range 11 .. 15;
      Green at 0 range 5 .. 10;
      Blue at 0 range 0 .. 4;
   end record;
   
   procedure RGB565_Color_Pixel (Z_Escape    : Boolean;
                                 Iter_Escape : Natural;
                                 Px          : out RGB565_Pixel);
   
   Max_Iterations : constant Natural := Natural (UInt5'Last / 5);
   
   package RGB565_Image_Types is new Image_Types (Pixel          => RGB565_Pixel,
                                                  Color_Pixel    => RGB565_Color_Pixel,
                                                  Max_Iterations => Max_Iterations);
   use RGB565_Image_Types;
   
   type Computation_Enum is
     (Fixed_Type, Float_Type);
   
   --   Buffer_Size : constant := Image_Width * Image_Height * Pixel_Size; 
   --   RawData     : constant Buffer_Access := new Buffer_Array (1 .. Buffer_Size);
   
   Linestride : constant Buffer_Offset := Image_Width * RGB565_Pixel'Size / 8;
   Buffer_Size : constant Buffer_Offset := Linestride * 1;
--   RowBuf : aliased Buffer_Array := (1 .. Buffer_Size => <>);
--   RawDataRow : Buffer_Access := RowBuf'Access;  

   RawDataRow : Buffer_Access := new Buffer_Array (1 .. Buffer_Size);
   
  
   
   procedure Init (Viewport : Viewport_Info);
   
   procedure Compute_Image (Buffer : in out Buffer_Access);
   
   procedure Compute_Row (Row    : Natural;
                          Buffer : in out Buffer_Access);
   
   procedure Set_Computation_Type (Comp_Type : Computation_Enum);
   
   procedure Increment_Frame;
   
private
   
   Current_Computation : Computation_Enum := Float_Type;
   
   Frame_Counter  : UInt5 := 0;
   Cnt_Up : Boolean := True;

   type Real_Float is new Float;

   function Integer_To_Float (V : Integer) return Real_Float is
     (Real_Float (V));

   function Float_To_Integer (V : Real_Float) return Integer is
     (Natural (V));

   function Float_To_Real_Float (V : Float) return Real_Float is
     (Real_Float (V));

   function Real_Float_To_Float (V : Real_Float) return Float is
      (Float (V));

   function Float_Image (V : Real_Float) return String is
     (V'Img);

   D_Small : constant := 2.0 ** (-21);
   type Real_Fixed is delta D_Small range -100.0 .. 201.0 - D_Small;

   function "*" (Left, Right : Real_Fixed) return Real_Fixed;
   pragma Import (Intrinsic, "*");

   function "/" (Left, Right : Real_Fixed) return Real_Fixed;
   pragma Import (Intrinsic, "/");

   function Integer_To_Fixed (V : Integer) return Real_Fixed is
     (Real_Fixed (V));

   function Float_To_Fixed (V : Float) return Real_Fixed is
     (Real_Fixed (V));

   function Fixed_To_Float (V : Real_Fixed) return Float is
      (Float (V));

   function Fixed_To_Integer (V : Real_Fixed) return Integer is
     (Natural (V));

   function Fixed_Image (V : Real_Fixed) return String is
      (V'Img);

   package Fixed_Computation is new Computation_Type (Real       => Real_Fixed,
                                                      "*"        => Fractal_Impl."*",
                                                      "/"        => Fractal_Impl."/",
                                                      To_Real    => Integer_To_Fixed,
                                                      F_To_Real  => Float_To_Fixed,
                                                      To_Integer => Fixed_To_Integer,
                                                      To_Float   => Fixed_To_Float,
                                                      Image      => Fixed_Image);

   package Fixed_Julia is new Julia_Set (CT               => Fixed_Computation,
                                         IT               => RGB565_Image_Types,
                                         Escape_Threshold => 100.0);

   package Fixed_Julia_Fractal is new Fractal (CT              => Fixed_Computation,
                                               IT              => RGB565_Image_Types,
                                               Calculate_Pixel => Fixed_Julia.Calculate_Pixel,
                                               Task_Pool_Size  => 0);


   package Float_Computation is new Computation_Type (Real       => Real_Float,
                                                      To_Real    => Integer_To_Float,
                                                      F_To_Real  => Float_To_Real_Float,
                                                      To_Integer => Float_To_Integer,
                                                      To_Float   => Real_Float_To_Float,
                                                      Image      => Float_Image);

   package Float_Julia is new Julia_Set (CT               => Float_Computation,
                                         IT               => RGB565_Image_Types,
                                         Escape_Threshold => 100.0);

   package Float_Julia_Fractal is new Fractal (CT              => Float_Computation,
                                               IT              => RGB565_Image_Types,
                                               Calculate_Pixel => Float_Julia.Calculate_Pixel,
                                               Task_Pool_Size  => 0);
   

end Fractal_Impl;
