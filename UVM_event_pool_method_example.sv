//------------------------------------------------------------------------
//      UVM EVENT POOL EXAMPLE WITH METHODS - 3
//------------------------------------------------------------------------

`include "uvm_macros.svh"

module top;
  import uvm_pkg::*;

  
  initial begin
    // get a reference to the global singleton object by 
    // calling a static method
    static uvm_event_pool ev_pool = uvm_event_pool::get_global_pool();

   
    
    // either create a uvm_event or return a reference to it
    // (which depends on the order of execution of the two
    //  initial blocks - the first call creates the event,
    //  the second and subsequent calls return a reference to
    //  an existing event.)
    static uvm_event ev = ev_pool.get("ev");
    
   
    
    // wait (an arbitrary) 10 and then trigger the event
    #10 ev.trigger();
    $display("%t: event ev triggered", $time);
  end
  
  initial begin
    // get a reference to the global singleton object by 
    // calling a static method
    static uvm_event_pool ev_pool = uvm_event_pool::get_global_pool();   
    
    // either create a uvm_event or return a reference to it
    static uvm_event ev = ev_pool.get("ev");
    string ev_name = "ev";
    
    //static uvm_event_pool ev_pool;
    static uvm_event ev1;
    
    //add method
    ev1 = new("ev1");
    ev_pool.add("ev1",ev1);
    
    
    //exist method
    if(ev_pool.exists(ev_name)) begin
      `uvm_info("TB", $sformatf("event named = %s EXISTS", ev_name), UVM_NONE)
    end
    else begin
      `uvm_info("TB", $sformatf("event named = %s DOES NOT EXISTS",ev_name ), UVM_NONE)
    end
    
    //get method
    `uvm_info("ev_pool", $sformatf("get: ev_pool[\"ev\"] = %0d", ev_pool.get("ev")), UVM_LOW);
    
    //next method
    ev_pool.next(ev_name);
    `uvm_info("ev_pool", $sformatf("next key = %0s", ev_name), UVM_LOW);
    
    // wait for the trigger
    ev.wait_trigger();
    $display("%t: event ev trigger received", $time);
  end

endmodule
