# All keybinds

**Note:** default prefix is `mod4` (aka Super/Windows/call this key as you want)


  * [Window-related binds](#window-related-binds)
    * [Focusing](#focusing)
    * [Moving windows](#moving-windows)
    * [Resizing](#resizing)
    * [Splitting](#splitting)
    * [Other window properties](#other-window-properties)
  * [Workspaces](#workspaces)
  * [Media settings](#media-settings)
  * [Other binds](#other-binds)


## Window-related binds

### Focusing

Changing focus between windows is pretty easy:

 * `$mod+h` / `$mod+ArrowLeft` - focus window left to current
 * `$mod+j` / `$mod+ArrowDown` - ... ... bellow
 * `$mod+k` / `$mod+ArrowUp` - ... ... above
 * `$mod+l` / `$mod+ArrowRight` - ... ... right to current

Or just.. Use yout mouse and tap on window, lmao.

### Moving windows

There is nothing difficult in moving windows

 * `$mod+Alt+h` / `$mod+Alt+ArrowLeft` - move focused window left
 * `$mod+Alt+j` / `$mod+Alt+ArrowDown` - ... ... ... down
 * `$mod+Alt+k` / `$mod+Alt+ArrowUp` - ... ... ... up
 * `$mod+Alt+l` / `$mod+Alt+ArrowRight` - ... ... ... right

### Resizing

To enter resizing mode, press `$mod+r`, then use buttons bellow:
To exit resizing mode, press `Return` or `Escape`.

 * `h` / `ArrowLeft` - ghrink window horizontally
 * `l` / `ArrowRight` - grow window horizontally
 * `j` / `ArrowDown` - shrink window vertically
 * `k` / `ArrowUp` - grow window vertically

If you want smaller resize step, just hold `Shift` while resizing.

### Splitting

Nothing difficult here, too:

 * `$mod+h` - split horizontally
 * `$mod+v` - split vertically

Next spawned window will be placed bellow/right of current window.

### Other window properties

Some properties may be changed:

 * `$mod+f` - toggle fullscreen mode
 * `$mod+t` - enable window title
 * `$mod+y` - disable window title
 * `$mod+Shift+Space` - toggle "floating window" mode. You can drag window by mouse while holding `$mod`.

## Workspaces

This i3 configuration allows you to use up to 20 workspaces.

Switching to first 10 is easy: `$mod+<index>`.
Using last 10 workspaces not so hard, too: `$mod+Control+<index>`.

You can move window to workspace by pressing `$mod+Alt+<index>` for first 10 workspaces, and `$mod+Control+Alt+<index>` for last 10.

You also can switch between workspaces by pressing `$mod+Tab` and `$mod+Shift+Tab`.


## Media settings

You can control volume of MPD daemon and system volume by some keys:

 * MPD
    * `Control+XF86AudioMute` - toggle mute on MPD output 2
    * `Control+XF86AudioRaiseVolume` - raise volume by 2%
    * `Control+XF86AudioLowerVolume` - lower volume by 2%
    * `XF86AudioNext` - switch to next track in queue
    * `XF86AudioPrev` - switch to previous track in queue
    * `Control+XF86AudioNext` - rewind 10 seconds forwards
    * `Control+XF86AudioPrev` - rewind 10 seconds backwards
    * `XF86AudioStop` - stop MPD
    * `XF86AudioPlay` - toggle playing
    * `$mod+m` - open `ncmpc`
  * System
    * `XF86AudioMute` - mute sound
    * `XF86AudioRaiseVolume` - raise volume by 2%
    * `XF86AudioLowerVolume` - lower volume by 2%
    
## Other binds

 * `$mod+Return` - spawn terminal
 * `$mod+F4` - close window
 * `$mod+d` - show rofi
 * Layout:
    * `$mod+s` - stacking layout (windows stacked at top)
    * `$mod+w` - tabbed layout (like in browser, windows as tabs)
    * `$mod+e` - toggle split layout (default)
 * Scratchpad
    * `$mod+Shift+minus` - move window to scratchpad
    * `$mod+minus` - show scratchpad
 * System mode (`$mod+Delete`):
    * `l` - lock
    * `e` - exit i3
    * `s` - suspend
    * `h` - hibernate
    * `r` - reboot
    * `p` - shutdown
    * `Return/Escape` - normal mode
 * Screenshots:
    * `Mod4+Print` - fullscreen snapshot
    * `Shift+Print` - select area
    * `Alt+Print` - current window
    * `Print` - open flameshot
 * `$mod+Shift+e` - exit i3
 * `$mod+Shift+c` - reload i3 settings
 * `$mod+F1` - toggle touchpad

