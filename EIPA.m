nx=50;
ny=50;

G=sparse(nx*ny,nx*ny);

for x=1:nx
    for y=1:ny
        % Mapping Equation, converts discretized 2D spacial domain 
        % to 1D vector in the "equation domain"
        n=y+(x-1)*ny; 
        if (x==1||y==1||x==nx||y==ny)
            % For boundaries, G matrix is set to 1             
            G(n,n)=1; 
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

spy(G);