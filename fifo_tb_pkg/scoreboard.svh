// ----------------------------------------------------------------------------
// scoreboard.svh
// ----------------------------------------------------------------------------
// UVM scoreboard class
// ----------------------------------------------------------------------------

class scoreboard extends uvm_scoreboard;

    // Registration macro
    `uvm_component_utils(scoreboard)

    // Analysis export declaration
    uvm_analysis_imp #(transaction, scoreboard) analysis_export;

    // FIFO reference depth (default)
    localparam int ref_depth = 5;

    // Model queue
    bit [31:0] model[$];

    // transaction variable to be sampled for coverage statistics
    transaction sample_tx;

    // Constructor
    function new(string name, uvm_component parent);

        super.new(name,parent);

        sample_tx = transaction::type_id::create("sample_tx", this);

        // Analysis export creation
        analysis_export = new("analysis_export", this);
        
    endfunction: new

    // Build phase
    function void build_phase(uvm_phase phase);

        `uvm_info("scoreboard", "Created scoreboard", UVM_HIGH)

    endfunction: build_phase

    // Write function
    function void write(transaction t);

        // Helper variables
        int size, size_after; 
        bit write_now, read_now;

        // Copy transaction
        sample_tx.copy(t);

        // The amount of data currently in FIFO
        size = model.size();

        // Determine whether write is possible this cycle or not
        if (sample_tx.write_enable == 1 && size < ref_depth) begin
            write_now = 1;
        end
        else begin
            write_now = 0;
        end

        // Determine whether read is possible this cycle or not
        if (sample_tx.read_enable == 1 && size > 0) begin
            read_now = 1;
        end
        else begin
            read_now = 0;
        end

        // Reset behavior tests
        if (sample_tx.rst_n == 0) begin

            model.delete();

            if (sample_tx.empty != 1) begin
                `uvm_error("scoreboard", "Empty signal should be high after reset as reset empties the FIFO")
            end
            if (sample_tx.full != 0) begin
                `uvm_error("scoreboard", "Full signal should be low after reset as reset empties the FIFO")
            end
            if (sample_tx.one_p != 0) begin
                `uvm_error("scoreboard", "One place signal should be low after reset as reset empties the FIFO")
            end
            if (sample_tx.one_d != 0) begin
                `uvm_error("scoreboard", "One data signal should be low after reset as reset empties the FIFO")
            end
            return;
        end

        // Update model
        if (read_now) begin
            void'(model.pop_front());
        end
        if (write_now) begin
            model.push_back(sample_tx.data_to_DUT);
        end

        size_after = model.size();
        
        // Verify data_out (look-ahead FIFO)
        if (size > 0 && size_after > 0 && sample_tx.data_from_DUT != model[0]) begin
        	`uvm_error("scoreboard", "Data output is not the oldest data in FIFO")
        end
        
        // Verify DUT status flags
        if (sample_tx.empty != (size_after == 0)) begin
            `uvm_error("scoreboard", "Empty signal is not same for DUT and model")
        end
        if (sample_tx.full != (size_after == ref_depth)) begin
            `uvm_error("scoreboard", "Full signal is not same for DUT and model")
        end
        if (sample_tx.one_p != (size_after == ref_depth-1)) begin
            `uvm_error("scoreboard", "One place signal is not same for DUT and model")
        end
        if (sample_tx.one_d != (size_after == 1)) begin
            `uvm_error("scoreboard", "One data signal is not same for DUT and model")
        end
        
    endfunction: write

endclass
