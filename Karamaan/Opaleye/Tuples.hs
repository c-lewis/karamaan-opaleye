module Karamaan.Opaleye.Tuples where

type T1 a = a
type T2 a b = (a, T1 b)
type T3 a b c = (a, T2 b c)
type T4 a b c d = (a, T3 b c d)
type T5 a b c d e = (a, T4 b c d e)
type T6 a b c d e f = (a, T5 b c d e f)
type T7 a b c d e f g = (a, T6 b c d e f g)
type T8 a b c d e f g h = (a, T7 b c d e f g h)