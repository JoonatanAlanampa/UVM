// ----------------------------------------------------------------------------
// monitor.svh
// ----------------------------------------------------------------------------
// UVM monitor class
// ----------------------------------------------------------------------------

class monitor extends uvm_monitor;
    // Registration macro
    `uvm_component_utils(monitor)

    uvm_analysis_port #(transaction) ap;

    dut_config dut_cfg;
    virtual dut_if dut_vi;

    // Constructor
    function new(string name, uvm_component parent);

        super.new(name,parent);
        
    endfunction: new

    // Build phase
    function void build_phase(uvm_phase phase);

        `uvm_info("monitor", "Created monitor", UVM_HIGH)

        ap = new("ap", this);

        if( !uvm_config_db #(dut_config)::get(this, "","dut_configuration", dut_cfg) )
            `uvm_fatal("NOVIF", "No virtual interface set");

        dut_vi = dut_cfg.dut_vi;

    endfunction: build_phase

    // Run phase
    task run_phase(uvm_phase phase);

        forever begin

            transaction tx;
            @(posedge dut_vi.clk);
            #0;
            tx = transaction::type_id::create("tx");
            tx.data_to_DUT = dut_vi.data_to_DUT;

            tx.data_from_DUT = dut_vi.data_from_DUT;
	    tx.write_enable = dut_vi.we_out;
	    tx.read_enable = dut_vi.re_out;
	    tx.full = dut_vi.full_in;
	    tx.one_p = dut_vi.one_p_in;
	    tx.empty = dut_vi.empty_in;
	    tx.one_d = dut_vi.one_d_in;
	    tx.rst_n = dut_vi.rst_n;

            // Transaction log
            `uvm_info("tlog", tx.convert2string(), UVM_NONE)

	        ap.write(tx);

            `uvm_info("monitor", "Got data", UVM_HIGH)

        end

    endtask: run_phase

endclass