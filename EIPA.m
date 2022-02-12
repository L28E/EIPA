%close all;

nx=50;
ny=50
%ny=137;

% G-matrix, relates the value of a node to all other nodes
G=sparse(nx*ny,nx*ny);

% Mapping Equation, converts discretized 2D spacial domain to 1D vector in the "equation domain"
map=@(x,y) y+(x-1)*ny; 

for x=1:nx
    for y=1:ny
        n=map(x,y)
        if (x==1||y==1||x==nx||y==ny)
            % For boundaries, G matrix is set to 1             
            G(n,n)=1; 
        elseif (x > 10 && x < 20 && y > 10 && y < 20)
            G(n,n) = -2;    
        else
            % For the rest of the G matrix, populate using finite difference
            G(n,n)=-4;      % Relation to self (n?)
            G(n,n+1)=1;     % Relation to the node to the right (nxp)
            G(n,n-1)=1;     % Relation to the node to the left (nxm) 
            G(n,n+ny)=1;    % Relation to the node above (nyp)
            G(n,n-ny)=1;    % Relation to the node below (nym)
        end
    end
end
% Plot G
figure();
spy(G);

% Get eigenvectors, eigenvalues, and plot eigenvalues
% (Possible solutions to the matrix)
[E,D] = eigs(G,9,'SM');
figure();
plot(diag(D),"o");

% Plot eigenvectors
figure();
EV=zeros(nx,ny);
for k=1:9
    for x=1:nx
        for y=1:ny
          n=map(x,y)
          EV(x,y)=E(n,k);
          
        endfor      
    endfor 
    subplot(3,3,k);
    surf(EV);  
endfor
