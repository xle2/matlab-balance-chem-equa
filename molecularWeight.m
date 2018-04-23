function result = molecularWeight(cellInput)
% ---------------------------------------------------------------------- %
%                                   ABOUT
%molecularWeight takes a chemical equation input from user in the form of a 
%cell array, then returns the molecular weight of each element in the
%equation
%For example: molecularWeight({'H2O','H2','O2'}) returns
%18.02  2.036  32.00
% ---------------------------------------------------------------------- %

mw.H = 1.008; mw.He = 4.003;

mw.Li = 6.941; mw.Be = 9.012; mw.B = 10.81; mw.C = 12.01; mw.N = 14.01;
mw.O = 16.00; mw.F = 19.00;mw. Ne = 20.18;

mw.Na = 22.99; mw.Mg = 24.31; mw.Al = 26.98; mw.Si = 28.09; mw.P = 30.97; 
mw.S = 32.07; mw.Cl = 35.45; mw.Ar = 39.95;

mw.K = 39.10; mw.Ca = 40.08; mw.Sc = 44.96; mw.Ti = 47.87; mw.V = 50.94; 
mw.Cr = 52.00; mw.Mn = 54.94; mw.Fe = 55.85; mw.Co = 58.93; mw.Ni = 58.69; 
mw.Cu = 63.55; mw.Zn = 65.38; mw.Ga = 69.72;mw.Ge = 72.63; mw.As = 74.92; 
mw.Se = 78.96; mw.Br = 79.91; mw.Kr = 83.80;


mw.Rb = 85.47;  mw.Sr = 87.62; mw.Y = 88.91; mw.Zr = 91.22; mw.Nb = 92.91;
mw.Mo = 95.95; mw.Tc = 98;
mw.Ru = 101.1; mw.Rh = 102.9; mw.Pd = 106.4; mw.Ag = 107.9; mw.Cd = 112.4; 
mw.In = 114.8; mw.Sn = 118.7;mw.Sb = 121.8; mw.Te = 127.6; mw.I = 126.9; 
mw.Xe = 131.3; 


mw.Cs = 132.9; mw.Ba = 137.3; mw.Lu = 175; mw.Hf = 178.5; mw.Ta = 181; 
mw.W = 183.8; mw.Re = 186.2; 
mw.Os = 190.2; mw.Ir = 192.2; mw.Pt = 195.1; mw.Au = 197; mw.Hg = 200.6; 
mw.Tl = 204.4; mw.Pb = 207; mw.Bi = 208; mw.Po = 209; mw.At = 210; mw.Rn = 222;  


mw.Fr = 223; mw.Ra = 226; mw.Lr = 262; mw.Rf = 261; mw.Db = 268; mw.Sg = 271; 
mw.Bh = 272; mw.Hs = 276; mw.Mt = 276; mw.Ds = 281; mw.Rg = 280; mw.Cn = 285; 


mw.La = 138.91; mw.Ce = 140; mw.Pr = 141; mw.Nd = 144; mw.Pm = 145; mw.Sm = 150; 
mw.Eu = 152; mw.Gd = 157; 
mw.Tb = 159; mw.Dy = 162.5; mw.Ho = 165; mw.Er = 167; mw.Tm = 169; mw.Yb = 173; 

mw.Ac = 227; mw.Th = 232; mw.Pa = 231; mw.U = 238; mw.Np = 237; mw.Pu = 244; 
mw.Am = 243; mw.Cm = 247; mw.Bk = 247; mw.Cf = 251; mw.Es = 252; mw.Fm = 257; 
mw.Md = 258; mw.No = 259;


r = countAtom(cellInput);
result = zeros(size(r)); %create the matrix of how many species there are
atoms = fields(r);

% r = countAtom({'H2O','H2','O2'});
% %size(r); zeros(size(r))
% result = zeros(size(r)); 
% atoms = fields(r);

%do a nest loop through the struct and each field of the struct
%find the molecular weight of each species, then keep adding values to the
%'result' matrix until all values are found
for i = 1:length(r)
    for j = 1:length(atoms)
        result(i) = result(i) + mw.(atoms{j})*r(i).(atoms{j});
    end
end

disp('The chemical equation in put is');
disp(cellInput);
disp('The molecular weight values are');
disp(result);


end

