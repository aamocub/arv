# (a)lfonso (r)isc-(v) => ¡arv!

This project has the goal of being an educational project to help myself learn in much more depth the inner-workings of
a modern CPU.

## Features of the ARV 32-bit CPU.

- 32-bit architecture followign the RISC-V ISA.
- Support for the base ISA.
- No cache.
- No branch prediction.
- 5-stage pipeline (Instruction Fetch, Decode, Execution, Memory access and WriteBack).
- No superscalar.
- In-order execution.
 
## Simulation, testing and verilator.

The development workflow that I use requires the use of VSCode. This is because the best LSP server I found comes from
[this VSCode extension](https://marketplace.visualstudio.com/items?itemName=mshr-h.VerilogHDL), which mainly uses Ctags,
but no other LSP has work reasonably well in that department.
 
## Modelling style guidelines.

Try to follow the [OpenCore modelling guideline](https://cdn.opencores.org/downloads/opencores_coding_guidelines.pdf) as
close as possible/reasonable.

Rules to remember/follow:
- Reset signals active on high.
- All input and output ports have to end with `*_i` or `*_o` respectively.
- If a signal is active low, then the corresponing port should be `*_ni` or `*_no`.
- Signals whose purpose is to interconnect modules should have in the name the modules which they are coming from or the
  modules where they are going to (e.g. `wire push_data_from_fifo`).
- Comment the code extensively and reasonably. Don't explain the code, state what is doing in simple terms and why is it
  doing it.
- Do NOT leave comments like `// TODO` or `// NOTE`.
- Wire signals internal to modules should end with a `_w` or `_r` depending on if they are wires or registers,
  respectively.
- Unless required, avoid having a wire output that extracts the value from an internal register. Just use a register
  output.