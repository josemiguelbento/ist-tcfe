pkg load symbolic

syms V0
syms V1
syms V2
syms V3

syms Gb
syms Gd
syms Ic
syms b
syms Va

Z = vpa (0.0)
U = vpa (1.0)

A = [-Gb, Gb+Gd, -Gd, Z; U, Z, Z, Z; b*Gb, -b*Gb , U, Z; Z,Z,U, -b]
#B = [V1, V2, V3, Ib]
C = [-Ic; Va; Z; Z]

ANS = A\C