pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;

package body ada_main is

   E005 : Short_Integer; pragma Import (Ada, E005, "ada__tags_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "system__soft_links_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "system__exception_table_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "system__bb__timing_events_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "ada__streams_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "system__finalization_root_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "ada__finalization_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "system__storage_pools_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "system__finalization_masters_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "ada__real_time_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "system__pool_global_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "system__tasking__protected_objects_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "system__tasking__protected_objects__multiprocessors_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "system__tasking__restricted__stages_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "hal__gpio_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "hal__spi_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "ft801_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "ft801__registers_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "ft801__display_list_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "ft801__coproc_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "fractal_E");
   E130 : Short_Integer; pragma Import (Ada, E130, "julia_set_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "sam__pmc_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "sam__gpio_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "sam__spi_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "sam__device_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "screen_settings_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "fractal_impl_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "screen_isr_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");
      procedure Install_Restricted_Handlers_Sequential;
      pragma Import (C,Install_Restricted_Handlers_Sequential, "__gnat_attach_all_handlers");

      Partition_Elaboration_Policy : Character;
      pragma Import (C, Partition_Elaboration_Policy, "__gnat_partition_elaboration_policy");

      procedure Activate_All_Tasks_Sequential;
      pragma Import (C, Activate_All_Tasks_Sequential, "__gnat_activate_all_tasks");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := 'F';
      Partition_Elaboration_Policy := 'S';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, True, True, False, False, False, False, True, 
           False, False, False, False, False, False, False, True, 
           True, False, False, False, False, False, True, False, 
           False, False, False, False, False, False, False, False, 
           True, True, False, False, True, True, False, False, 
           False, True, False, False, False, False, True, False, 
           True, True, False, False, False, False, True, True, 
           True, True, True, False, True, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, True, False, False, 
           False, False, False, False, False, False, True, True, 
           False, True, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, False, False, False, True, True, False, False, 
           False, False, False, True, True, True, True, False, 
           False, False, False, False, True, True, False, True, 
           True, False, True, True, False, True, False, False, 
           False, False, False, True, False, False, True, False, 
           False, False, True, True, False, False, False, True, 
           False, False, False, True, False, False, False, False, 
           False, False, False, False, False, True, True, True, 
           False, False, True, False, True, True, True, False, 
           True, True, False, False, True, True, True, False, 
           False, True, False, False, False, True, False, False, 
           False, False, True, False),
         Count => (0, 0, 0, 1, 0, 0, 0, 0, 1, 0),
         Unknown => (False, False, False, False, False, False, False, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 1;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E066 := E066 + 1;
      Ada.Tags'Elab_Body;
      E005 := E005 + 1;
      System.Bb.Timing_Events'Elab_Spec;
      E054 := E054 + 1;
      E068 := E068 + 1;
      Ada.Streams'Elab_Spec;
      E149 := E149 + 1;
      System.Finalization_Root'Elab_Spec;
      E157 := E157 + 1;
      Ada.Finalization'Elab_Spec;
      E155 := E155 + 1;
      System.Storage_Pools'Elab_Spec;
      E159 := E159 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E152 := E152 + 1;
      Ada.Real_Time'Elab_Body;
      E135 := E135 + 1;
      System.Pool_Global'Elab_Spec;
      E161 := E161 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E116 := E116 + 1;
      System.Tasking.Protected_Objects.Multiprocessors'Elab_Body;
      E124 := E124 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E199 := E199 + 1;
      HAL.GPIO'ELAB_SPEC;
      E147 := E147 + 1;
      HAL.SPI'ELAB_SPEC;
      E164 := E164 + 1;
      E143 := E143 + 1;
      E133 := E133 + 1;
      E141 := E141 + 1;
      E139 := E139 + 1;
      E112 := E112 + 1;
      E130 := E130 + 1;
      E171 := E171 + 1;
      SAM.GPIO'ELAB_SPEC;
      SAM.GPIO'ELAB_BODY;
      E169 := E169 + 1;
      SAM.SPI'ELAB_SPEC;
      SAM.SPI'ELAB_BODY;
      E179 := E179 + 1;
      SAM.DEVICE'ELAB_SPEC;
      E167 := E167 + 1;
      Screen_Settings'Elab_Spec;
      E131 := E131 + 1;
      Fractal_Impl'Elab_Spec;
      E110 := E110 + 1;
      Screen_Isr'Elab_Spec;
      E192 := E192 + 1;
      Install_Restricted_Handlers_Sequential;
      Activate_All_Tasks_Sequential;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   procedure main is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
   end;

--  BEGIN Object file/option list
   --   /media/psf/development/ada_dev/EmbeddedFractal/obj/Debug/screen_settings.o
   --   /media/psf/development/ada_dev/EmbeddedFractal/obj/Debug/fractal_impl.o
   --   /media/psf/development/ada_dev/EmbeddedFractal/obj/Debug/screen_isr.o
   --   /media/psf/development/ada_dev/EmbeddedFractal/obj/Debug/main.o
   --   -L/media/psf/development/ada_dev/EmbeddedFractal/obj/Debug/
   --   -L/media/psf/development/ada_dev/EmbeddedFractal/obj/Debug/
   --   -L/media/psf/development/AdaCore/Ada_Drivers_Library/examples/shared/common/
   --   -L/media/psf/development/ada_dev/EmbeddedFractal/AdaFractalLib/lib/
   --   -L/media/psf/development/AdaCore/Ada_Drivers_Library/boards/samv71_xplained/obj_lib_Debug/
   --   -L/home/tice/opt/GNAT/2018-arm-elf/arm-eabi/lib/gnat/ravenscar-full-samv71/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
