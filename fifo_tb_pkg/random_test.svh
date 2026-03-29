// ----------------------------------------------------------------------------
// random_test.svh
// ----------------------------------------------------------------------------
// UVM run random sequence until coverage or time limit is reached
// ----------------------------------------------------------------------------

class random_test extends test_base;
    `uvm_component_utils(random_test)

    // Test limits
    int cov_limit = 80;
    time time_limit = 100ns;
    bit stop = 0;

    // random sequence handle
    random_sequence rseq_h;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    task run_phase(uvm_phase phase);

        int coverage;

        // raise objection to notify that the testing isn't done yet
        phase.raise_objection(this);

        fork 
          
          begin

            // create random sequence
            rseq_h = random_sequence::type_id::create("rseq_h");
            
            // Keep sequencer running
            while(!stop) begin

              // start the sequencer
              rseq_h.start( env_h.agent_h.seqr_h );

            end

          end

          begin

            forever begin
              
              // Polling rate, poll every 10 cycles
              #20ns;

              // Get coverage data
              coverage = env_h.cov_h.cg.get_coverage();

              // Check if coverage limit is reached
              if(coverage >= cov_limit) begin

                `uvm_info("random_test", "Coverage limit reached", UVM_HIGH)
                stop = 1;
                break;

              end

              // Check if time limit is reached
              if($time >= time_limit) begin
                
                `uvm_info("random_test", "Time limit reached", UVM_HIGH)
                stop = 1;
                break;

              end

            end

          end

        join_any

        disable fork;

        // wait 1 cycle before ending the simulation
        #2;

        // ready to stop
        phase.drop_objection(this);

    endtask: run_phase

endclass: random_test