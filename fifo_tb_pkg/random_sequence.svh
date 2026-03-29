// ----------------------------------------------------------------------------
// random_sequence.svh
// ----------------------------------------------------------------------------
// UVM random sequence class
// ----------------------------------------------------------------------------

class random_sequence extends basic_sequence;
    `uvm_object_utils(random_sequence)
    
    // Generate n_trans number of transactions that are constrained in transaction.svh
    int n_trans = 100; 

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
		assert(tx.randomize());
		finish_item(tx);
        
        end

    endtask: body


endclass: random_sequence
