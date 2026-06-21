# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 20 ns (50 MHz)
    clock = Clock(dut.clk, 20, unit="ns")
    cocotb.start_soon(clock.start())

    # Initial values
    dut.ena.value = 1
    dut.dummy_in.value = 0
    dut.uio_in.value = 0
    dut.cs.value = 1
    dut.sck.value = 0
    dut.mosi.value = 0

    # Reset
    dut._log.info("Reset")
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    # Write pre register via SPI
    dut._log.info("Write to SPI")
    dut.cs.value = 0
    await ClockCycles(dut.clk, 5)
    dut.mosi.value = 1
    dut.sck.value = 0
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 1
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 0
    await ClockCycles(dut.clk, 5)
    dut.cs.value = 1

    # Test output
    await ClockCycles(dut.clk, 1000)


    # Write pre register via SPI
    dut._log.info("Write to SPI")
    dut.cs.value = 0
    dut.mosi.value = 1
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 0
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 1
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 0
    dut.mosi.value = 0
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 1
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 0
    dut.mosi.value = 1
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 1
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 0
    await ClockCycles(dut.clk, 5)
    dut.cs.value = 1

    # Test output
    await ClockCycles(dut.clk, 5000)

    # Write pre register via SPI
    dut._log.info("Write to SPI")
    dut.cs.value = 0
    await ClockCycles(dut.clk, 5)
    dut.mosi.value = 1
    dut.sck.value = 0
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 1
    await ClockCycles(dut.clk, 5)
    dut.sck.value = 0
    await ClockCycles(dut.clk, 5)
    dut.cs.value = 1

    # Test output
    await ClockCycles(dut.clk, 1000)