function [u,b] = levelset(in)

A = max(in(:));
nu = 0.01*A^2;
mu = 0.05;
sigma = 5;
itout = 150;
itin = 2;
tstep = 0.005;
epsilon = 1;

% Initial Level Set Function
u = 2*(in>mean(in(:)));

b = ones(size(in));

K = fspecial('gaussian',round(2*sigma)*2+1,sigma);

KONE = conv2(b,K,'same');

fi(in)
for n=1:itout
   [u, b] = lse_bfe(u,in, b, K, KONE, nu, tstep, mu, epsilon, itin); 
   
   imagesc(log(in))
   hold on
   contour(u+7,[7 7],'r')
   hold off
   pause(0.02)
end

end

function [u, b, C]= lse_bfe(u0,Img, b, Ksigma,KONE, nu,timestep,mu,epsilon, iter_lse)
% This function performs the level set evolution (LSE) and bias field
% estimation described in the following paper
%      C. Li, R. Huang, Z. Ding, C. Gatenby, D. N. Metaxas, and J. C. Gore, 
%      "A Level Set Method for Image Segmentation in the Presence of Intensity
%      Inhomogeneities with Application to MRI", IEEE Trans. Image Processing, 2011
%
% Author: Chunming Li, all rights researved
% E-mail: lchunming@gmail.com
% URL: http://www.engr.uconn.edu/~cmli/

u=u0;
KB1 = conv2(b,Ksigma,'same');
KB2 = conv2(b.^2,Ksigma,'same');
C =updateC(Img, u, KB1, KB2, epsilon);

KONE_Img = Img.^2.*KONE;
u = updateLSF(Img,u, C, KONE_Img, KB1, KB2, mu, nu, timestep, epsilon, iter_lse);

Hu=Heaviside(u,epsilon);
M(:,:,1)=Hu;
M(:,:,2)=1-Hu;
b =updateB(Img, C, M,  Ksigma);
end


% update level set function
function u = updateLSF(Img, u0, C, KONE_Img, KB1, KB2, mu, nu, timestep, epsilon, iter_lse)
u=u0;
Hu=Heaviside(u,epsilon);
M(:,:,1)=Hu;
M(:,:,2)=1-Hu;
N_class=size(M,3);
e=zeros(size(M));
u=u0;
for kk=1:N_class
    e(:,:,kk) = KONE_Img - 2*Img.*C(kk).*KB1 + C(kk)^2*KB2;
end

for kk=1:iter_lse
    u=NeumannBoundCond(u);
    K=curvature_central(u);    % div()
    
    DiracU=Dirac(u,epsilon);
    ImageTerm=-DiracU.*(e(:,:,1)-e(:,:,2));
    
    penalizeTerm=mu*(4*del2(u)-K); % del2 is the discrete laplacian
    
    lengthTerm=nu.*DiracU.*K;
    
    u=u+timestep*(lengthTerm+penalizeTerm+ImageTerm);
end
end

% update b
function b =updateB(Img, C, M,  Ksigma)

PC1=zeros(size(Img));
PC2=PC1;
N_class=size(M,3);
for kk=1:N_class
    PC1=PC1+C(kk)*M(:,:,kk);
    PC2=PC2+C(kk)^2*M(:,:,kk);
end
KNm1 = conv2(PC1.*Img,Ksigma,'same');
KDn1 = conv2(PC2,Ksigma,'same');

b = KNm1./KDn1;
end

% Update C
function C_new =updateC(Img, u, Kb1, Kb2, epsilon)
Hu=Heaviside(u,epsilon);
M(:,:,1)=Hu;
M(:,:,2)=1-Hu;
N_class=size(M,3);
for kk=1:N_class
    Nm2 = Kb1.*Img.*M(:,:,kk);
    Dn2 = Kb2.*M(:,:,kk);
    C_new(kk) = sum(Nm2(:)) / sum(Dn2(:));
end
end



% Make a function satisfy Neumann boundary condition
function g = NeumannBoundCond(f)
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);  
end

function k = curvature_central(u)
% compute curvature for u with central difference scheme
[ux,uy] = gradient(u);
normDu = sqrt(ux.^2+uy.^2+1e-10);
Nx = ux./normDu;
Ny = uy./normDu;
[nxx,~] = gradient(Nx);
[~,nyy] = gradient(Ny);
k = nxx+nyy;
end

function h = Heaviside(x,epsilon)    
h=0.5*(1+(2/pi)*atan(x./epsilon));
end

function f = Dirac(x, epsilon)    
f=(epsilon/pi)./(epsilon^2.+x.^2);
end

function h = Hx(x)
h = 0.5 + atan(x)/pi;
end

function hp = Hxp(x)
hp = 1./(pi+pi*x.^2);
end