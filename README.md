# janet-tic80-module
Simple Janet module that provides all TIC-80 functions for visibility when editing text carts or testing. Consider it like "headers" for writing or testing TIC-80 programs outside of their standard environment.

TIC-80, the excellent fantasy computer for making, playing and sharing tiny games that supports many languages including Janet can be found [here on Github](https://github.com/nesbox/TIC-80).

Just like in TIC-80 itself, the module is named so that you `(import tic80)` and call its functions like `(tic80/cls 15)`, making it possible to "drop-in" the code from TIC and test it in Janet.
If this module is installed through jpm, it appears as "tic80-headers", but is still used via `(import tic80)`.

Furthermore, programs intended for TIC-80 can be executed in Janet for testing purposes with this module, though of course **without actual TIC input/graphical output functionality**.
- Calls to the TIC-80 API will result in the API function and all of its arguments being printed to the console.
- API functions that are expected to return values should return values in the format expected, though randomly-chosen in a logical range when not possible to compute outside of TIC-80.
    - For example: `tic80/time` will return a number equal to the number of calls to time, simulating increasing ticks