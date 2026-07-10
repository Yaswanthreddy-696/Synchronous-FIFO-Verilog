# Synchronous FIFO using Verilog HDL

## Overview

This project implements a parameterized synchronous FIFO (First-In-First-Out) in Verilog HDL. The design supports synchronous read and write operations along with full, empty, overflow, and underflow status flags.

---

## Features

- Parameterized FIFO depth
- Parameterized data width
- Synchronous Read
- Synchronous Write
- Full Flag Generation
- Empty Flag Generation
- Overflow Detection
- Underflow Detection
- Pointer and Toggle Bit Logic

---

## Project Structure

```
fifo.v
fifo_tb.v
README.md
waveform.png
```

---

## Tools Used

- Verilog HDL
- ModelSim
- GVim

---

## Simulation

Compile the RTL and testbench in ModelSim.

Run the simulation and verify:

- Write Operation
- Read Operation
- FIFO Full
- FIFO Empty
- Overflow
- Underflow

---

## Simulation Waveform

![Waveform](waveform.png)

## Author

Yaswanth Reddy Devireddy
