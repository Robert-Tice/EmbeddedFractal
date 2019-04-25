with FT801;

with Screen_Settings;

package body Screen_Isr is

   protected body ISR_Body is
         
      procedure Handler
      is
         ISR_Flags : FT801.Interrupts;
      begin
         if Interrupt_Line.Read_Interrupt_Status then
            ISR_Flags := FT801.Read_Interrupts (This => Screen_Settings.Screen);
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
