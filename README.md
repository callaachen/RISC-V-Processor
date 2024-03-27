**Designed in my Intro to Digital Logic Lab Class**

Here is a complete design of the RISC-V Single Cycle Processor that I have made during my intro to digital logic class at UC Irvine. I wrote this code all in Verilog, which is a hardware description language. 


**Descriptions of all Lower Level Modules**
__Half Adder__: A half adder has a set of two 1-bit inputs (A and B) and a set of two 1-bit outputs (Sum and Cout). The objective of the half-adder is adding the 1-bit inputs together producing the outputs representing the sum and carry out of the 1-bit addition. The 1-bit addition depends on the two inputs. 

__Multiplexer 2 to 1__: A 2 to 1 multiplexer is a combination circuit that has two 1-bit inputs D1 and D2, a 1-bit control signal S, and a 1-bit output Y. The control signal S determines which input is transmitted to output Y. For example if S = 0, the output is connected to D1, and if S = 1, the output is connected to D2. 

__Flip Flop__: A D-Flip Flop is used to delay the change of state of its input signal q until the next rising edge of a clock timing the signal occurs. It is a building block shift register. It operates on two states which are Set (binary value 1) and Reset (binary value 0). It can be either synchronous involving the usage of a clock and asynchronous which doesn’t depend on a clock. The data input d controls the flip flop, and the clock input clk determines when the flip flop samples and stores data. The purpose of D-flip flops are used for memory storage, counters, and shift registers. They ensure accurate timing and synchronization due to being edge-triggered. Lastly, we were working with multiple D-Flip Flops, then the more complex circuits we were able to make. Displayed below is a block diagram of the D-Flip Flop and the D-Flip Flop with the rising-edge trigger. 

__ALU__: An ALU is a fundamental component of a central processing unit (CPU) that is responsible for performing arithmetic and logic operations on input data. The functionality of the ALU is taking binary inputs, executing operations such as adding and subtracting, and creating, distributing, and storing binary output. The ALU can also perform bitwise operations, such as AND and OR functions. It receives two 32-bit inputs (a and b) and produces a 32-bit output (our result), and it is based on 4-bit control code (4-bit control lines) that decides what ALU operation is to be executed. Below is the block diagram for the ALU that I followed while designing it in Verilog.

__Instruction Memory__: The instruction memory has only input the address line and one output the instruction line which we can read from memory. In Verilog, the input has 8 bits defined as “addr”, while the output has 32 bits with the name “instruction”.  The purpose of having an instruction memory is being a repository of program instruction, enabling precise execution, and having efficient handling in digital systems.

__Register File__: The register file is the central structure to the datapath consisting of a set of registers that can be read and written by providing a register number to be accessed. The block diagram displayed below has three 1-bit inputs (reset, clk, and rg_wrt_en), four 5-bit inputs (rg_rd_addr1, rg_rd_addr2, rg_wrt_addr, and rg_wrt_data), and two 32-bit outputs (rg_rd_data1 and rg_rd_data2). To read from a register file, we only need a register number; however, if we were to write a register, we need 3 inputs. These three inputs are a register number, data to be written, and a clock controlling the writing to the register. By having multiple registers the processor can have multiple operations. The overall purpose of the register file is to act like a temporary storage hub for data manipulation, to enable efficient execution of instructions in RISC-V processors.

__Immediate Generator__: The immediate generator receives 32-bit instruction, and based on the opcode, it will decide which bits of instruction should be interpreted as the 12-bit immediate. In RISC-V, immediate values are constraints that are part of the instruction rather than being stored in registers or memory. It typically takes a portion of instruction as input and generates the immediate value based on that input. The immediate value could represent a constant to be used in arithmetic or logical operations, an offset for memory access, or a shift amount for bitwise operations, depending on the instruction(s) being executed. By incorporating this lower-level module, the processor can efficiently handle instructions with immediate operands, ensuring that the instructions can be executed within a single clock cycle without the need for additional memory accesses or complex computation steps.

__Data Memory__: The Data Memory reads and writes into memory. It writes content from Reg2 from the RegFile into a register whose address is specified by the last 8-bits of the ALUs output. It also can read from its own register whose address is specified the same way. The read data is passed on to the last mux along with the ALU’s output. THe MUX then picks one of them and writes it abc to the register file into a register that is being specified by the instruction.

__Controller__: The controller module is vital in the RISC-V single cycle processor, as it oversees all operations during each clock cycle. It interprets instructions, determines required operations based on opcode and other fields, and decodes instructions to identify their types and associated operations (e.g., arithmetic, load/store, branch). Once decoded, the controller generates control signals to activate/deactivate specific parts of the processor like the ALU, register file, data memory, and mux to execute the operations. It also manages the sequencing of operations, ensuring correct execution order and smooth transitions between instructions, encompassing fetching, decoding, execution, and potentially writing back of instructions. Essentially, the controller functions as the processor's brain, coordinating components to execute instructions accurately and efficiently within a single clock cycle.

__ALU Controller__: The ALU Controller is responsible for managing the operations performed by the ALU during each clock cycle. It interprets the instructions decoded by the main controller and determines the specific arithmetic or logical operation based on the instruction opcode and controlling the ALU accordingly. Depending on the instruction type (such as arithmetic, logical, shift), the ALU controller selects the corresponding operation to be executed by the ALU. For example with the ADD instruction, the ALU controller configures the ALU to perform addition. The controller then selects operands from ALU operations from registers or immediate values in the instruction, preparing for processing. After processing, it manages the result, deciding when to store it, writing it back to a register, or forwarding it for further processing. The ALU controller also contains error detection logic, such as detecting overflow and underflow, and taking appropriate action if errors do occur. Ultimately, the ALU controller takes a critical role in ensuring that the arithmetic and logical operations are executed correctly. It interfaces between the controller and the ALU coordinating the execution of instructions and managing the ALU’s operation during each clock cycle.


**Description of Higher Level Modules**

__Datapath__: The datapath in a RISC-V single-cycle processor acts as the core component for executing instructions efficiently within a single clock cycle. It manages data movement between different functional units, including the ALU and registers, enabling instruction execution. This involves accessing the register file for data retrieval and storage, interacting with the control unit to coordinate activities based on the instruction being executed, and potentially incorporating pipeline stages for instruction fetch, decode, execute, and write-back. Furthermore, the datapath is optimized for performance, aiming to reduce delays and maximize parallelism while ensuring compatibility with the RISC-V instruction set architecture. Overall, it plays a pivotal role in determining the processor's performance and efficiency.

__Processor__: The processor in a RISC-V single cycle processor, often referred to as the CPU (Central Processing Unit), is the primary component responsible for executing instructions of a computer program. It serves as the brain of the computer, performing basic arithmetic, logical, control, and input/output (I/O) operations specified by the instructions in the program. The primary objective of the processor is to execute instructions of a computer program by performing four key functions in a single clock cycle. First, the processor fetches an instruction from memory based on the program counter's current value. Next, it decodes the fetched instruction to identify the operation and operands, which may involve loading or storing data, arithmetic or logical operations, or control flow changes. Then, the processor executes the specified operation, potentially performing calculations, accessing memory, or updating the program counter. Lastly, if the instruction generates a result, the processor writes it back to a register, all within the same clock cycle, making the RISC-V single cycle processor simple and easy to understand. The RISC-V single cycle processor is designed to execute one instruction in a single clock cycle, making it simple and easy to understand. 
