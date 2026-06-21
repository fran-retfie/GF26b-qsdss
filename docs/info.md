<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works
This project generates two sinusoidal waveforms with a fixed 90° phase offset (I/Q signals) using Direct Digital Synthesis (DDS) techniques.
The output is presented on output in Pulse Code Modulation via two first order Sigma-Delta modulators.
DSS block can be prescaled by sending the prescaler value through SPI port.

![image](scheme.drawio.png)

## How to test

Explain how to use your project

## External hardware

List external hardware used in your project (e.g. PMOD, LED display, etc), if any
