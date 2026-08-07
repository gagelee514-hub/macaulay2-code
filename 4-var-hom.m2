for e from 1 to 1 do (
for a from 1 to 11 do (
for b from 1 to 11 do (
for c from 1 to 11 do (
for tIdx from 0 to 20 do (
t = tIdx/20;
for p from 11 to 11 do (
if isPrime(p) == true then (
R = ZZ/p[x, y, z, w];
Hh = (n, v) -> if n == 0 then 1_R else if n == 1 then 2*v else 2*v*Hh(n-1,v) - 2*(n-1)*(w^2)*Hh(n-2,v);
Hprod = Hh(a,x) * Hh(b,y) * Hh(c,z);
ke = floor(t*p^e);
I = ideal(x^(p^e), y^(p^e), z^(p^e), w^(p^e), Hprod^(ke));
len = length(R^1/I);
fsig = 1 - (1/p^(4*e))* len;
print(a, b, c, numeric(t), numeric(fsig));
);
);
);
);
);
);
);