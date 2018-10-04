%Universidade Federal do Esp�rito Santo - Programa de P�s-Gradua�a� em Qu�mica
%Dados de Amostras de caf� selecionadas. Amostras especiais.
%Objetivo: H� alguma rela��o dos metais presentes com as propriedades analisadas na an�lise sensorial?
%sensoriais e de qualidade do caf�
%Mestranda: M�rcia Helena Cassago Nascimento
%Orientador Prof. Dr. Paulo Roberto Filgueiras

%AN�LISE POR COMPONENTES PRINCIPAIS - PCA
%OBJETIVO: IDENTIFICAR TEND�NCIAS DAS AMOSTRAS EM RELA��O �S PROPRIEDADES
%1� Avalia��o - Propriedade: Fragr�ncia
%%

%Abertura Matriz de dados
load ('matriz_dados.mat')

%Xtra�o - matriz de tra�o de covari�ncia de X 
Xtraco = trace(cov(X));
VEX = (diag(cov(X))./Xtraco)*100; %VEX = colocando em porcentagem:
bar(VEX)%Observar as vari�ncias dos dados originais
xlabel('Propriedade','FontSize',14) % T�tulo do eixo-x 
ylabel('Vari�ncia','FontSize',14)   % T�tulo do eixo-y

%Pr�-processamento dos dados 
hist(X(:,14)) % histograma dos dados da variavel da matriz X que demonstrou maior valores Vari�ncia.
Xp=pretrat(X,[],{'auto'});
subplot(2,1,1),hist(X(:,14))
subplot(2,1,2),hist(Xp(:,14))
subplot(2,1,1),plot(X)
subplot(2,1,2),plot(Xp)



%classificar em termos de matura��o
Maturacao=(PROPRIEDADES.Maturacao);
classes=unique(Maturacao);
y=[];
for ki=1:size(Maturacao,1)
    a2=find(Maturacao==60);
    y(a2,1)=[1];
    a3=find(Maturacao==80);
    y(a3,1)=[2];
    a4=find(Maturacao==100);
    y(a4,1)=[3];
end

%% PCA Chemometrics
%%
%Modelo 1 - Dados centrados na media sem pr�-processamento pr�vio
   
cd('C:\Users\M�rcia Cassago2016-1\Documents\MATLAB\MODELAGENS_DADOS_DIVERSOS\DADOS_CAFE\PCA_Chemometrics')

nvar=1:size(X,2);
classX=y;
xaxis=1:size(X,2);
nsamples=Amostras;
%modelo = pcamodel(X,{'center'});
%modelo = pcamodel(X,{'norm'},[],5);


modelo1 = pcamodel(X,{'center'},[],5,classX,xaxis,nsamples)

%Plot vari�veis
pcaplot(modelo1,n_var,[1,2],Amostras)

modelo1.P'*modelo1.P
modelo1.T'*modelo1.T

CC=corrcoef(X) % Matriz de correla��o de X
imagesc(CC)%Imagem de correla��o entre as vari�veis em X


%Correla��es entre as componentes principais e a propriedade de interesse
%Correlacinando entre PC para verificar se h� alguma rela��o entre as propriedades

%Gr�ficos 2D para relacionar com valores da propriedade
y1=PROPRIEDADES.Fragrancia;
%Pr�-processamento Centrado na M�dia - Modelo 01
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(5)
for ki=1:length(y1)
    plot(modelo1.T(ki,1),modelo1.T(ki,2),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14)
end
figure(6)
for ki=1:length(y1)
    plot(modelo1.T(ki,1),modelo1.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(7)
for ki=1:length(y1)
    plot(modelo1.T(ki,1),modelo1.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(8)
for ki=1:length(y1)
    plot(modelo1.T(ki,1),modelo1.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC5','FontSize',14)
end
figure(9)
for ki=1:length(y1)
    plot(modelo1.T(ki,2),modelo1.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(10)
for ki=1:length(y1)
    plot(modelo1.T(ki,2),modelo1.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(11)
for ki=1:length(y1)
    plot(modelo1.T(ki,2),modelo1.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC5','FontSize',14)
end

%Gr�ficos 3D
figure(12)
for ki=1:length(y1)
    plot3(modelo1.T(ki,1),modelo1.T(ki,2),modelo1.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC3','FontSize',14)
end
figure(13)
for ki=1:length(y1)
    plot3(modelo1.T(ki,1),modelo1.T(ki,2),modelo1.T(ki,4),'bo','markersize',a1(ki)); hold on
     xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC4','FontSize',14)
end

%%
%% Modelo 2 - Normaliza��o e centrado na m�dia dos dados n�o pr�-processados previamente

% PCA Chemometrics
%Modelo 1 - Dados centrados na media sem pr�-processamento pr�vio
   
cd('C:\Users\M�rcia Cassago2016-1\Documents\MATLAB\MODELAGENS_DADOS_DIVERSOS\DADOS_CAFE\PCA_Chemometrics')

nvar=1:size(X,2);
classX=y;
xaxis=1:size(X,2);
nsamples=Amostras;
%modelo = pcamodel(X,{'center'});
%modelo = pcamodel(X,{'norm'},[],5);


modelo2 = pcamodel(X,{'norm';'center'},[],5,classX,xaxis,nsamples)

%Plot vari�veis
pcaplot(modelo2,n_var,[1,2],Amostras)

modelo2.P'*modelo1.P
modelo2.T'*modelo1.T

CC=corrcoef(X) % Matriz de correla��o de X
imagesc(CC)%Imagem de correla��o entre as vari�veis em X


%Correla��es entre as componentes principais e a propriedade de interesse
%Correlacinando entre PC para verificar se h� alguma rela��o entre as propriedades

%Gr�ficos 2D para relacionar com valores da propriedade
y1=PROPRIEDADES.Fragrancia;
%Pr�-processamento Centrado na M�dia - Modelo 01
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(5)
for ki=1:length(y1)
    plot(modelo2.T(ki,1),modelo2.T(ki,2),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14)
end
figure(6)
for ki=1:length(y1)
    plot(modelo2.T(ki,1),modelo2.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(7)
for ki=1:length(y1)
    plot(modelo2.T(ki,1),modelo2.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(8)
for ki=1:length(y1)
    plot(modelo2.T(ki,1),modelo2.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC5','FontSize',14)
end
figure(9)
for ki=1:length(y1)
    plot(modelo2.T(ki,2),modelo2.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(10)
for ki=1:length(y1)
    plot(modelo2.T(ki,2),modelo2.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(11)
for ki=1:length(y1)
    plot(modelo2.T(ki,2),modelo2.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC5','FontSize',14)
end

%Gr�ficos 3D
figure(12)
for ki=1:length(y1)
    plot3(modelo2.T(ki,1),modelo2.T(ki,2),modelo2.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC3','FontSize',14)
end
figure(13)
for ki=1:length(y1)
    plot3(modelo2.T(ki,1),modelo2.T(ki,2),modelo2.T(ki,4),'bo','markersize',a1(ki)); hold on
     xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC4','FontSize',14)
end

%%
%% Modelo 3 - Corre��o multiplicativa de sinal e centrado na m�dia (dados sem pr�-processamento pr�vio)

% PCA Chemometrics
   
cd('C:\Users\M�rcia Cassago2016-1\Documents\MATLAB\MODELAGENS_DADOS_DIVERSOS\DADOS_CAFE\PCA_Chemometrics')

nvar=1:size(X,2);
classX=y;
xaxis=1:size(X,2);
nsamples=Amostras;
%modelo = pcamodel(X,{'center'});
%modelo = pcamodel(X,{'norm'},[],5);


modelo3 = pcamodel(X,{'msc';'center'},[],5,classX,xaxis,nsamples)

%Plot vari�veis
pcaplot(modelo3,n_var,[1,2],Amostras)

modelo3.P'*modelo3.P
modelo3.T'*modelo3.T

CC=corrcoef(X) % Matriz de correla��o de X
imagesc(CC)%Imagem de correla��o entre as vari�veis em X


%Correla��es entre as componentes principais e a propriedade de interesse
%Correlacinando entre PC para verificar se h� alguma rela��o entre as propriedades

%Gr�ficos 2D para relacionar com valores da propriedade
y1=PROPRIEDADES.Fragrancia;
%Pr�-processamento Centrado na M�dia - Modelo 01
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(5)
for ki=1:length(y1)
    plot(modelo3.T(ki,1),modelo3.T(ki,2),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14)
end
figure(6)
for ki=1:length(y1)
    plot(modelo3.T(ki,1),modelo3.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(7)
for ki=1:length(y1)
    plot(modelo3.T(ki,1),modelo3.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(8)
for ki=1:length(y1)
    plot(modelo3.T(ki,1),modelo3.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC5','FontSize',14)
end
figure(9)
for ki=1:length(y1)
    plot(modelo3.T(ki,2),modelo3.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(10)
for ki=1:length(y1)
    plot(modelo3.T(ki,2),modelo3.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(11)
for ki=1:length(y1)
    plot(modelo3.T(ki,2),modelo3.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC5','FontSize',14)
end

%Gr�ficos 3D
figure(12)
for ki=1:length(y1)
    plot3(modelo3.T(ki,1),modelo3.T(ki,2),modelo3.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC3','FontSize',14)
end
figure(13)
for ki=1:length(y1)
    plot3(modelo3.T(ki,1),modelo3.T(ki,2),modelo3.T(ki,4),'bo','markersize',a1(ki)); hold on
     xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC4','FontSize',14)
end

%%
%% Modelo 4 - Derivada e centrado na m�dia (dados sem pr�-processamento pr�vio)

% PCA Chemometrics
   
cd('C:\Users\M�rcia Cassago2016-1\Documents\MATLAB\MODELAGENS_DADOS_DIVERSOS\DADOS_CAFE\PCA_Chemometrics')

nvar=1:size(X,2);
classX=y;
xaxis=1:size(X,2);
nsamples=Amostras;
%modelo = pcamodel(X,{'center'});
%modelo = pcamodel(X,{'norm'},[],5);


modelo4 = pcamodel(X,{'deriv';[9,2,1];'center'},[],5,classX,xaxis,nsamples)

%Plot vari�veis
pcaplot(modelo4,n_var,[1,2],Amostras)

modelo4.P'*modelo4.P
modelo4.T'*modelo4.T

CC=corrcoef(X) % Matriz de correla��o de X
imagesc(CC)%Imagem de correla��o entre as vari�veis em X


%Correla��es entre as componentes principais e a propriedade de interesse
%Correlacinando entre PC para verificar se h� alguma rela��o entre as propriedades

%Gr�ficos 2D para relacionar com valores da propriedade
y1=PROPRIEDADES.Fragrancia;
%Pr�-processamento Centrado na M�dia - Modelo 01
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(5)
for ki=1:length(y1)
    plot(modelo4.T(ki,1),modelo4.T(ki,2),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14)
end
figure(6)
for ki=1:length(y1)
    plot(modelo4.T(ki,1),modelo4.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(7)
for ki=1:length(y1)
    plot(modelo4.T(ki,1),modelo4.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(8)
for ki=1:length(y1)
    plot(modelo4.T(ki,1),modelo4.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC5','FontSize',14)
end
figure(9)
for ki=1:length(y1)
    plot(modelo4.T(ki,2),modelo4.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(10)
for ki=1:length(y1)
    plot(modelo4.T(ki,2),modelo4.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(11)
for ki=1:length(y1)
    plot(modelo4.T(ki,2),modelo4.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC5','FontSize',14)
end

%Gr�ficos 3D
figure(12)
for ki=1:length(y1)
    plot3(modelo4.T(ki,1),modelo4.T(ki,2),modelo4.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC3','FontSize',14)
end
figure(13)
for ki=1:length(y1)
    plot3(modelo4.T(ki,1),modelo4.T(ki,2),modelo4.T(ki,4),'bo','markersize',a1(ki)); hold on
     xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC4','FontSize',14)
end
%%
%% Modelo 5 - Autoescalonamento (dados sem pr�-processamento pr�vio)

% PCA Chemometrics
   
cd('C:\Users\M�rcia Cassago2016-1\Documents\MATLAB\MODELAGENS_DADOS_DIVERSOS\DADOS_CAFE\PCA_Chemometrics')

nvar=1:size(X,2);
classX=y;
xaxis=1:size(X,2);
nsamples=Amostras;
%modelo = pcamodel(X,{'center'});
%modelo = pcamodel(X,{'norm'},[],5);


modelo5 = pcamodel(X,{'auto'},[],5,classX,xaxis,nsamples) 

%Plot vari�veis
pcaplot(modelo5,n_var,[1,2],Amostras)

modelo5.P'*modelo5.P
modelo5.T'*modelo5.T

CC=corrcoef(X) % Matriz de correla��o de X
imagesc(CC)%Imagem de correla��o entre as vari�veis em X


%Correla��es entre as componentes principais e a propriedade de interesse
%Correlacinando entre PC para verificar se h� alguma rela��o entre as propriedades

%Gr�ficos 2D para relacionar com valores da propriedade
y1=PROPRIEDADES.Fragrancia;
%Pr�-processamento Centrado na M�dia - Modelo 01
a1=20*(y1-min(y1))/(max(y1)-min(y1))+5;
figure(5)
for ki=1:length(y1)
    plot(modelo5.T(ki,1),modelo5.T(ki,2),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14)
end
figure(6)
for ki=1:length(y1)
    plot(modelo5.T(ki,1),modelo5.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(7)
for ki=1:length(y1)
    plot(modelo5.T(ki,1),modelo5.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(8)
for ki=1:length(y1)
    plot(modelo5.T(ki,1),modelo5.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC5','FontSize',14)
end
figure(9)
for ki=1:length(y1)
    plot(modelo5.T(ki,2),modelo5.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC3','FontSize',14)
end
figure(10)
for ki=1:length(y1)
    plot(modelo5.T(ki,2),modelo5.T(ki,4),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC4','FontSize',14)
end
figure(11)
for ki=1:length(y1)
    plot(modelo5.T(ki,2),modelo5.T(ki,5),'bo','markersize',a1(ki)); hold on
    xlabel('PC2','FontSize',14), ylabel('PC5','FontSize',14)
end

%Gr�ficos 3D
figure(12)
for ki=1:length(y1)
    plot3(modelo5.T(ki,1),modelo5.T(ki,2),modelo5.T(ki,3),'bo','markersize',a1(ki)); hold on
    xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC3','FontSize',14)
end
figure(13)
for ki=1:length(y1)
    plot3(modelo5.T(ki,1),modelo5.T(ki,2),modelo5.T(ki,4),'bo','markersize',a1(ki)); hold on
     xlabel('PC1','FontSize',14), ylabel('PC2','FontSize',14), zlabel('PC4','FontSize',14)
end
figure(13)
for ki=1:length(y1)
    plot3(modelo5.T(ki,2),modelo5.T(ki,3),modelo5.T(ki,4),'bo','markersize',a1(ki)); hold on
     xlabel('PC2','FontSize',14), ylabel('PC3','FontSize',14), zlabel('PC4','FontSize',14)
end

%%


%%











