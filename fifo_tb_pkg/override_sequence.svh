// ----------------------------------------------------------------------------
// override_sequence.svh
// ----------------------------------------------------------------------------
// UVM override sequence class
// ----------------------------------------------------------------------------

class override_sequence extends random_sequence;
    `uvm_object_utils(override_sequence)

    // Generate n_trans number of transactions that are constrained inline
    int n_trans = 10;

    function new(string name = "");
        super.new(name);
    endfunction: new

    task body;

        // handle for a transaction object
        transaction tx;

        // Generate the actual random sequence
        repeat (n_trans) begin
        
            tx = transaction::type_id::create("tx");
            start_item(tx);
            assert(tx.randomize() with { rst_n == 0; });
            finish_item(tx);
        
        end

        // Generate the actual random sequence
        repeat (n_trans) begin
        
            tx = transaction::type_id::create("tx");
            start_item(tx);
            assert(tx.randomize() with { rst_n == 1; data_to_DUT < 1024; });
            finish_item(tx);
        
        end

        `uvm_info("OVERRIDE_SEQUENCE", "Running override_sequence task body", UVM_HIGH)

    endtask: body


endclass: override_sequence