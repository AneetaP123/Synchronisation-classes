//------------------------------------------------------------------------
//        UVM EVENT POOL EXAMPLE - 2
//------------------------------------------------------------------------

`include "uvm_macros.svh"

module top;
  import uvm_pkg::*;
  uvm_event ev;
  
  initial begin
    ev = uvm_event_pool::get_global("ev_ab");
    #10 ev.trigger();
    $display("%t: event ev triggered", $time);
  end
  
  initial begin
    string ev_name = "EVENT_X";
    // get a reference to the global singleton object by 
    // calling a static method
    static uvm_event_pool ev_pool = uvm_event_pool::get_global_pool();

    // either create a uvm_event or return a reference to it
    if(ev_pool.exists(ev_name)) begin
      `uvm_info("TB", $sformatf("event named = %s EXISTS", ev_name), UVM_NONE)
    end
    else begin
      `uvm_info("TB", $sformatf("event named = %s DOES NOT EXISTS",ev_name ), UVM_NONE)
    end
    
    ev_name = "ev_ab";
    
    if(ev_pool.exists(ev_name)) begin
      `uvm_info("TB", $sformatf("event named = %s EXISTS", ev_name), UVM_NONE)
    end
    else begin
      `uvm_info("TB", $sformatf("event named = %s DOES NOT EXISTS",ev_name ), UVM_NONE)
    end
    
    
    // wait for the trigger
    ev.wait_trigger();
    $display("%t: event ev trigger received", $time);
  end
endmodule
