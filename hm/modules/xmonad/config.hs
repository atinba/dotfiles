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
import XMonad.Actions.SinkAll
import System.Exit (exitSuccess)
import Data.Semigroup
import XMonad.Hooks.DynamicProperty
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

-- INFO: use className, title doesn't work well
myScratchPads = [ NS "pavucontrol" "pavucontrol" findPavu managePavu
                , NS "keepassxc" "keepassxc" findKeepass manageKeepass
                , NS "term" "alacritty --class termpad" findTerm manageTerm
                ] where
    findPavu = className =? "Pavucontrol"
    managePavu = customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4)
    findKeepass = className =? "KeePassXC"
    manageKeepass = customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4) 
    findTerm = className =? "termpad"
    manageTerm = customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4) 
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

myKeys = [
    ("M-C-r", spawn "xmonad --recompile && xmonad --restart"),
    ("M-S-r", spawn "xmonad --restart"),
    ("M-S-q", io exitSuccess),

    ("M-<Return>", spawn myTerminal),
    ("M-q", spawn myBrowser),

    ("M-S-c", kill1),
    ("M-w", goToSelected def),
    ("M-g", windowPrompt def Bring allWindows),
    ("M-S-f", sinkAll),

    ("M-v", namedScratchpadAction myScratchPads "pavucontrol"),
    ("M-t", namedScratchpadAction myScratchPads "term"),
    ("M-p", namedScratchpadAction myScratchPads "keepassxc"),

    ("M-c", spawn "setxkbmap -v | grep colemak_dh && setxkbmap us || setxkbmap us -variant colemak_dh"),
    ("M-r", spawn "redshift -P -O 2500 & rofi -show run")
    ]


myConfig = def
    {
       modMask     = myModMask,
       terminal    = myTerminal,
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
