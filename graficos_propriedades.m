

%Abrir espectros e dados propriedades f�sico-qu�micas
%11 - POnto de fluidez m�ximo D5853
cd('C:\Users\Marcia\Documents\MATLAB\RF\Dados de RMN H1');
[X1,API,ident2API,ppm,FileName] = leitor3('txt','parametros_fq_20141003.xlsx','PFQ',4,2);
[X2,PFL,ident2PFL,ppm,FileName] = leitor3('txt','parametros_fq_20141003.xlsx','PFQ',11,2);
[X3,SAT,ident2SAT,ppm,FileName] = leitor3('txt','parametros_fq_20141003.xlsx','PFQ',29,2);
[X4,ARO,ident2ARO,ppm,FileName] = leitor3('txt','parametros_fq_20141003.xlsx','PFQ',30,2);

%Retirar amostras para equivaler mesma quantidade de amostras em todas as 4
%propriedades
A=[1 6 8 12 26 35 37 39:41 43 46 47 68 75 93 97:102 104 111 117 123 135];
API(A)=[]; X_API(A,:)=[]; ident2API(A)=[];

B=[1 6 8 12 26 35 37 39:41 43 46 47 74 92 96:98];
SAT(B)=[]; ident2SAT(B)=[]; X_SAT(B,:)=[];
ARO(B)=[]; ident2ARO(B)=[]; X_ARO(B,:)=[];

C=[55 82 90 96 102];
PFL(C)=[]; ident2PFL(C)=[]; X_PFL(C,:)=[];
clear A B C
%%
%Histograma distribui��o propriedades
subplot(2,2,1), hist(API),xlabel('API','FontSize',16) 
subplot(2,2,2), hist(SAT),xlabel('Teor de Saturados (%m/m)','FontSize',16) 
subplot(2,2,3), hist(ARO),xlabel('Teor de Arom�ticos (%m/m)','FontSize',16) 
subplot(2,2,4), hist(PFL),xlabel('Ponto de Fluidez M�ximo (�C)','FontSize',16) 

%%
%GR�FICOS

%Gr�fico API x PFL

scatter(API,PFL, 40, 'filled');
xlabel 'API', ylabel 'Ponto de fluidez (�C)'

scatter (SAT,PFL, 40, 'filled');
xlabel 'Teor de saturados (%m/m)', ylabel 'Ponto de fluidez (�C)'

scatter (SAT_ARO,PFL, 50, POL, 'filled');
xlabel 'Arom�ticos e Polares (%m/m)', ylabel 'Ponto de fluidez (�C)'

scatter (POL,PFL,40,'filled');
xlabel 'Teor de Polares (%m/m)', ylabel 'Ponto de fluidez (�C)'
%Avaliar correla��o e covari�ncia

Propry=[API,SAT,ARO,PFL];

%Coeficiente de Correla��o
[R,P]=corrcoef(Propry) % Matriz de correla��o entre sd propriedades e 
imagesc(R)
[i,j]=find(P<0.05)%linhas e colunas onde a correla��o � significativa

%Xtra�o - matriz de tra�o de covari�ncia de X 
Xtraco = trace(cov(Propry));
VEX = (diag(cov(Propry))./Xtraco)*100; %VEX = colocando em porcentagem:
bar(VEX)%Observar as vari�ncias dos dados originais
xlabel('Propriedade','FontSize',14) % T�tulo do eixo-x 
ylabel('Vari�ncia','FontSize',14)   % T�tulo do eixo-y

%Gr�ficos 2D para relacionar com valores da propriedade
%SAT versus POL com marcadores de acordo com valor ponto de fluidez
SAT_ARO=(SAT+ARO); POL=100-(SAT_ARO); %calculando teor de polares

%Gr�fico relacionando Teor de saturados e polares ao tamanho do marcador
%pelo Ponto de fluidez
y1=PFL;
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(1)
for ki=1:length(y1)
    plot(SAT(ki,1),POL(ki,1),'bo','markersize',a1(ki)); hold on
    xlabel('Teor de Saturados (%m/m)','FontSize',14), ylabel('Teor de Polares (%m/m)','FontSize',14)
end

y1=PFL;
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(1)
for ki=1:length(y1)
    plot(POL(ki,1),PFL(ki,1),'bo','markersize',a1(ki)); hold on
    xlabel('Teor de polares (%m/m)','FontSize',14), ylabel('Ponto de fluidez (�C)','FontSize',14)
end

y1=PFL;
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(1)
for ki=1:length(y1)
    plot3(POL(ki,1),ARO(ki,1),PFL(ki,1),'bo','markersize',a1(ki)); hold on
    xlabel('Polares (%m/m)','FontSize',14), ylabel('Arom�ticos (%m/m)','FontSize',14),
    zlabel('Ponto de fluidez (�C))','FontSize',14)
end

