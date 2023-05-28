import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP, mkKeymap)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.GridSelect
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Prompt
import XMonad.Prompt.Window
import XMonad.Util.NamedScratchpad
import System.Exit (exitSuccess)
import Data.Semigroup
import XMonad.Hooks.DynamicProperty
    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M
import XMonad.StackSet (Workspace(layout))


myModMask   = mod4Mask
myTerminal  = "alacritty"
myBrowser   = "librewolf"
myEmacs     = "emacsclient -c -a 'emacs' "
myVim       = myTerminal ++ " -e nvim"
myWorkspaces = [ "dev", "www", "chat", "media", "5", "6", "7", "8", "9"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]

myScratchPads = [ NS "pavucontrol" "pavucontrol" findPavu managePavu
                , NS "keepassxc" "keepassxc" findKeepass manageKeepass
                ] where
    findPavu = className =? "Pavucontrol"
    managePavu = customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4)
    findKeepass = title =? "KeePassXC"
    manageKeepass = customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4) 

-- myHandleEventHook :: Event -> X All
-- myHandleEventHook = dynamicPropertyChange "WM_NAME" (title =? "KeePassXC" --> floating)
        where floating = customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)

myManageHook = composeAll [] <+> namedScratchpadManageHook myScratchPads

myLayout = tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 2 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes


clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myStartupHook = do
    spawnOnce "/usr/bin/emacs --daemon"
    spawnOnce "feh --bg-fill ~/.cache/wall/"
    spawnOnce "picom"
    spawnOnce "nm-applet"

-- myKeys = \c -> mkKeymap c $ [
myKeys = [
    ("M-C-r", spawn "xmonad --recompile && xmonad --restart"),      -- Recompile XMonad
    ("M-S-r", spawn "xmonad --restart"),        -- Restart XMonad
    ("M-S-q", io exitSuccess),                  -- Exit XMonad

    ("M-<Return>", spawn myTerminal),           -- Launch terminal
    ("M-q", spawn myBrowser),                   -- Launch browser

    ("M-S-c", kill1),
    ("M-w", goToSelected def),
    ("M-g", windowPrompt def Bring allWindows),

    ("M-v", namedScratchpadAction myScratchPads "pavucontrol"),

    ("M-c", spawn "setxkbmap -v | grep colemak_dh && setxkbmap us || setxkbmap us -variant colemak_dh"),
    ("M-p", spawn "rofi -show run")
    ]


myConfig = def
    {
       modMask     = myModMask,
       terminal    = myTerminal,
       startupHook = myStartupHook,
       workspaces  = myWorkspaces,
       layoutHook  = myLayout,
       manageHook  = myManageHook
    }
    `additionalKeysP` myKeys

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "polybar" (pure def)) defToggleStrutsKey
     $ myConfig
