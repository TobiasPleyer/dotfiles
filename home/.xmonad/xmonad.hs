import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import System.IO


main = do
    xmonad $ def
        { terminal = "st"
        --, modMask = mod4Mask
        }
