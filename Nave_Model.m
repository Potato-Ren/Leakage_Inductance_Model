%%%%%%Leakage inductance calcultation code of CM choke%%%%%%%%%
%%%%%%mimic the Rod core inductance calacultation%%%%%%%
%%%%%Writen by Ren%%%%%%%%

%lc and dc are the length and diameter of the coil
%N is turns number
length_core = length(LleakS1);

for i = 1:1:length_core
    N = LleakS1(i, 2);
    % theta = N/65* pi;  %41?65
    % theta1=theta/pi*180;
    theta = LleakS1(i, 6);
    theta1 = theta / pi * 180;
    % df = sqrt(1.16*100); %unit: mm
    % dc = df*sqrt(2); %mm
    le = 89.6/10; %unit: mm
    Ae = 63.9/100;
    Ldm = 0.4 * pi * N^2 * Ae / le / sqrt(theta1 / 360 + sin(theta / 2) / pi) * 1e-8/2;
    Tao = sqrt(pi / Ae) * le / 2;
    udm = 2.3 * Tao^1.45;
    Llk4(i) = Ldm * udm;
end

Error1 = (Llk4' - Lk) ./ Lk;
figure(2);
hold on;
plot(Nt(167:175), abs(Error1(167:175)));
hold off;
figure(1);
hold on;
plot(Nt(167:175), Llk4(167:175))
hold off;

%  figure(2);
%  hold on;
% plot(Nt(26:34),abs(Error1(26:34)));
% hold off;
%  figure(1);
%  hold on;
% plot(Nt(26:34),Llk4(26:34))
% hold off;
