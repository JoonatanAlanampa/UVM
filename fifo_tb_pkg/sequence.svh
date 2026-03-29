// ----------------------------------------------------------------------------
// sequence.svh
// ----------------------------------------------------------------------------
// UVM sequence class
// Defines the transactions to be driven to the DUT
// ----------------------------------------------------------------------------
// Parameters (REQ,RSP) (request, response).
// RSP = REQ if not specified otherwise
// ----------------------------------------------------------------------------
// Note that sequences and transactions are objects, not components.
// - Different registration macro
// - Must have a default name in the constructor, no parent
// ----------------------------------------------------------------------------

class basic_sequence extends uvm_sequence #(transaction);
    `uvm_object_utils(basic_sequence)

    function new(string name = "");
        super.new(name);
    endfunction: new

    task body;
        // handle for a transaction object
        transaction tx;
        
        // read empty FIFO
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // read empty FIFO
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);

        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 3;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
	// make a write and a read simultaneously
	tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 5;
        tx.write_enable = 1;
        tx.read_enable = 1;
        finish_item(tx);
        
        // idle
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 0;
        finish_item(tx);
        
	// make a write testing number limits
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 4294967295;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write testing number limits
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 2294967295;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write testing number limits
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 3294967295;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // test to make FIFO full and still write
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 11;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a write 
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.data_to_DUT = 6;
        tx.write_enable = 1;
        tx.read_enable = 0;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);
        
        // make a read
        tx = transaction::type_id::create("tx");
        start_item(tx);
        tx.write_enable = 0;
        tx.read_enable = 1;
        finish_item(tx);

    endtask: body

endclass: basic_sequence