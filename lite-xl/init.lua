-- put user settings here
-- this module will be loaded after everything else when the application starts
-- it will be automatically reloaded when saved

local core = require "core"
local keymap = require "core.keymap"
local config = require "core.config"
local style = require "core.style"

------------------------------ Fonts -----------------------------------------

-- https://lite-xl.com/user-guide/configuration/#fonts

local homeFontDir = os.getenv("HOME") .. "/.local/share/fonts/sarasa-term-cjk/"
local liteFontDir = USERDIR .. "/fonts/"

local scName = "SarasaTermSC-Regular.ttf"
local tcName = "SarasaTermTC-Regular.ttf"
local jpName = "SarasaTermJ-Regular.ttf"
local krName = "SarasaTermK-Regular.ttf"

local scHomePath = homeFontDir .. scName
local tcHomePath = homeFontDir .. tcName
local jpHomePath = homeFontDir .. jpName
local krHomePath = homeFontDir .. krName

local scLitePath = liteFontDir .. scName
local tcLitePath = liteFontDir .. tcName
local jpLitePath = liteFontDir .. jpName
local krLitePath = liteFontDir .. krName

local notoPath = "/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"

local load = renderer.font.load
local fontSize = SCALE * 16
local loadedFonts = {}
local fontFile

fontFile = io.open(scHomePath, "r")
if fontFile then
  io.close(fontFile)
  table.insert(loadedFonts, load(scHomePath, fontSize))
else
  fontFile = io.open(scLitePath, "r")
  if fontFile then
    io.close(fontFile)
    table.insert(loadedFonts, load(scLitePath, fontSize))
  end
end

fontFile = io.open(tcHomePath, "r")
if fontFile then
  io.close(fontFile)
  table.insert(loadedFonts, load(tcHomePath, fontSize))
else
  fontFile = io.open(tcLitePath, "r")
  if fontFile then
    io.close(fontFile)
    table.insert(loadedFonts, load(tcLitePath, fontSize))
  end
end

fontFile = io.open(jpHomePath, "r")
if fontFile then
  io.close(fontFile)
  table.insert(loadedFonts, load(jpHomePath, fontSize))
else
  fontFile = io.open(jpLitePath, "r")
  if fontFile then
    io.close(fontFile)
    table.insert(loadedFonts, load(jpLitePath, fontSize))
  end
end

fontFile = io.open(krHomePath, "r")
if fontFile then
  io.close(fontFile)
  table.insert(loadedFonts, load(krHomePath, fontSize))
else
  fontFile = io.open(krLitePath, "r")
  if fontFile then
    io.close(fontFile)
    table.insert(loadedFonts, load(krLitePath, fontSize))
  end
end

if #loadedFonts == 0 then
  table.insert(loadedFonts, load(notoPath, fontSize))
end

style.font = renderer.font.group(loadedFonts)
style.code_font = renderer.font.group(loadedFonts)

------------------------------ Themes ----------------------------------------

-- light theme:
-- core.reload_module("colors.summer")

--------------------------- Key bindings -------------------------------------

-- key binding:
-- keymap.add { ["ctrl+escape"] = "core:quit" }

-- pass 'true' for second parameter to overwrite an existing binding
-- keymap.add({ ["ctrl+pageup"] = "root:switch-to-previous-tab" }, true)
-- keymap.add({ ["ctrl+pagedown"] = "root:switch-to-next-tab" }, true)

------------------------------- Fonts ----------------------------------------

-- customize fonts:
-- style.font = renderer.font.load(DATADIR .. "/fonts/FiraSans-Regular.ttf", 14 * SCALE)
-- style.code_font = renderer.font.load(DATADIR .. "/fonts/JetBrainsMono-Regular.ttf", 14 * SCALE)
--
-- DATADIR is the location of the installed Lite XL Lua code, default color
-- schemes and fonts.
-- USERDIR is the location of the Lite XL configuration directory.
--
-- font names used by lite:
-- style.font          : user interface
-- style.big_font      : big text in welcome screen
-- style.icon_font     : icons
-- style.icon_big_font : toolbar icons
-- style.code_font     : code
--
-- the function to load the font accept a 3rd optional argument like:
--
-- {antialiasing="grayscale", hinting="full", bold=true, italic=true, underline=true, smoothing=true, strikethrough=true}
--
-- possible values are:
-- antialiasing: grayscale, subpixel
-- hinting: none, slight, full
-- bold: true, false
-- italic: true, false
-- underline: true, false
-- smoothing: true, false
-- strikethrough: true, false

------------------------------ Plugins ----------------------------------------

-- disable plugin loading setting config entries:

-- disable plugin detectindent, otherwise it is enabled by default:
-- config.plugins.detectindent = false

---------------------------- Miscellaneous -------------------------------------

-- modify list of files to ignore when indexing the project:
-- config.ignore_files = {
--   -- folders
--   "^%.svn/",        "^%.git/",   "^%.hg/",        "^CVS/", "^%.Trash/", "^%.Trash%-.*/",
--   "^node_modules/", "^%.cache/", "^__pycache__/",
--   -- files
--   "%.pyc$",         "%.pyo$",       "%.exe$",        "%.dll$",   "%.obj$", "%.o$",
--   "%.a$",           "%.lib$",       "%.so$",         "%.dylib$", "%.ncb$", "%.sdf$",
--   "%.suo$",         "%.pdb$",       "%.idb$",        "%.class$", "%.psd$", "%.db$",
--   "^desktop%.ini$", "^%.DS_Store$", "^%.directory$",
-- }

