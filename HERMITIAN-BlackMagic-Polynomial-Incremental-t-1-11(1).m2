e = 1;
p = 2141;
R = ZZ/p[x, y];
for Hn from 1 to 11 do (
    H = n -> if n == 0 then 1_R else if n == 1 then 2*x else 2*x*H(n-1) - 2*(y^2)*(n-1)*H(n-2);
    Hp = H(Hn);
    for d from 1 to 200 do (
        t = (1/200) * d;
        ke = floor(t*p^e);
        I = ideal(x^(p^e), y^(p^e), Hp^(ke));
        len = length(R^1/I);
        fsig = 1 - (1/p^(2*e))* len;
        print(Hn, toRR(t), p, numeric(fsig));
        stdio << flush;
    );
);