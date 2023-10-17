(def- janet-print print) # since we redefine "print" to match tic80's definition

(defmacro- echo-api [<apifn> & <apiargs>] 
  ~(do 
     (prin "tic80/" ,<apifn> ": ") 
     ,;(map |~(prin ',$ "=" ,$ " ") <apiargs>) 
     (janet-print)))

(defn btn
  "This function allows you to read the status of one of the buttons attached to TIC.
The function returns true if the key with the supplied id is currently in the pressed state.
It remains true for as long as the key is held down.
If you want to test if a key was just pressed, use `btnp()` instead.
   Returns: pressed"
  [id]
  (echo-api "btn" id))

(defn btnp
  "This function allows you to read the status of one of TIC's buttons.
   It returns true only if the key has been pressed since the last frame.
You can also use the optional hold and period parameters which allow you to check if a button is being held down.
After the time specified by hold has elapsed, btnp will return true each time period is passed if the key is still down.
For example, to re-examine the state of button `0` after 2 seconds and continue to check its state every 1/10th of a second, you would use btnp(0, 120, 6).
Since time is expressed in ticks and TIC runs at 60 frames per second, we use the value of 120 to wait 2 seconds and 6 ticks (ie 60/10) as the interval for re-checking.
   Returns: pressed"
  [id &opt hold period]
  (default hold -1)
  (default period -1)
  (echo-api "btnp" id hold period))

(defn circ
  "This function draws a filled circle of the desired radius and color with its center at x, y.
It uses the Bresenham algorithm."
  [x y radius color] 
  (echo-api "circ" x y radius color))

(defn circb [x y radius color]
  "Draws the circumference of a circle with its center at x, y using the radius and color requested.
It uses the Bresenham algorithm."
  (echo-api "circb" x y radius color))

(defn clip
  "This function limits drawing to a clipping region or `viewport` defined by x,y,w,h.
Things drawn outside of this area will not be visible.
Calling clip() with no parameters will reset the drawing area to the entire screen."
  [x y width height]
  (echo-api "clip" x y width height))

(defn cls
  "When called this function clear all the screen using the color passed as argument.
If no parameter is passed first color (0) is used."
  [&opt color]
  (default color 0)
  (echo-api "cls" color))

(defn elli
  "This function draws a filled ellipse of the desired a, b radiuses and color with its center at x, y.
It uses the Bresenham algorithm."
  [x y a b color]
  (echo-api "elli" x y a b color))

(defn ellib
  "This function draws an ellipse border with the desired radiuses a b and color with its center at x, y.
It uses the Bresenham algorithm."
  [x y a b color]
  (echo-api "ellib" x y a b color))

(defn exit
  "Interrupts program execution and returns to the console when the TIC function ends."
  []
  (echo-api "exit"))

(defn fget
  "Returns true if the specified flag of the sprite is set. See `fset()` for more details.
   Returns: bool"
  [sprite-id flag]
  (echo-api "fget" sprite-id flag))

(defn font
  "Print string with font defined in foreground sprites.
To simply print to the screen, check out `print()`.
To print to the console, check out `trace()`.
   Returns: width"
  [text x y chroma-key char-width char-height &opt fixed scale alt]
  (default fixed false)
  (default scale 1)
  (default alt false)
  (echo-api "font" text x y chroma-key char-width char-height fixed scale alt))

(defn fset
  "Each sprite has eight flags which can be used to store information or signal different conditions.
For example, flag 0 might be used to indicate that the sprite is invisible, flag 6 might indicate that the flag should be draw scaled etc.
See algo `fget()`."
  [sprite-id flag bool]
  (echo-api "fset" sprite-id flag bool))

(defn key
  "The function returns true if the key denoted by keycode is pressed.
   Returns: pressed"
  [&opt code]
  (default code -1)
  (echo-api "key" code))

(defn keyp
  "This function returns true if the given key is pressed but wasn't pressed in the previous frame.
Refer to `btnp()` for an explanation of the optional hold and period parameters.
   Returns: pressed"
  [&opt code hold period]
  (default code -1)
  (default hold -1)
  (default period -1)
  (echo-api "keyp" code hold period))

(defn line
  "Draws a straight line from point (x0,y0) to point (x1,y1) in the specified color."
  [x0 y0 x1 y1 color]
  (echo-api "line" x0 y0 x1 y1 color))

(defn map
  "The map consists of cells of 8x8 pixels, each of which can be filled with a sprite using the map editor.
The map can be up to 240 cells wide by 136 deep.
This function will draw the desired area of the map to a specified screen position.
For example, map(5,5,12,10,0,0) will draw a 12x10 section of the map, starting from map coordinates (5,5) to screen position (0,0).
The map function's last parameter is a powerful callback function for changing how map cells (sprites) are drawn when map is called.
It can be used to rotate, flip and replace sprites while the game is running.
Unlike mset, which saves changes to the map, this special function can be used to create animated tiles or replace them completely.
Some examples include changing sprites to open doorways, hiding sprites used to spawn objects in your game and even to emit the objects themselves.
The tilemap is laid out sequentially in RAM - writing 1 to 0x08000 will cause tile(sprite) #1 to appear at top left when map() is called.
To set the tile immediately below this we need to write to 0x08000 + 240, ie 0x080F0."
  [&opt x y w h sx sy color-key scale remap]
  (default x 0)
  (default y 0)
  (default w 30)
  (default h 17)
  (default sx 0)
  (default sy 0)
  (default color-key -1)
  (default scale 1)
  (default remap nil)
  (echo-api "map" x y w h sx sy color-key scale remap))

(defn memcpy
  "This function allows you to copy a continuous block of TIC's 96K RAM from one address to another.
Addresses are specified are in hexadecimal format, values are decimal."
  [dest source size]
  (echo-api "memcpy" dest source size))

(defn memset
  "This function allows you to set a continuous block of any part of TIC's RAM to the same value.
The address is specified in hexadecimal format, the value in decimal."
  [dest value size]
  (echo-api "memset" dest value size))

(defn mget
  "Gets the sprite id at the given x and y map coordinate.
   Returns: tile-id"
  [x y]
  (echo-api "mget" x y))

(defn mouse
  "This function returns the mouse coordinates and a boolean value for the state of each mouse button,with true indicating that a button is pressed.
   Returns: x y left middle right scrollx scrolly"
  []
  (echo-api "mouse")
  [10 20 true false false 0 0]
  )

(defn mset
  "This function will change the tile at the specified map coordinates.
By default, changes made are only kept while the current game is running.
To make permanent changes to the map, see `sync()`.
Related: `map()` `mget()` `sync()`."
  [x y tile-id]
  (echo-api "mset" x y tile-id))

(defn music
  "This function starts playing a track created in the Music Editor.
Call without arguments to stop the music."
  [&opt track frame row loop sustain tempo speed]
  (default track -1)
  (default frame -1)
  (default row -1)
  (default loop true)
  (default sustain false)
  (default tempo -1)
  (default speed -1)
  (echo-api "music" track frame row loop sustain tempo speed))

(defn peek
  "This function allows to read the memory from TIC.
It's useful to access resources created with the integrated tools like sprite, maps, sounds, cartridges data?
Never dream to sound a sprite?
Address are in hexadecimal format but values are decimal.
To write to a memory address, use `poke()`.
`bits` allowed to be 1,2,4,8.
   Returns: value"
  [addr &opt bits]
  (default bits 8)
  (echo-api "peek" addr bits))

(defn peek1
  "This function enables you to read single bit values from TIC's RAM.
The address is often specified in hexadecimal format.
   Returns: value"
  [addr]
  (echo-api "peek1" addr))

(defn peek2
  "This function enables you to read two bits values from TIC's RAM.
The address is often specified in hexadecimal format."
  [addr]
  (echo-api "peek2" addr))

(defn peek4
  "This function enables you to read values from TIC's RAM.
The address is often specified in hexadecimal format.
See 'poke4()' for detailed information on how nibble addressing compares with byte addressing."
  [addr]
  (echo-api "peek4" addr))

(defn pix
  "This function can read or write pixel color values.
When called with a color parameter, the pixel at the specified coordinates is set to that color.
Calling the function without a color parameter returns the color of the pixel at the specified position.
   Returns: color (when color argument is nil)"
  [x y &opt color]
  (echo-api "pix" x y color))

(defn pmem
  "This function allows you to save and retrieve data in one of the 256 individual 32-bit slots available in the cartridge's persistent memory.
This is useful for saving high-scores, level advancement or achievements.
The data is stored as unsigned 32-bit integers (from 0 to 4294967295).
   Tips:
- pmem depends on the cartridge hash (md5), so don't change your lua script if you want to keep the data.
- Use `saveid:` with a personalized string in the header metadata to override the default MD5 calculation.
This allows the user to update a cart without losing their saved data.
   Returns: value (when value argument is nil)"
  [index &opt value]
  (echo-api "pmem" index value))

(defn poke
  "This function allows you to write a single byte to any address in TIC's RAM.
The address should be specified in hexadecimal format, the value in decimal.
`bits` allowed to be 1,2,4,8."
  [addr value &opt bits]
  (default bits 8)
  (echo-api "poke" addr value bits))

(defn poke1
  "This function allows you to write single bit values directly to RAM.
The address is often specified in hexadecimal format."
  [addr value]
  (echo-api "poke1" addr value))

(defn poke2
  "This function allows you to write two bits values directly to RAM.
The address is often specified in hexadecimal format."
  [addr value]
  (echo-api "poke2" addr value))

(defn poke4
  "This function allows you to write directly to RAM.
The address is often specified in hexadecimal format.
For both peek4 and poke4 RAM is addressed in 4 bit segments (nibbles).
Therefore, to access the the RAM at byte address 0x4000
you would need to access both the 0x8000 and 0x8001 nibble addresses."
  [addr value]
  (echo-api "poke4" addr value))

(defn print
  "This will simply print text to the screen using the font defined in config.
When set to true, the fixed width option ensures that each character will be printed in a `box` of the same size, so the character `i` will occupy the same width as the character `w` for example.
When fixed width is false, there will be a single space between each character.
   Returns: width"
  [text &opt x y color fixed scale small-font]
  (default x 0)
  (default y 0)
  (default color 15)
  (default fixed false)
  (default scale 1)
  (default small-font false)
  (echo-api "print" text x y color fixed scale small-font))

(defn rect
  "This function draws a filled rectangle of the desired size and color at the specified position.
If you only need to draw the the border or outline of a rectangle (ie not filled) see `rectb()`."
  [x y w h color]
  (echo-api "rect" x y w h color))

(defn rectb
  "This function draws a one pixel thick rectangle border at the position requested.
If you need to fill the rectangle with a color, see `rect()` instead."
  [x y w h color]
  (echo-api "rectb" x y w h color))

(defn reset
  "Resets the cartridge. To return to the console, see the `exit()`."
  []
  (echo-api "reset"))

(defn sfx
  "This function will play the sound with `id` created in the sfx editor.
Calling the function with id set to -1 will stop playing the channel.
The note can be supplied as an integer between 0 and 95 (representing 8 octaves of 12 notes each) or as a string giving the note name and octave.
For example, a note value of `14` will play the note `D` in the second octave.
The same note could be specified by the string `D-2`.
Note names consist of two characters, the note itself (in upper case) followed by `-` to represent the natural note or `#` to represent a sharp.
There is no option to indicate flat values.
The available note names are therefore: C-, C#, D-, D#, E-, F-, F#, G-, G#, A-, A#, B-.
The `octave` is specified using a single digit in the range 0 to 8.
The `duration` specifies how many ticks to play the sound for since TIC-80 runs at 60 frames per second, a value of 30 represents half a second.
A value of -1 will play the sound continuously.
The `channel` parameter indicates which of the four channels to use. Allowed values are 0 to 3.
The `volume` can be between 0 and 15.
The `speed` in the range -4 to 3 can be specified and means how many `ticks+1` to play each step, so speed==0 means 1 tick per step."
  [id &opt note duration channel volume speed]
  (default note -1)
  (default duration -1)
  (default channel 0)
  (default volume 15)
  (default speed 0)
  (echo-api "sfx" id note duration channel volume speed))

(defn spr
  "Draws the sprite number index at the x and y coordinate.
You can specify a colorkey in the palette which will be used as the transparent color or use a value of -1 for an opaque sprite.
The sprite can be scaled up by a desired factor. For example, a scale factor of 2 means an 8x8 pixel sprite is drawn to a 16x16 area of the screen.
You can flip the sprite where:
- 0 = No Flip
- 1 = Flip horizontally
- 2 = Flip vertically
- 3 = Flip both vertically and horizontally
When you rotate the sprite, it's rotated clockwise in 90 steps:
- 0 = No rotation
- 1 = 90 rotation
- 2 = 180 rotation
- 3 = 270 rotation
You can draw a composite sprite (consisting of a rectangular region of sprites from the sprite sheet) by specifying the `w` and `h` parameters (which default to 1)."
  [id x y &opt color-key scale flip rotate w h]
  (default color-key -1)
  (default scale 1)
  (default flip 0)
  (default rotate 0)
  (default w 1)
  (default h 1)
  (echo-api "spr" id x y color-key scale flip rotate w h))

(defn sync
  "The pro version of TIC-80 contains 8 memory banks.
To switch between these banks, sync can be used to either load contents from a memory bank to runtime, or save contents from the active runtime to a bank.
The function can only be called once per frame.If you have manipulated the runtime memory (e.g. by using mset), you can reset the active state by calling sync(0,0,false).
This resets the whole runtime memory to the contents of bank 0.Note that sync is not used to load code from banks; this is done automatically."
  [&opt mask bank to-cart]
  (default mask 0)
  (default bank 0)
  (default to-cart false)
  (echo-api "sync" mask bank to-cart))

(defn time
  "This function returns the number of milliseconds elapsed since the cartridge began execution.
Useful for keeping track of time, animating items and triggering events.
   Returns: ticks"
  []
  (echo-api "time"))

(defn trace
  "This is a service function, useful for debugging your code.
It prints the message parameter to the console in the (optional) color specified.
- Use console cls command to clear the output from trace."
  [message &opt color]
  (default color 15)
  (echo-api "trace" message color))

(defn tri
  "This function draws a triangle filled with color, using the supplied vertices."
  [x1 y1 x2 y2 x3 y3 color]
  (echo-api "tri" x1 y1 x2 y2 x3 y3 color))

(defn trib
  "This function draws a triangle border with color, using the supplied vertices."
  [x1 y1 x2 y2 x3 y3 color]
  (echo-api "trib" x1 y1 x2 y2 x3 y3 color))

(defn tstamp
  "This function returns the number of seconds elapsed since January 1st, 1970.
Useful for creating persistent games which evolve over time between plays.
   Returns: timestamp"
  []
  (echo-api "tstamp"))

(defn ttri
  "It renders a triangle filled with texture from image ram, map ram or vbank.
Use in 3D graphics.
In particular, if the vertices in the triangle have different 3D depth, you may see some distortion.
These can be thought of as the window inside image ram (sprite sheet), map ram or another vbank.
Note that the sprite sheet or map in this case is treated as a single large image, with U and V addressing its pixels directly, rather than by sprite ID.
So for example the top left corner of sprite #2 would be located at u=16, v=0."
  [x1 y1 x2 y2 x3 y3 u1 v1 u2 v2 u3 v3 &opt tex-src chroma-key z1 z2 z3]
  (default tex-src 0)
  (default chroma-key -1)
  (default z1 0)
  (default z2 0)
  (default z3 0)
  (echo-api "ttri" x1 y1 x2 y2 x3 y3 u1 v1 u2 v2 u3 v3 tex-src chroma-key z1 z2 z3))

(defn vbank
  "VRAM contains 2x16K memory chips, use vbank(0) or vbank(1) to switch between them.
   Returns: previous"
  [&opt bank]
  (echo-api "vbank" bank))