// ----------------------------------------------------------------------------
// coverage_collector.svh
// ----------------------------------------------------------------------------
// UVM coverage collector class
// ----------------------------------------------------------------------------

class coverage_collector extends uvm_subscriber #(transaction);
    // Registration macro
    `uvm_component_utils(coverage_collector)

    // transaction variable to be sampled for coverage statistics
    transaction sample_tx;

    // covergroup
    covergroup cg;

        // coverpoints for all signals
        c_data_to_DUT : coverpoint sample_tx.data_to_DUT;
        c_data_from_DUT : coverpoint sample_tx.data_from_DUT;
	c_we_out : coverpoint sample_tx.write_enable;
	c_re_out : coverpoint sample_tx.read_enable;
	c_full_in : coverpoint sample_tx.full;
	c_one_p_in : coverpoint sample_tx.one_p;
	c_empty_in : coverpoint sample_tx.empty;
	c_one_d_in : coverpoint sample_tx.one_d;
	c_rst_n : coverpoint sample_tx.rst_n;

        // transition bin for a control signal coverpoint
        c_tb_we_out : coverpoint sample_tx.write_enable {
            bins we_rise = (0 => 1);
            bins we_fall = (1 => 0);
        }

        // transition sequence bin for a control signal coverpoint
        c_tsb_re_out : coverpoint sample_tx.read_enable {
            bins re_seq = (0 => 1 => 0);
        }

        // cross of control signal coverpoints
        c_we_re : cross c_we_out, c_re_out;

    endgroup: cg

    // Constructor
    function new(string name, uvm_component parent);

        super.new(name,parent);
        sample_tx = transaction::type_id::create("sample_tx", this);
        cg = new();
        
    endfunction: new

    // Build phase
    function void build_phase(uvm_phase phase);

        `uvm_info("coverage collector", "Created coverage collector", UVM_HIGH)

    endfunction: build_phase

    // Write function
    function void write(transaction t);

        // Copy transaction
        sample_tx.copy(t);
        cg.sample();

    endfunction: write

endclass