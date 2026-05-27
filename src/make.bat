@set FILES=top_tb.vhd top.vhd sender.vhd debounce.vhd clock_div.vhd uart_rx.vhd uart_tx.vhd uart.vhd
@set ENTITY=top_tb

@REM @set FILES=uart_tb.vhd uart_rx.vhd uart_tx.vhd uart.vhd
@REM @set ENTITY=uart_tb

@ghdl -a %FILES%
@if %ERRORLEVEL%==1 exit /b 1
@ghdl -e %ENTITY%
@ghdl -r %ENTITY% --vcd=sim.vcd

@echo Ran Successfully