function acustic (n)

%macierz [B(ei,ej)]
matrix = zeros(n+1,n+1); 

%macierz L(v) //równa L(v)=0 dla ka¿dego v
matrix3 = zeros(n+1,1); 

%wype³nienie macierzy [L(v)] wartoœciami
%przykladowe rozwi¹zanie dla u"-u=1
for k = 1:n+1
    matrix3(k,1) =2/n;
end
matrix3(1,1)=1/n;
matrix3(n+1,1)=1/n;

syms x;
%wype³nienie macierzy [B(ei,ej)] odpowiednimi wartoœciami
for k=1:n+1
    for j=1:n+1
        if abs(k-j) >= 2
            matrix(k,j) = 0;    
        elseif k<j
            matrix(k,j) = int(-n^2/4 -(-n/2*x+k)*(n/2*x+2-j), x, [(k-1)*2/n, k*2/n]);
        elseif k>j
            matrix(k,j) = int(-n^2/4 -(-n/2*x+j)*(n/2*x+2-k), x, [(j-1)*2/n, j*2/n]);
        elseif k==j
            matrix(k,k) = int(((n/2)^2-(n/2*x+2-k)^2), x, [(k-2)*2/n,(k-1)*2/n]) + int(((n/2)^2-(-n/2*x+k)^2), x, [(k-1)*2/n, k*2/n]);   
        end
    end
end

matrix(1,1) = int((n/2)^2 - (-n/2*x+1)^2, x, [0, 2/n]);
matrix(n+1,n+1) = int(((n/2)^2 -(n/2*x-n+1)^2), x, [(2*n-2)/n, 2])-1;

%obliczenie wartoœci wi
w_result = linsolve(matrix,matrix3);

%stworzenie wektora rozwi¹zañ
result = (1:n+1);

%obliczenie wartoœci szukanej funkcji w punktach odleg³ych od siebie o
%2/n na przedziale [0;2]
for k=1:n
    result(k) = w_result(k) * (-n/2*(2/n*(k-1))) + w_result(k+1)*(n/2*(2/n*(k-1))+2);
end
result(n+1) = w_result(n+1);

%stworzenie punktów odleg³ych od siebie o 2/n na przedziale [0;2]
points = (1:n+1);
for k=1:n+1
    points(k) = 2/n * (k-1);
end

%narysowanie wykresu
plot(points,result);

%wyœwietlenie wyników
disp(matrix);
disp(w_result);
disp(result);