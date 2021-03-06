{-# LANGUAGE UnicodeSyntax, NoImplicitPrelude #-}

module Lookup.MacOS where

import BasePrelude
import Prelude.Unicode
import Data.List.Unicode ((∖))

import Layout.Types
import qualified Layout.Action as A
import qualified Layout.Modifier as M
import qualified Layout.Pos as P

modifierAndString ∷ [(Modifier, String)]
modifierAndString =
    [ (M.Shift, "anyShift")
    , (M.Shift_L, "shift")
    , (M.Shift_R, "rightShift")
    , (M.CapsLock, "caps")
    , (M.Alt, "anyOption")
    , (M.Alt_L, "option")
    , (M.Alt_R, "rightOption")
    , (M.AltGr, "anyOption")
    , (M.Control, "anyControl")
    , (M.Control_L, "control")
    , (M.Control_R, "rightControl")
    , (M.Win, "command")
    ]

usedModifiers ∷ Modifier → [Modifier]
usedModifiers M.Shift = [M.Shift, M.Shift_L, M.Shift_R]
usedModifiers M.Shift_L = [M.Shift, M.Shift_L]
usedModifiers M.Shift_R = [M.Shift, M.Shift_R]
usedModifiers M.Alt = [M.Alt, M.Alt_L, M.Alt_R, M.AltGr]
usedModifiers M.Alt_L = [M.Alt, M.Alt_L]
usedModifiers M.Alt_R = [M.Alt, M.Alt_R, M.AltGr]
usedModifiers M.AltGr = [M.Alt, M.Alt_L, M.Alt_R, M.AltGr]
usedModifiers M.Control = [M.Control, M.Control_L, M.Control_R]
usedModifiers M.Control_L = [M.Control, M.Control_L]
usedModifiers M.Control_R = [M.Control, M.Control_R]
usedModifiers modifier = [modifier]

removeDoubleModifiers ∷ [Modifier] → [Modifier]
removeDoubleModifiers =
    ifContainsRemove M.Shift [M.Shift_L, M.Shift_R] >>>
    ifContainsRemove M.Alt [M.Alt_L, M.Alt_R, M.AltGr] >>>
    ifContainsRemove M.AltGr [M.Alt, M.Alt_L, M.Alt_R] >>>
    ifContainsRemove M.Control [M.Control_L, M.Control_R]
  where
    ifContainsRemove modifier modifiersToRemove mods
        | modifier ∈ mods = mods ∖ modifiersToRemove
        | otherwise = mods

posAndCode ∷ [(Pos, Int)]
posAndCode =
    [ (P.Tilde, 0x0A) --0x32
    , (P.N1, 0x12)
    , (P.N2, 0x13)
    , (P.N3, 0x14)
    , (P.N4, 0x15)
    , (P.N5, 0x17)
    , (P.N6, 0x16)
    , (P.N7, 0x1A)
    , (P.N8, 0x1C)
    , (P.N9, 0x19)
    , (P.N0, 0x1D)
    , (P.Minus, 0x1B)
    , (P.Plus, 0x18)
    , (P.Backspace, 0x33)

    , (P.Tab, 0x30)
    , (P.Q, 0x0C)
    , (P.W, 0x0D)
    , (P.E, 0x0E)
    , (P.R, 0x0F)
    , (P.T, 0x11)
    , (P.Y, 0x10)
    , (P.U, 0x20)
    , (P.I, 0x22)
    , (P.O, 0x1F)
    , (P.P, 0x23)
    , (P.Bracket_L, 0x21)
    , (P.Bracket_R, 0x1E)
    , (P.Backslash, 0x2A)

    , (P.CapsLock, 0x39)
    , (P.A, 0x00)
    , (P.S, 0x01)
    , (P.D, 0x02)
    , (P.F, 0x03)
    , (P.G, 0x05)
    , (P.H, 0x04)
    , (P.J, 0x26)
    , (P.K, 0x28)
    , (P.L, 0x25)
    , (P.Semicolon, 0x29)
    , (P.Apastrophe, 0x27)
    , (P.Enter, 0x24)

    , (P.Shift_L, 0x38)
    , (P.Iso, 0x32)
    , (P.Z, 0x06)
    , (P.X, 0x07)
    , (P.C, 0x08)
    , (P.V, 0x09)
    , (P.B, 0x0B)
    , (P.N, 0x2D)
    , (P.M, 0x2E)
    , (P.Comma, 0x2B)
    , (P.Period, 0x2F)
    , (P.Slash, 0x2C)
    , (P.Shift_R, 0x3C)

--    , (P.Control_L, 0x3B)
--    , (P.Alt_L, 0x3A)
--    , (P.Win_L, 0x37)
    , (P.Space, 0x31)
--    , (P.Win_R, 0x37)
--    , (P.Alt_R, 0x3D)
    --, (P.Menu, 0x)
--    , (P.Control_R, 0x3E)

    , (P.Esc, 0x35)
    , (P.F1, 0x7A)
    , (P.F2, 0x78)
    , (P.F3, 0x63)
    , (P.F4, 0x76)
    , (P.F5, 0x60)
    , (P.F6, 0x61)
    , (P.F7, 0x62)
    , (P.F8, 0x64)
    , (P.F9, 0x65)
    , (P.F10, 0x6D)
    , (P.F11, 0x67)
    , (P.F12, 0x6F)
    , (P.PrintScreen, 0x69)
    , (P.ScrollLock, 0x6B)
    , (P.Pause, 0x71)

    , (P.Insert, 0x72)
    , (P.Delete, 0x75)
    , (P.Home, 0x73)
    , (P.End, 0x77)
    , (P.PageUp, 0x74)
    , (P.PageDown, 0x79)
    , (P.Up, 0x7E)
    , (P.Left, 0x7B)
    , (P.Down, 0x7D)
    , (P.Right, 0x7C)

    , (P.NumLock, 0x47)
    , (P.KP_Div, 0x4B)
    , (P.KP_Mult, 0x43)
    , (P.KP_7, 0x59)
    , (P.KP_8, 0x5B)
    , (P.KP_9, 0x5C)
    , (P.KP_Min, 0x4E)
    , (P.KP_4, 0x56)
    , (P.KP_5, 0x57)
    , (P.KP_6, 0x58)
    , (P.KP_Plus, 0x45)
    , (P.KP_1, 0x53)
    , (P.KP_2, 0x54)
    , (P.KP_3, 0x55)
    , (P.KP_0, 0x52)
    , (P.KP_Dec, 0x41)
    , (P.KP_Enter, 0x4C)
    , (P.KP_Eq, 0x51)
    ]

actionAndChar ∷ [(Action, Char)]
actionAndChar =
    [ (A.Esc, '\ESC')
    , (A.Delete, '\DEL')
    , (A.Backspace, '\b')
    , (A.Tab, '\t')
    , (A.Enter, '\r')

    , (A.KP_Clear, '\ESC')
    , (A.KP_Div, '/')
    , (A.KP_Mult, '*')
    , (A.KP_Min, '-')
    , (A.KP_7, '7')
    , (A.KP_8, '8')
    , (A.KP_9, '9')
    , (A.KP_Plus, '+')
    , (A.KP_4, '4')
    , (A.KP_5, '5')
    , (A.KP_6, '6')
    , (A.KP_1, '1')
    , (A.KP_2, '2')
    , (A.KP_3, '3')
    , (A.KP_Enter, '\x03')
    , (A.KP_0, '0')
    , (A.KP_Dec, '.')
    , (A.KP_Eq, '=')
    ]
