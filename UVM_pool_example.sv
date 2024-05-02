//------------------------------------------------------------------------------
//        UVM POOL EXAMPLE - 1
//------------------------------------------------------------------------------

`include "uvm_macros.svh"
import uvm_pkg::*;

function void emp_exists(uvm_pool #(string, int) emp_pool, string emp_name);
  int is_emp_exist;
  is_emp_exist = emp_pool.exists(emp_name);
    `uvm_info("emp_pool", $sformatf("is_emp_exist = %0d", is_emp_exist), UVM_LOW);
    if(is_emp_exist) begin
      `uvm_info("emp_pool", $sformatf("%s exists in the emp_pool", emp_name,), UVM_LOW);
    end
    else begin
      `uvm_info("emp_pool", $sformatf("%s does not exist in the emp_pool", emp_name), UVM_LOW);
    end
endfunction

module pool_example;
  uvm_pool #(string, int) emp_pool; // key = string and item = int
                                    // key = emp_name and item = emp_id
  string emp_name;
  int T;
  
  initial begin
    //run_test();
    emp_pool = new("emp");
    
    // add
    emp_pool.add("Angel", 1001);
    emp_pool.add("Bob", 1002);
    emp_pool.add("Charlie", 1003);
    emp_pool.add("David", 1004);
    
    //Override
    emp_pool.add("Angel", 1005);
    
    //add
    emp_pool.add("Mark", 1006);
    
    // Exists
    emp_exists(emp_pool, "John");
    emp_exists(emp_pool, "Bob");
        
    
    //get
    `uvm_info("emp_pool", $sformatf("get: emp_pool[\"Angel\"] = %0d", emp_pool.get("Angel")), UVM_LOW);
    
    //get_global
    emp_name = "Bob";
    emp_pool.get_global(emp_name);
    `uvm_info("emp_pool", $sformatf("get_global: emp_pool[\"Bob\"] = %s", emp_name), UVM_LOW);
    
    //num
    `uvm_info("emp_pool", $sformatf("Number of entries in emp_pool = %0d", emp_pool.num()), UVM_LOW);
  end
endmodule
