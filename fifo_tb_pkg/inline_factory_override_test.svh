// ----------------------------------------------------------------------------
// inline_factory_override_test.svh
// ----------------------------------------------------------------------------
// UVM factory override test class
// ----------------------------------------------------------------------------

class inline_factory_override_test extends random_test;
    `uvm_component_utils(inline_factory_override_test)

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase
	
	// Verify factory overrides
    function void start_of_simulation_phase(uvm_phase phase);
        uvm_top.print_topology();
        factory.print();
    endfunction: start_of_simulation_phase
    
    function void end_of_elaboration_phase(uvm_phase phase);

        random_sequence::type_id::set_type_override(override_sequence::get_type());

    endfunction: end_of_elaboration_phase

    task run_phase(uvm_phase phase);

        super.run_phase(phase);

    endtask: run_phase

endclass: inline_factory_override_test