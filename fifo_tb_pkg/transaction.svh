// ----------------------------------------------------------------------------
// transaction.svh
// ----------------------------------------------------------------------------
// Transaction class
// Responsible for containing a single packetful of transaction data
// and the constraints for it
// ----------------------------------------------------------------------------
// Note: extending uvm_sequence_item, not its parent uvm_transaction
// ----------------------------------------------------------------------------

class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    // transaction data here (i.e. DUT's data, write_enable etc..)
    rand bit  [31:0]  data_to_DUT;
    rand bit          write_enable;
    rand bit          read_enable;
    rand bit	      rst_n;
    bit       [31:0]  data_from_DUT;
    bit               full;
    bit	              empty;
    bit	              one_p;
    bit	              one_d;

    // constraints for transaction data
    // Inspect MSB functionality
    //constraint c_data { data_to_DUT[31] == 1; }
    // write_enable signal is set high once in every 5 clock cycles on average
    //constraint c_we_dist { write_enable dist { 0 := 4 , 1 := 1 }; }
    // read_enable signal is set high once in every 10 clock cycles on average
    //constraint c_re_dist { read_enable dist { 0:= 9, 1 := 1}; }
    // Set rst_n low every 200 clock cycles on average in random_sequence
    constraint c_rst_dist { rst_n dist { 0 := 1, 1 := 199 }; }

    function new(string name = "");
        super.new(name);
    endfunction: new

    // Custom print helper function
    function string convert2string();

        string s;
        $sformat(s, "%s\n", super.convert2string());
        $sformat(s, "%s DATA_TO:\t%8h\n DATA_FROM:\t%8h\n WE:\t%8h\n RE:\t%8h\n RST:\t%8h\n FULL:\t%8h\n EMPTY:\t%8h\n ONE_PLACE:\t%8h\n ONE_DATA:\t%8h\n", 
            s, data_to_DUT, data_from_DUT, write_enable, read_enable, rst_n, full, empty, one_p, one_d);
        return s;

    endfunction:convert2string

    function void do_copy (uvm_object rhs);

        transaction rhs_;
        super.do_copy(rhs);
        $cast(rhs_,rhs);
        
        data_to_DUT = rhs_.data_to_DUT;
        write_enable = rhs_.write_enable;
        read_enable = rhs_.read_enable;
        rst_n = rhs_.rst_n;
        data_from_DUT = rhs_.data_from_DUT;
        full = rhs_.full;
        empty = rhs_.empty;
        one_p = rhs_.one_p;
        one_d = rhs_.one_d;

    endfunction

endclass: transaction