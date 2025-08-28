# (a)lfonso (r)isc-(v) => ¡arv!

This project has the goal of being an educational project to help myself learn in much more depth the inner-workings of a modern CPU.

### Features of the ARV 32-bit CPU

- 32-bit architecture followign the RISC-V ISA.
- Support for the base ISA.
- No cache.
- No branch prediction.
- 5-stage pipeline (Instruction Fetch, Decode, Execution, Memory access and WriteBack).
- No superscalar.
- In-order execution.
 
### Modelling style guidelines

Try to follow the [OpenCore modelling guideline](https://cdn.opencores.org/downloads/opencores_coding_guidelines.pdf) as close as possible/reasonable.

Rules to remember/follow:
- Reset signals active on high.
- All input and output ports have to end with `*_i` or `*_o` respectively.
- If a signal is active low, then the corresponing port should be `*_ni` or `*_no`.
- Signals whose purpose is to interconnect modules should have in the name the modules which they are coming from or the modules where they are going to (e.g. `wire push_data_from_fifo`).
- Comment the code extensively and reasonably. Don't explain the code, state what is doing in simple terms and why is it doing it.
- Simple comments should start with `//` but documenting-style comments should start with `//!`.
- Do NOT leave comments like `// TODO` or `// NOTE`.