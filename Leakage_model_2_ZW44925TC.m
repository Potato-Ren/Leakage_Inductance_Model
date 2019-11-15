%%%%%%Leakage inductance calcultation code of CM choke%%%%%%%%%
%%%%%%mimic the Rod core inductance calacultation%%%%%%%
%%%%%Writen by Ren%%%%%%%%
%%%core number: ZW44925TC
%lc and dc are the length and diameter of the coil
%N is turns number
Lk = LleakS1(:, 8);
thetax = LleakS1(:, 6) ./ pi .* 180;
length_core = length(LleakS1);
Nt = LleakS1(:, 2);

for i = 1:1:length_core
    N = LleakS1(i, 2);
    % theta = N/65* pi;  %41?65
    % theta1=theta/pi*180;
    theta = LleakS1(i, 6);
    theta1 = theta / pi * 180;
    le = 123.2; %unit: mm
    %%%ht:thickness of the core
    ht = 18.8; %unit: mm
    %%id: inner diameter
    id = 30.27;
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
    df = sqrt(160.1); %unit: mm
    dc = df * sqrt(2); %mm
    %x=Rin_air/Rout_air, the reluctance ratio between the inside air and outside air magnetic path
    lc1 = lc + 0.45 * dc;
    x = 5.1 * (lc1 / dc) / (1 + 2.8 * (dc / lc1));
    %1/k=Rout_f/Rout_air, the reluctance ratio between the outside coil with magnetic and outside coil without magnetic
    lfc1 = lf - lc;
    %uf the relative permebility of ferrte
    uf = 10000;
    e0 = 8.85e-12; %F/m
    flux_r = 1 / (1 + (lfc1 / df)^1.4 / (5 * uf));
    Canf = 0.5 * pi * e0 * (lf - lc) * 1e-3 / (log(2 * (lf + df) / df) - 1);
    k = ((flux_r * Canf / e0) + 2 * df * 1e-3) / (2 * dc * 1e-3);
    ufe = (uf - 1) * (df / dc)^2 + 1;
    Kn = 1 / (1 + 0.45 * (dc / lc) - 0.005 * (dc / lc)^2);
    A = (dc / 2)^2 * pi;
    Lair = u0 * N^2 * A / lc * Kn * 1e-3;

    %%%%%%%%%%%%%%%%Calculate the leakage inductance%%%%%%%%%%%%%%%%%%%%%%
    %k=Rout_air/Rout_f
    k = ((pi - theta) * ht * 1e-3 / (1 + cos((pi - theta) / 2)) + 0.8 * df * 1e-3) / (1.75 * df * 1e-3);

    Lf = (1 + x) / (1 / k + x / ufe * pi / 2) * Lair;
    r = (1 + x) / (1 / k + x / ufe * pi / 2);
    % end
    Llk2(i) = Lf;
end

Llk3 = Llk2';
Error = (Llk3 - Lk) ./ Lk;
% figure(1);
% plot(Nt(120:128),Lk(120:128),Nt(120:128),Llk3(120:128))
% figure(2);
% plot(Nt(120:128),abs(Error(120:128)))

figure(1);
plot(Nt(19:27), Lk(19:27), Nt(19:27), Llk3(19:27))
figure(2);
plot(Nt(19:27), abs(Error(19:27)))
