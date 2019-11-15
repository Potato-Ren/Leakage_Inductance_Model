%%%%%%Leakage inductance calcultation code of CM choke%%%%%%%%%
%%%%%%mimic the Rod core inductance calacultation%%%%%%%
%%%%%Writen by Ren%%%%%%%%
%%core number: ZW43610TC
%lc and dc are the length and diameter of the coil
%N is turns number
Lk = LleakS1(:, 7);
thetax = LleakS1(:, 6) ./ pi .* 180;
Nt = LleakS1(:, 2);
length_core = length(LleakS1);
for i = 1:1:length_core
    N = LleakS1(i, 2);
    % theta = N/65* pi;  %41?65
    % theta1=theta/pi*180;
    theta = LleakS1(i, 6);
    theta1 = theta / pi * 180;
    le = 89.6; %unit: mm
    %%%ht:thickness of the core
    ht = 10.7; %unit: mm
    %%id: inner diameter
    id = 23;
    %
   %%%%%%%%%%%%%%%%%calculate the air core indutance%%%%%%%%%%%%%%%%%
    %%%%lc is length of coil
    %%%%lf is effective length of rod ferrite core

    lc = le / 2 * theta / (1 * pi);
    lf = le / 2; %unit: mm

    %lc = 31.66; %mm
    %A is the area of the coil cross section
    u0 = 4e-7 * pi;
    %lf and df are the length and diameter of the ferrite
    % lf = le/2; %unit: mm
    %%%%%%%
    %%%df: diameter of crosssectioinal ferrite core
    %%%dc: diameter of  coil
    df = sqrt(63.9); %unit: mm
    dc = df * sqrt(2); %mm
    %x=Rin_air/Rout_air, the reluctance ratio between the inside air and outside air magnetic path
    lc1 = lc + 0.45 * dc;
    x = 5.1 * (lc1 / dc) / (1 + 2.8 * (dc / lc1));
    %1/k=Rout_f/Rout_air, the reluctance ratio between the outside coil with magnetic and outside coil without magnetic
    lfc1 = lf - lc;
    %uf the relative permebility of ferrte
    uf = 10000;
    e0 = 8.85e-12; %F/m

    ufe = (uf - 1) * (df / dc)^2 + 1;
    Kn = 1 / (1 + 0.45 * (dc / lc) - 0.005 * (dc / lc)^2);
    A = (dc / 2)^2 * pi;
    Lair = u0 * N^2 * A / lc * Kn * 1e-3;

    %%%%%%%%%%%%%%%%Calculate the leakage inductance%%%%%%%%%%%%%%%%%%%%%%
    %k=Rout_air/Rout_f
    k =  (1.75 * df * 1e-3)/((pi - theta) * ht * 1e-3 / (1 + cos((pi - theta) / 2)) + 0.8 * df * 1e-3) ;

    Lf = (1 + x) / ( k + x / ufe) * Lair;
    r = (1 + x) / ( k + x / ufe);
    % end
    Llk2(i) = Lf;
end

Llk3 = Llk2';
Error = (Llk3 - Lk) ./ Lk;
figure(1);
plot(Nt(167:175), Lk(167:175), Nt(167:175), Llk3(167:175))
figure(2);
plot(Nt(167:175), abs(Error(167:175)))
% figure(1);
% plot(Nt(26:34),Lk(26:34),Nt(26:34),Llk3(26:34))
% figure(2);
% plot(Nt(26:34),abs(Error(26:34)))
