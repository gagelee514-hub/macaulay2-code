for p from 2 to 971 do (
if isPrime(p) == true then (
t = 1/6;
e = 1;
R = ZZ/p[x];
H = n -> if n == 0 then 1_R else if n == 1 then 2*x else 2*x*H(n-1) - 2*(n-1)*H(n-2);
for Hn from 0 to 15 do (
Hp = H(Hn);
ke = floor(t*p^e);
I = ideal(Hp^(ke));
len = degree(Hp^ke);
fsig = 1 - (1/p^(e))* first len;
print(p, Hn, numeric(fsig));
);
);
);
