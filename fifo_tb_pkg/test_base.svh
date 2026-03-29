// ----------------------------------------------------------------------------
// test_base.svh
// ----------------------------------------------------------------------------
// Instantiates the environment and runs a basic example sequence
// ----------------------------------------------------------------------------

class test_base extends uvm_test;
    `uvm_component_utils(test_base)

    // environment handle
    env env_h;
    basic_sequence seq_h;

    // configuration wrapper for DUT interface
    dut_config dut_cfg;

    // file descriptors
    protected int default_fd;
    protected int warning_fd;
    protected int error_fd;
    protected int fatal_fd;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);

        // create environment
        env_h = env::type_id::create("env_h", this);

        // create DUT configuration wrapper - no need for factory here
        dut_cfg = new();

        // attach the virtual interface to dut configuration
        if(!uvm_config_db #(virtual dut_if)::get( this, "",
                                   "dut_vi", dut_cfg.dut_vi))
        `uvm_fatal("NOVIF", "No virtual interface set");

        // share the dut configuration
        uvm_config_db #(dut_config)::set(this, "*",
                        "dut_configuration", dut_cfg);

    endfunction: build_phase

    function void start_of_simulation_phase(uvm_phase phase);

        // Open file descriptors
        default_fd = $fopen("default_file.log", "w");
        warning_fd = $fopen("warning_file.log", "w");
        error_fd = $fopen("error_file.log", "w");
        fatal_fd = $fopen("fatal_file.log", "w");

        // Set reporting actions
        uvm_top.set_report_severity_action_hier(UVM_INFO, UVM_DISPLAY | UVM_LOG);
        uvm_top.set_report_severity_action_hier(UVM_WARNING, UVM_DISPLAY | UVM_LOG);
        uvm_top.set_report_severity_action_hier(UVM_ERROR, UVM_DISPLAY | UVM_LOG | UVM_COUNT);
        uvm_top.set_report_severity_action_hier(UVM_FATAL, UVM_DISPLAY | UVM_LOG | UVM_COUNT | UVM_EXIT );

        // Send messages to files
        uvm_top.set_report_default_file_hier(default_fd);
        uvm_top.set_report_severity_file_hier(UVM_WARNING, warning_fd);
        uvm_top.set_report_severity_file_hier(UVM_ERROR, error_fd);
        uvm_top.set_report_severity_file_hier(UVM_FATAL, fatal_fd);

    endfunction: start_of_simulation_phase

    task run_phase(uvm_phase phase);

        // raise objection to notify that the testing isn't done yet
        phase.raise_objection(this);

        // create a sequence
        seq_h = basic_sequence::type_id::create("seq_h");

        // start the sequencer
        seq_h.start( env_h.agent_h.seqr_h );

        // wait 1 cycle before ending the simulation
        #2;

        // ready to stop
        phase.drop_objection(this);

    endtask: run_phase

endclass: test_base