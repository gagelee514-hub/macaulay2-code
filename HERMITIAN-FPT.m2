needsPackage("FrobeniusThresholds")
e = 1;
for z from 1 to 2141 do (
    if isPrime(z) == true then (
        p =z;
        R = ZZ/p[x, y];
        for Hn from 1 to 11 do (
            H = n -> if n == 0 then 1_R else if n == 1 then 2*x else 2*x*H(n-1) - 2*(y^2)*(n-1)*H(n-2);
            Hp = H(Hn);
            print(p,Hn,toRR(fpt(Hp)))
            );
        );
    );