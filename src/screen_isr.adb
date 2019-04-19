with FT801;


package body Screen_Isr is

   protected body ISR_Body is
         
      procedure Handler
      is
         ISR_Flags : FT801.Interrupt_Flags;
      begin
         if Interrupt_Line.Periph.PIO_ISR.Arr (Interrupt_Line.Pin) then
            ISR_Flags := Screen.Read_Interrupts;
            if ISR_Flags.Swap then
               --  Display list swap occurred
               --  TODO: fill this in
               null;
            end if;
            if ISR_Flags.Tag then
               --  Touch-screen tag value changed
               --  TODO: fill this in
               null;
            end if;
            if ISR_Flags.Sound then
               --  Sound effect ended
               --  TODO: fill this in
               null;
            end if;
            if ISR_Flags.Playback then
               --  Audio playback ended
               --  TODO: fill this in
               null;
            end if;
            if ISR_Flags.CmdEmpty then
               --  Command FIFO empty
               --  TODO: fill this in
               null;
            end if;
            if ISR_Flags.CmdFlag then
               --  Command FIFO flag
               --  TODO: fill this in
               null;
            end if;
            if ISR_Flags.ConvComplete then
               --  Touch-screen conversions complete
               --  TODO: fill this in
               null;
            end if;
         end if;
      end Handler;
   end ISR_Body;
   
end Screen_Isr;
