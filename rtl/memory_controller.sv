// --- Memory Controller Module ---
//
// This module implements a priority queue to select between the read accesses from the IF and M stages. The write
// accesses are directly transmited to the memory.
//
// The priority queue logic is implemented through a FSM whose states are defined in the `state_t` enum.
//

module memory_controller #(
    parameter MEMDATAWIDTH = 32,
    parameter MEMDEPTH     = 1024
) (
    input               clk_i,
    input               rst_i,
    // --- IF read word ---
    input               if_read_en_i,
    input      [MD-1:0] if_read_pos_i,
    output reg [MW-1:0] if_read_data_o,
    output reg          if_read_valid_o,
    // --- M read word ---
    input               m_read_en_i,
    input      [MD-1:0] m_read_pos_i,
    output reg [MW-1:0] m_read_data_o,
    output reg          m_read_valid_o,
    // --- To memory ---
    output reg          mem_read_en_o,
    output reg [MD-1:0] mem_read_pos_o,
    input      [MW-1:0] mem_read_data_i,
    input               mem_read_valid_i
);

  localparam MW = MEMDATAWIDTH;
  localparam MD = $clog2(MEMDEPTH);

  typedef enum {
    IDLE,
    PENDING,
    TRIGGER,
    TRIGGERED
  } state_t;

  // Internal signals
  wire             any_triggered_w;

  state_t          if_read;
  reg              if_read_completed_r;
  reg     [MD-1:0] if_read_pos_r;

  state_t          m_read;
  reg              m_read_completed_r;
  reg     [MD-1:0] m_read_pos_r;

  // Assignments
  assign any_triggered_w = (if_read == TRIGGERED) | (m_read == TRIGGERED);

  // Logic
  always_comb begin : if_read_process_b
    case (if_read)
      IDLE: begin
        if_read_valid_o     = 0;
        if_read_data_o      = 0;
        if_read_completed_r = 0;
        if_read_pos_r       = (if_read_en_i) ? if_read_pos_i : 0;
      end
      TRIGGER: begin
        mem_read_en_o  = 1;
        mem_read_pos_o = if_read_pos_r;
      end
      TRIGGERED: begin
        mem_read_en_o = 0;
        mem_read_pos_o = 0;
        if_read_valid_o = (mem_read_valid_i) ? 1 : 0;
        if_read_data_o = (mem_read_valid_i) ? mem_read_data_i : 0;
        if_read_completed_r = (mem_read_valid_i) ? 1 : 0;
      end
    endcase
  end
  always_comb begin : m_read_process_b
    case (m_read)
      IDLE: begin
        m_read_valid_o     = 0;
        m_read_data_o      = 0;
        m_read_completed_r = 0;
        m_read_pos_r       = (m_read_en_i) ? m_read_pos_i : 0;
      end
      TRIGGER: begin
        // verilator lint_off MULTIDRIVEN
        // This verilator comment exists due to having the IF read and M read do the same on TRIGGER. However, because
        // the logic in the FSM prevents both from being in TRIGGER at the same time, this should be fine.
        mem_read_en_o  = 1;
        mem_read_pos_o = m_read_pos_r;
        // verilator lint_on MULTIDRIVEN
      end
      TRIGGERED: begin
        mem_read_en_o = 0;
        mem_read_pos_o = 0;
        m_read_valid_o = (mem_read_valid_i) ? 1 : 0;
        m_read_data_o = (mem_read_valid_i) ? mem_read_data_i : 0;
        m_read_completed_r = (mem_read_valid_i) ? 1 : 0;
      end
    endcase
  end

  always_ff @(posedge clk_i or posedge rst_i) begin : transitions_b
    if (rst_i) begin
      if_read <= IDLE;
      m_read  <= IDLE;
    end else begin
      case (if_read)
        IDLE: if_read <= (if_read_en_i) ? PENDING : IDLE;
        PENDING: if_read <= (~any_triggered_w) ? TRIGGER : PENDING;
        TRIGGER: if_read <= TRIGGERED;
        TRIGGERED: if_read <= (if_read_completed_r) ? IDLE : TRIGGERED;
        default: if_read <= IDLE;
      endcase
      case (m_read)
        IDLE: m_read <= (m_read_en_i) ? PENDING : IDLE;
        PENDING: m_read <= (!any_triggered_w && if_read == IDLE) ? TRIGGER : PENDING;
        TRIGGER: m_read <= TRIGGERED;
        TRIGGERED: m_read <= (m_read_completed_r) ? IDLE : TRIGGERED;
        default: m_read <= IDLE;
      endcase
    end
  end
endmodule
