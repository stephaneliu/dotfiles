-- Caps Lock types backtick; Shift + Caps Lock types tilde.
hl.config({
  input = {
    kb_file = os.getenv("HOME") .. "/.config/hypr/caps-backtick.xkb",
    -- macOS-style natural scrolling on the trackpad.
    touchpad = {
      natural_scroll = true,
    },
  },
})
