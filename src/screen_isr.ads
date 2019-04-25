with Ada.Interrupts.Names;

with SAM.Device;
with SAM.GPIO;

package Screen_Isr is

   Interrupt_Line   : SAM.GPIO.GPIO_Point renames SAM.Device.PC9;

   protected ISR_Body is
      procedure Handler;-- with
    --    Attach_Handler => Ada.Interrupts.Names.PIOC;
   end ISR_Body;

end Screen_Isr;
