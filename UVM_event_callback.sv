//-------------------------------------------------------------------------
//      UVM EVENT CALLBACK EXAMPLE - 4
//-------------------------------------------------------------------------


`include "uvm_macros.svh"
import uvm_pkg::*;

class event_callback extends uvm_event_callback;
   
  `uvm_object_utils(event_callback)
   
  function new(string name = "event_callback");
    super.new(name);
  endfunction

  //---------------------------------------
  // pre trigger method
  //---------------------------------------
  virtual function bit pre_trigger(uvm_event e,uvm_object data);
    `uvm_info(get_type_name(),$sformatf(" [Callback] Inside event pre_trigger callback"),UVM_LOW)
  endfunction
  
  //---------------------------------------
  // post trigger method
  //---------------------------------------
  virtual function void post_trigger(uvm_event e,uvm_object data);
    `uvm_info(get_type_name(),$sformatf(" [Callback] Inside event post_trigger callback"),UVM_LOW)
  endfunction

endclass



class component_a extends uvm_component; 
  
  `uvm_component_utils(component_a)
  
  uvm_event      ev;
  event_callback ev_cb;
  
  //--------------------------------------- 
  // Constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //---------------------------------------
  // run_phase 
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    ev_cb = new("ev_cb");
    
    ev = uvm_event_pool::get_global("ev_ab");
    ev.add_callback(ev_cb);
    
    `uvm_info(get_type_name(),$sformatf(" Before triggering the event"),UVM_LOW)
    #10;
    
    ev.trigger();
    
    `uvm_info(get_type_name(),$sformatf(" After triggering the event"),UVM_LOW)

    phase.drop_objection(this);
  endtask : run_phase

endclass : component_a


class basic_test extends uvm_test;

  `uvm_component_utils(basic_test)

  event_callback ev_cb; //Step-1: Declaring the event callback
  uvm_event      ev;

  //---------------------------------------
  // Components Instantiation
  //---------------------------------------
  component_a comp_a;
  
  //---------------------------------------
  // Constructor
  //---------------------------------------
  function new(string name = "basic_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  //---------------------------------------
  // build_phase
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    comp_a = component_a::type_id::create("comp_a", this);
    
    //Step-2. Creating the event callback
    ev_cb = new("ev_cb");

    ev = uvm_event_pool::get_global("ev_ab");

    //Step-3. Registering callback with event
    ev.add_callback(ev_cb);
  endfunction : build_phase
//---------------------------------------
  // end_of_elobaration phase
  //---------------------------------------
  virtual function void end_of_elaboration();
    //print's the topology
    print();
  endfunction
endclass : basic_test

module test;

        basic_test test1;

        initial begin
                test1 = new("test1");
                run_test();
        end
endmodule

