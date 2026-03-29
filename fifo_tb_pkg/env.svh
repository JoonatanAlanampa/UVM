// ----------------------------------------------------------------------------
// env.svh
// ----------------------------------------------------------------------------
// UVM environment class
// ----------------------------------------------------------------------------

class env extends uvm_env;
    `uvm_component_utils(env)

    // Component handles
    agent agent_h;
    coverage_collector cov_h;
    scoreboard score_h;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);

        // create agent
        agent_h = agent::type_id::create("agent_h",this);

        // create coverage collector
        cov_h = coverage_collector::type_id::create("cov_h",this);

        // create scoreboard
        score_h = scoreboard::type_id::create("score_h",this);

        // debug prints
        `uvm_info("env","Created environment",UVM_HIGH)

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);

        // connect agent's analysis port to the coverage collector's export
        agent_h.ap.connect(cov_h.analysis_export);

        // connect agent's analysis port to the scoreboard's export
        agent_h.ap.connect(score_h.analysis_export);

    endfunction: connect_phase
    
endclass: env
