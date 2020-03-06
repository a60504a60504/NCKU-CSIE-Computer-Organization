# Traffic light (verilog)

- Homework for NCKU CSIE Computer Organization

```script
iverilog -o traffic_light.vvp traffic.v traffic_light_tb.v
vvp traffic_light.vvp
gtkWave traffic_light.VCD
```