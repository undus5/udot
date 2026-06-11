-- put user settings here
-- this module will be loaded after everything else when the application starts
-- it will be automatically reloaded when saved

local core = require "core"
local keymap = require "core.keymap"
local config = require "core.config"
local style = require "core.style"

------------------------------ Fonts -----------------------------------------

-- https://lite-xl.com/user-guide/configuration/#fonts

local fontDir = USERDIR .. "/fonts/"

local uiFont = "AtkinsonHyperlegibleNext-Regular.otf"
local uiFontSC = "IBMPlexSansSC-Regular.otf"
local uiFontTC = "IBMPlexSansTC-Regular.otf"
local uiFontJP = "IBMPlexSansJP-Regular.otf"
local uiFontKR = "IBMPlexSansKR-Regular.otf"

local codeFont = "JetBrainsMonoNL-Regular.ttf"
local codeFontSC = "SarasaTermSC-Regular.ttf"
local codeFontTC = "SarasaTermTC-Regular.ttf"
local codeFontJP = "SarasaTermJ-Regular.ttf"
local codeFontKR = "SarasaTermK-Regular.ttf"

local uiFontPath = fontDir .. uiFont
local uiFontPathSC = fontDir .. uiFontSC
local uiFontPathTC = fontDir .. uiFontTC
local uiFontPathJP = fontDir .. uiFontJP
local uiFontPathKR = fontDir .. uiFontKR

local codeFontPath = fontDir .. codeFont
local codeFontPathSC = fontDir .. codeFontSC
local codeFontPathTC = fontDir .. codeFontTC
local codeFontPathJP = fontDir .. codeFontJP
local codeFontPathKR = fontDir .. codeFontKR

local load = renderer.font.load
local fontSize = SCALE * 16
local uiLoadedFonts = {}
local codeLoadedFonts = {}
local fontFile

-- ui font

fontFile = io.open(uiFontPath, "r")
if fontFile then
  io.close(fontFile)
  table.insert(uiLoadedFonts, load(uiFontPath, fontSize))
end

fontFile = io.open(uiFontPathSC, "r")
if fontFile then
  io.close(fontFile)
  table.insert(uiLoadedFonts, load(uiFontPathSC, fontSize))
end

fontFile = io.open(uiFontPathTC, "r")
if fontFile then
  io.close(fontFile)
  table.insert(uiLoadedFonts, load(uiFontPathTC, fontSize))
end

fontFile = io.open(uiFontPathJP, "r")
if fontFile then
  io.close(fontFile)
  table.insert(uiLoadedFonts, load(uiFontPathJP, fontSize))
end

fontFile = io.open(uiFontPathKR, "r")
if fontFile then
  io.close(fontFile)
  table.insert(uiLoadedFonts, load(uiFontPathKR, fontSize))
end

if #uiLoadedFonts > 0 then
  style.font = renderer.font.group(uiLoadedFonts)
end

-- code font

fontFile = io.open(codeFontPath, "r")
if fontFile then
  io.close(fontFile)
  table.insert(codeLoadedFonts, load(codeFontPath, fontSize))
end
fontFile = io.open(codeFontPathSC, "r")
if fontFile then
  io.close(fontFile)
  table.insert(codeLoadedFonts, load(codeFontPathSC, fontSize))
end

fontFile = io.open(codeFontPathTC, "r")
if fontFile then
  io.close(fontFile)
  table.insert(codeLoadedFonts, load(codeFontPathTC, fontSize))
end

fontFile = io.open(codeFontPathJP, "r")
if fontFile then
  io.close(fontFile)
  table.insert(codeLoadedFonts, load(codeFontPathJP, fontSize))
end

fontFile = io.open(codeFontPathKR, "r")
if fontFile then
  io.close(fontFile)
  table.insert(codeLoadedFonts, load(codeFontPathKR, fontSize))
end

if #codeLoadedFonts > 0 then
  style.code_font = renderer.font.group(codeLoadedFonts)
end

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

