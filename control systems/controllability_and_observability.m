A = [0 1; -2 -3];
B = [0; 1];
C = [1 0];
Co = ctrb(A,B);
Ob = obsv(A,C);
rank_Co = rank(Co);
rank_Ob = rank(Ob);
