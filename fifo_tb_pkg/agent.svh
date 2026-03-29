// ----------------------------------------------------------------------------
// agent.svh
// ----------------------------------------------------------------------------
// UVM agent class
// ----------------------------------------------------------------------------

class agent extends uvm_agent;
    `uvm_component_utils(agent)

    uvm_analysis_port #(transaction) ap;

    // component handles
    sequencer seqr_h;
    driver    drv_h;
    // Handle for monitor
    monitor mnt_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);

        // create analysis port
        ap = new("ap", this);

        // create components
        seqr_h = sequencer::type_id::create("seqr_h",this);
        drv_h  =    driver::type_id::create("drv_h", this);
        // Factory call instantiating a monitor object to the handle
        mnt_h  = monitor::type_id::create("mnt_h",this);

        // debug prints
        `uvm_info("agent","Created agent",UVM_HIGH)

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);

        // connect driver's port (input) to the sequencer's export (output)
        drv_h.seq_item_port.connect(seqr_h.seq_item_export);

        // connect monitor's analysis port to the agent's analysis port
        mnt_h.ap.connect(ap);

    endfunction: connect_phase

endclass: agent
