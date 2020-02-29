%Practice 4
%-----------PART 1----------
%   Generate the code such that you ask the user to introduce
%   values for flag and generator position. Display the final
%   cutline for speed, final cutline for position and 
%   defuzzyfied value.

% We define the universes 
X1 = 0:2:359;
X2 = -2.25:0.25:7.25;
X3 = 0:1:100;

% Define the membership function for the generator
ENgen = TrapezoidalMF(0,0,10,35,0,359,2);
Ngen = TrapezoidalMF(10,80,100,170,0,359,2);
Wgen = TrapezoidalMF(100,170,190,260,0,359,2);
Sgen = TrapezoidalMF(190,260,280,350,0,359,2);
ESgen = TrapezoidalMF(280,350,359,359,0,359,2);

% Define the membership function for the flag
ENflag = TrapezoidalMF(0,0,10,35,0,359,2);
Nflag = TrapezoidalMF(10,80,100,170,0,359,2);
Wflag = TrapezoidalMF(100,170,190,260,0,359,2);
Sflag = TrapezoidalMF(190,260,280,350,0,359,2);
ESflag = TrapezoidalMF(280,350,359,359,0,359,2);

% Define the membership function for the speed
Low = TrapezoidalMF(0,0,10,35,0,100,1);
Med = TrapezoidalMF(15,40,60,85,0,100,1);
High = TrapezoidalMF(65,90,100,100,0,100,1);

%   Define the membership function for the direction
CW = TrapezoidalMF(-2.25, -0.25, 0.25, 2.25,-2.25,7.25,0.25);
DM = TrapezoidalMF(0.25,2.25,2.75,4.75,-2.25,7.25,0.25);
ACW = TrapezoidalMF(2.75, 4.75, 5.25, 7.25,-2.25,7.25,0.25);

%   Input the values to evaluate
preFlag = input('Enter flag position (0-359): ');
preGen = input('Enter generator position(0-359): ');

Flag = preFlag/2;
Gen = preGen/2;

%   Minimos de ENgen con las posiciones de la bandera 

min1 = min(ENgen(Gen), ENflag(Flag)); %low,dm
min2 = min(ENgen(Gen), Nflag(Flag));%low,cw
min3 = min(ENgen(Gen), Wflag(Flag));%high,acw
min4 = min(ENgen(Gen), Sflag(Flag));%low,acw
min5 = min(ENgen(Gen), ESflag(Flag));%low, acw

%Minimos de Ngen con las posiciones de la bandera

min6 = min(Ngen(Gen), ENflag(Flag)); %med,acw
min7 = min(Ngen(Gen), Nflag(Flag)); %low,dm
min8 = min(Ngen(Gen), Wflag(Flag)); %low,cw
min9 = min(Ngen(Gen), Sflag(Flag));%high,cw
min10 = min(Ngen(Gen), ESflag(Flag));%med,acw

%Minimos de Wgen con las posiciones de la bandera

min11 = min(Wgen(Gen), ENflag(Flag));%high,cw
min12 = min(Wgen(Gen), Nflag(Flag));%low,acw
min13 = min(Wgen(Gen), Wflag(Flag));%low,dm
min14 = min(Wgen(Gen), Sflag(Flag));%med,cw
min15 = min(Wgen(Gen), ESflag(Flag));%high,cw

%Minimos de Sgen con las posiciones de la bandera

min16 = min(Sgen(Gen), ENflag(Flag));%med,cw
min17 = min(Sgen(Gen), Nflag(Flag));%high,cw
min18 = min(Sgen(Gen), Wflag(Flag));%med,acw
min19 = min(Sgen(Gen), Sflag(Flag));%low,dm
min20 = min(Sgen(Gen), ESflag(Flag));%med,cw


%Minimos de Sgen con las posiciones de la bandera

min21 = min(Sgen(Gen), ENflag(Flag));%low,cw
min22 = min(Sgen(Gen), Nflag(Flag));%med,cw
min23 = min(Sgen(Gen), Wflag(Flag));%high,acw
min24 = min(Sgen(Gen), Sflag(Flag));%low,acw
min25 = min(Sgen(Gen), ESflag(Flag));%low,dm

%Para la velocidad
V1 = [min1, min2, min4, min5, min7, min8, min12, min13, min19, min20, min24, min25];
maxlow = max(V1);

V2 = [min6, min10, min14, min16, min18, min20, min22];
maxmed = max(V2);

V3 = [min3,min9,min11,min15,min17,min23];
maxhigh = max(V3);

cutlinelow = min(maxlow,Low);
cutlinemed = min(maxmed,Med);
cutlinehigh = min(maxhigh,High);

maxc1 = max(cutlinelow, cutlinemed);
maxc2 = max(cutlinelow, cutlinehigh);
maxc3 = max(cutlinemed, cutlinehigh);

maxa = max(maxc1, maxc2);
finalcutlinespeed = max(maxa, maxc3);

subplot(1,2,1)
speed = defuzz(X3, finalcutlinespeed, 'centroid');
h1 = line([speed speed],[0 1],'Color','k');
t1 = text(speed,0.1,' centroid','FontWeight','bold');
hold on
plot(X3, finalcutlinespeed,'*',X3,Low,'b',X3,Med,'y',X3,High,'r','Linewidth',1.5)
legend({'Centroid','Finalcut Speed','Low','Med','High'},'Location','northeast')

%-----------PART 2----------
%   Generate the code to display the 3D plots for the behaviour
%   of speed and position for all the possible combinations of 
%   flag and generator position(step: 2 degrees)

