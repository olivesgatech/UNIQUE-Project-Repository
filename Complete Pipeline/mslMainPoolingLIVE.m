function mslMainPoolingLIVE(poolInd, metInd, paramIndArray, blockSize)

%% 
poolingCounter=size(paramIndArray,2);

nDist=5;
nMetric=poolingCounter;
numCorr=3;
corrMat=zeros(numCorr,nMetric,nDist);
rmseMat=zeros(nMetric,nDist);
corrMatOrg=zeros(numCorr,nMetric,nDist);
corrType='Pearson';
corrType2='Spearman';
corrType3='Kendall';
orderDist=char('Jp2k','Jpeg','Wn','Gblur','Fastfading','All');
%%
%  counter=1


for ii=1:poolingCounter
paramInd=paramIndArray(ii);
    
%%
%Directory Configuration
dataDir=['../../databases',filesep,'live'];

load([dataDir,filesep,'dmos.mat']);
load([dataDir,filesep,'refnames_all.mat']);
%Image directories
data=[filesep,'live',filesep];
imgDirRef=['../../databases',data,'refimgs',filesep];
imgDirFastfading=['../../databases',data,'fastfading',filesep];
imgDirGblur=['../../databases',data,'gblur',filesep];
imgDirJp2k=['../../databases',data,'jp2k',filesep];
imgDirJpeg=['../../databases',data,'jpeg',filesep];
imgDirWn=['../../databases',data,'wn',filesep];

refFiles=dir([imgDirRef,'*.bmp']);
fastfadingFiles=dir([imgDirFastfading,'*.bmp']);
gblurFiles=dir([imgDirGblur,'*.bmp']);
jp2kFiles=dir([imgDirJp2k,'*.bmp']);
jpegFiles=dir([imgDirJpeg,'*.bmp']);
wnFiles=dir([imgDirWn,'*.bmp']);

  
len=length(refFiles);
img(len)=NImgV2;
%%
for i=1:len  
    i
img(i).Img=imread(strcat(imgDirRef,refFiles(i).name));
img(i).ImgYcbcr=rgb2ycbcr(img(i).Img);
temp=uint8(zeros(size(img(i).Img)));
temp2=temp;
temp3=temp;
%% Fastfading
%Fastfading
z=1;
ind = 1;
offset=808;  
fid=fopen([imgDirFastfading,'info.txt']);
[list, count]=textscan(fid,'%s');
    jLen=length(list{1,1});
    k=1;
    for j=1:jLen 
        if (strcmp(list{1,1}{j,1},refFiles(i).name))
            img(i).ImgFastfading(:,:,:,k)=imread([imgDirFastfading,list{1,1}{j+1,1}]);            
            img(i).ParamFastfading(k)=str2double(list{1,1}{j+2,1});
            tt=list{1,1}{j+1,1};
            img(i).Dmos(z,k)=dmos(str2double(tt(4:end-4))+offset);
            img(i).DmosFlag(z,k)=orgs(str2double(tt(4:end-4))+offset);                     
            [img(i).ColDistFastfading(k)]=mslPoolingMetric(img(i).Img,uint8(img(i).ImgFastfading(:,:,:,k)),metInd,poolInd,paramInd, blockSize);          
            k=k+1;
        end        
    end
 fclose(fid);
 %save('Database1.mat','Database');
 %% Gblur
z=2;
offset=634;    
fid=fopen([imgDirGblur,'info.txt']);
[list, count]=textscan(fid,'%s');
jLen=length(list{1,1});
k=1;
    for j=1:jLen 
        if (strcmp(list{1,1}{j,1},refFiles(i).name))
           img(i).ImgGblur(:,:,:,k)=imread([imgDirGblur,list{1,1}{j+1,1}]);
           img(i).ParamGblur(k)=str2double(list{1,1}{j+2,1});            
           tt=list{1,1}{j+1,1};
%            showNum(counter)=str2double(tt(4:end-4))+offset;
%            counter=counter+1
           img(i).Dmos(z,k)=dmos(str2double(tt(4:end-4))+offset);
           img(i).DmosFlag(z,k)=orgs(str2double(tt(4:end-4))+offset);                    
           [img(i).ColDistGblur(k)] =mslPoolingMetric(img(i).Img,uint8(img(i).ImgGblur(:,:,:,k)),metInd,poolInd,paramInd, blockSize);      
           k=k+1;
        end        
    end
fclose(fid); 
%save('Database2.mat','Database');
%% JP2K
z=3;
offset=0;    
fid=fopen([imgDirJp2k,'info.txt']);
[list, count]=textscan(fid,'%s');
jLen=length(list{1,1});
k=1;
    for j=1:jLen 
        if (strcmp(list{1,1}{j,1},refFiles(i).name))
           img(i).ImgJp2k(:,:,:,k)=imread([imgDirJp2k,list{1,1}{j+1,1}]);
           img(i).ParamJp2k(k)=str2double(list{1,1}{j+2,1});
           tt=list{1,1}{j+1,1};
           img(i).Dmos(z,k)=dmos(str2double(tt(4:end-4))+offset);
           img(i).DmosFlag(z,k)=orgs(str2double(tt(4:end-4))+offset);
           [img(i).ColDistJp2k(k)]=mslPoolingMetric(img(i).Img,uint8(img(i).ImgJp2k(:,:,:,k)),metInd,poolInd,paramInd, blockSize);        
           k=k+1;
        end        
    end
fclose(fid);
%save('Database3.mat','Database');
%% JPEG
z=4;
offset=227;    
fid=fopen([imgDirJpeg,'info.txt']);
[list, count]=textscan(fid,'%s');
jLen=length(list{1,1});
k=1;
    for j=1:jLen 
        if (strcmp(list{1,1}{j,1},refFiles(i).name))
           img(i).ImgJpeg(:,:,:,k)=imread([imgDirJpeg,list{1,1}{j+1,1}]);
           img(i).ParamJpeg(k)=str2double(list{1,1}{j+2,1}); 
           tt=list{1,1}{j+1,1};
           img(i).Dmos(z,k)=dmos(str2double(tt(4:end-4))+offset);
           img(i).DmosFlag(z,k)=orgs(str2double(tt(4:end-4))+offset);     
           [img(i).ColDistJpeg(k)]=mslPoolingMetric(img(i).Img,uint8(img(i).ImgJpeg(:,:,:,k)),metInd,poolInd,paramInd, blockSize);      
           k=k+1;
        end        
    end
 fclose(fid);
 %save('Database4.mat','Database');
%% WN
z=5;
offset=460;
fid=fopen([imgDirWn,'info.txt']);
[list, count]=textscan(fid,'%s');
jLen=length(list{1,1});
k=1;
    for j=1:jLen 
        if (strcmp(list{1,1}{j,1},refFiles(i).name))
           img(i).ImgWn(:,:,:,k)=imread([imgDirWn,list{1,1}{j+1,1}]);
           img(i).ParamWn(k)=str2double(list{1,1}{j+2,1});
           tt=list{1,1}{j+1,1};
           img(i).Dmos(z,k)=dmos(str2double(tt(4:end-4))+offset);
           img(i).DmosFlag(z,k)=orgs(str2double(tt(4:end-4))+offset);                    
           [img(i).ColDistWn(k)]=mslPoolingMetric(img(i).Img,uint8(img(i).ImgWn(:,:,:,k)),metInd,poolInd,paramInd, blockSize);
           k=k+1;
        end        
    end
 fclose(fid);
%   fprintf(repmat('\b',1,nl)); fprintf('Counter:%d/%d',i,len);nl=length(['Counter:',num2str(i),'/',num2str(len)]);   
end

%%
s1=0;
s2=0;
if (s1==0)
   difVal=0; mult=1;
elseif (s1==1)
   difVal=1; mult=-1;          
end
len=size(img,2);
nChan=3;
n=1;
%% JPEG
for i=1:len          
lenJpeg=size(img(i).ParamJpeg,2);
[param, paramOrder]=sort(img(i).ParamJpeg);
dmosInd=4;
    for j=1:lenJpeg 
        tempJpegDmos{i}(j)=img(i).Dmos(dmosInd,paramOrder(j));
        JpegDmosFlag{i}(j)=img(i).DmosFlag(dmosInd,paramOrder(j));
        tempJpegColDist{i}(j,n)=img(i). ColDistJpeg(paramOrder(j));
    end      
       tempJpegColDist{i}(:,n)=difVal+mult*tempJpegColDist{i}(:,n);        
end
JpegColDistFull=zeros(1,1);
n=1;
for p=1:len
JpegColDistFull=horzcat(JpegColDistFull,tempJpegColDist{p}(:,n)');
end
if (s2==1)
   JpegColDistFull=JpegColDistFull/max(JpegColDistFull);           
end
JpegColDistFull=JpegColDistFull(2:end);
%% JP2K
for i=1:len        
lenJp2k=size(img(i).ParamJp2k,2);
[param, paramOrder]=sort(img(i).ParamJp2k);
dmosInd=3;
for j=1:lenJp2k 
    tempJp2kDmos{i}(j)=img(i).Dmos(dmosInd,paramOrder(j));
    Jp2kDmosFlag{i}(j)=img(i).DmosFlag(dmosInd,paramOrder(j));
    tempJp2kColDist{i}(j,n)=img(i). ColDistJp2k(paramOrder(j));
end      
tempJp2kColDist{i}(:,n)=difVal+mult*tempJp2kColDist{i}(:,n);        
end
Jp2kColDistFull=zeros(1,1);
for p=1:len
    Jp2kColDistFull=horzcat(Jp2kColDistFull,tempJp2kColDist{p}(:,n)');
end
if (s2==1)
    Jp2kColDistFull=Jp2kColDistFull/max(Jp2kColDistFull);
end
Jp2kColDistFull=Jp2kColDistFull(2:end);
%% WN
for i=1:len   
lenWn=size(img(i).ParamWn,2);
[param, paramOrder]=sort(img(i).ParamWn);
dmosInd=5;
for j=1:lenWn 
    tempWnDmos{i}(j)=img(i).Dmos(dmosInd,paramOrder(j));
    WnDmosFlag{i}(j)=img(i).DmosFlag(dmosInd,paramOrder(j));  
    tempWnColDist{i}(j,n)=img(i). ColDistWn(paramOrder(j));       
end 
    tempWnColDist{i}(:,n)=difVal+mult*tempWnColDist{i}(:,n);        
end
WnColDistFull=zeros(1,1);
for p=1:len
    WnColDistFull=horzcat(WnColDistFull,tempWnColDist{p}(:,n)');
end
if (s2==1)
   WnColDistFull=WnColDistFull/max(WnColDistFull);
end
WnColDistFull=WnColDistFull(2:end);
%% Fastfading
for i=1:len       
lenFastfading=size(img(i).ParamFastfading,2);
[param, paramOrder]=sort(img(i).ParamFastfading);
dmosInd=1;
for j=1:lenFastfading 
    tempFastfadingDmos{i}(j)=img(i).Dmos(dmosInd,paramOrder(j));
    FastfadingDmosFlag{i}(j)=img(i).DmosFlag(dmosInd,paramOrder(j));   
    tempFastfadingColDist{i}(j,n)=img(i). ColDistFastfading(paramOrder(j));        
end          
tempFastfadingColDist{i}(:,n)=difVal+mult*tempFastfadingColDist{i}(:,n);       
end
FastfadingColDistFull=zeros(1,1);
for p=1:len
    FastfadingColDistFull=horzcat(FastfadingColDistFull,tempFastfadingColDist{p}(:,n)');
end
if (s2==1)
   FastfadingColDistFull=FastfadingColDistFull/max(FastfadingColDistFull);
end
FastfadingColDistFull=FastfadingColDistFull(2:end);
%% GBlur
for i=1:len         
lenGblur=size(img(i).ParamGblur,2);
[param, paramOrder]=sort(img(i).ParamGblur);
dmosInd=2;
for j=1:lenGblur 
    tempGblurDmos{i}(j)=img(i).Dmos(dmosInd,paramOrder(j));
    GblurDmosFlag{i}(j)=img(i).DmosFlag(dmosInd,paramOrder(j));
    tempGblurColDist{i}(j,n)=img(i). ColDistGblur(paramOrder(j));
end            
tempGblurColDist{i}(:,n)=difVal+mult*tempGblurColDist{i}(:,n);        
end
GblurColDistFull=zeros(1,1);
for p=1:len
GblurColDistFull=horzcat(GblurColDistFull,tempGblurColDist{p}(:,n)');
end
if (s2==1)
    GblurColDistFull=GblurColDistFull/max(GblurColDistFull);
end
GblurColDistFull=GblurColDistFull(2:end);
%%
JpegDmos=zeros(1,1);
Jp2kDmos=zeros(1,1);
WnDmos=zeros(1,1);
GblurDmos=zeros(1,1);
FastfadingDmos=zeros(1,1);
%%%% DMOS %%%%
for p=1:len
JpegDmos=vertcat(JpegDmos,tempJpegDmos{p}(:));
Jp2kDmos=vertcat(Jp2kDmos,tempJp2kDmos{p}(:));
WnDmos=vertcat(WnDmos,tempWnDmos{p}(:));
GblurDmos=vertcat(GblurDmos,tempGblurDmos{p}(:));
FastfadingDmos=vertcat(FastfadingDmos,tempFastfadingDmos{p}(:));
end
JpegDmos=JpegDmos(2:end)';
Jp2kDmos=Jp2kDmos(2:end)';
WnDmos=WnDmos(2:end)';
GblurDmos=GblurDmos(2:end)';
FastfadingDmos=FastfadingDmos(2:end)';

%DMOS
DmosScore=horzcat(FastfadingDmos,GblurDmos,Jp2kDmos,JpegDmos,WnDmos);



%       %ColDist
 ColDistFull=horzcat(FastfadingColDistFull,GblurColDistFull,Jp2kColDistFull,JpegColDistFull,WnColDistFull);

%  
%%




rInd=ii;
%% Additional


%%

%% ALL
cInd=6;
y=DmosScore';
len=size(y,1);
linX=1:len; linX=(linX/max(linX))*100;
linY=linX;
modelFun=@(b,x) b(1).*((1/2)-1./(1+exp(b(2).*(x-b(3)))))+b(4).*x+b(5);

%ColDist



x=ColDistFull';
% figure,hist(abs(x),10)
% figure
x(isnan(x))=0;
x(isinf(x))=0;
% x=x/max(x);

% start=[0.0,0.1,0.0,0.0,0.0]';
% nlmColDist=fitnlm(x,y,modelFun,start);
% temp=predict(nlmColDist,x);
temp=abs(x);
x = abs(x);
corrMat(1,rInd,cInd)=corr(temp,y,'Type',corrType);
corrMat(2,rInd,cInd)=corr(temp,y,'Type',corrType2);
corrMat(3,rInd,cInd)=corr(temp,y,'Type',corrType3);
rmseMat(rInd,cInd)=sqrt(mean((temp-y).^2));
corrMatOrg(1,rInd,cInd)=corr(x,y,'Type',corrType);
corrMatOrg(2,rInd,cInd)=corr(x,y,'Type',corrType2);
corrMatOrg(3,rInd,cInd)=corr(x,y,'Type',corrType3);

% 
% subplot(1,2,1)
% plot(x,y,'bo');
% xlabel('x'); ylabel('y');
% xx=linspace(min(x),max(x))';
% line(xx,predict(nlmColDist,xx),'linestyle','-','color','r','LineWidth',2);
% dmosDev=std(y);
% line(xx,predict(nlmColDist,xx)+dmosDev,'linestyle','--','color','r','LineWidth',2);
% line(xx,predict(nlmColDist,xx)-dmosDev,'linestyle','--','color','r','LineWidth',2);
% line(xx,predict(nlmColDist,xx)+2*dmosDev,'linestyle',':','color','r','LineWidth',2);
% line(xx,predict(nlmColDist,xx)-2*dmosDev,'linestyle',':','color','r','LineWidth',2);
% % corrMatOrg(rInd,cInd)=corr(x,y,'Type',corrType);
%  title(['BEFORE: cqa ','CC: ',num2str(corrMatOrg(1,rInd,cInd))]);
% 
% 
% 
% 
% 
% subplot(1,2,2)
% scatter(temp,y); title(['AFTER: cqa ','CC: ',num2str(corrMat(1,rInd,cInd)),' Rmse: ',num2str(rmseMat(rInd,cInd))]);
% hold on, plot(linX,linY,'linestyle','-','color','r','LineWidth',2);
% hold on, plot(linX,linY+std(y),'linestyle','--','color','r','LineWidth',2);
% hold on, plot(linX,linY-std(y),'linestyle','--','color','r','LineWidth',2);
% hold on, plot(linX,linY+2*std(y),'linestyle',':','color','r','LineWidth',2);
% hold on, plot(linX,linY-2*std(y),'linestyle',':','color','r','LineWidth',2);






%% JPEG
cInd=2;
y=JpegDmos';
%ColDist
x=JpegColDistFull';
x(isnan(x))=0;
x(isinf(x))=0;

% temp=predict(nlmColDist,x);
temp=x;

corrMat(1,rInd,cInd)=corr(temp,y,'Type',corrType);
corrMat(2,rInd,cInd)=corr(temp,y,'Type',corrType2);
corrMat(3,rInd,cInd)=corr(temp,y,'Type',corrType3);
rmseMat(rInd,cInd)=sqrt(mean((temp-y).^2));
corrMatOrg(1,rInd,cInd)=corr(x,y,'Type',corrType);
corrMatOrg(2,rInd,cInd)=corr(x,y,'Type',corrType2);
corrMatOrg(3,rInd,cInd)=corr(x,y,'Type',corrType3);

%% JP2K
cInd=1;
y=Jp2kDmos';
x=Jp2kColDistFull';
x(isnan(x))=0;
x(isinf(x))=0;



% temp=predict(nlmColDist,x);
temp=x;

corrMat(1,rInd,cInd)=corr(temp,y,'Type',corrType);
corrMat(2,rInd,cInd)=corr(temp,y,'Type',corrType2);
corrMat(3,rInd,cInd)=corr(temp,y,'Type',corrType3);
rmseMat(rInd,cInd)=sqrt(mean((temp-y).^2));
corrMatOrg(1,rInd,cInd)=corr(x,y,'Type',corrType);
corrMatOrg(2,rInd,cInd)=corr(x,y,'Type',corrType2);
corrMatOrg(3,rInd,cInd)=corr(x,y,'Type',corrType3);
%% Wn
cInd=3;
y=WnDmos';
%ColDist
x=WnColDistFull';
x(isnan(x))=0;
x(isinf(x))=0;



% temp=predict(nlmColDist,x);
temp=x;

corrMat(1,rInd,cInd)=corr(temp,y,'Type',corrType);
corrMat(2,rInd,cInd)=corr(temp,y,'Type',corrType2);
corrMat(3,rInd,cInd)=corr(temp,y,'Type',corrType3);
rmseMat(rInd,cInd)=sqrt(mean((temp-y).^2));
corrMatOrg(1,rInd,cInd)=corr(x,y,'Type',corrType);
corrMatOrg(2,rInd,cInd)=corr(x,y,'Type',corrType2);
corrMatOrg(3,rInd,cInd)=corr(x,y,'Type',corrType3);
%% Gblur
cInd=4;
y=GblurDmos';
%ColDist
x=GblurColDistFull';
x(isnan(x))=0;
x(isinf(x))=0;




% temp=predict(nlmColDist,x);
temp=x;

corrMat(1,rInd,cInd)=corr(temp,y,'Type',corrType);
corrMat(2,rInd,cInd)=corr(temp,y,'Type',corrType2);
corrMat(3,rInd,cInd)=corr(temp,y,'Type',corrType3);
rmseMat(rInd,cInd)=sqrt(mean((temp-y).^2));
corrMatOrg(1,rInd,cInd)=corr(x,y,'Type',corrType);
corrMatOrg(2,rInd,cInd)=corr(x,y,'Type',corrType2);
corrMatOrg(3,rInd,cInd)=corr(x,y,'Type',corrType3);
%% Fastfading
cInd=5;
y=FastfadingDmos';
%ColDist
x=FastfadingColDistFull';
x(isnan(x))=0;
x(isinf(x))=0;



% temp=predict(nlmColDist,x);
temp=x;

corrMat(1,rInd,cInd)=corr(temp,y,'Type',corrType);
corrMat(2,rInd,cInd)=corr(temp,y,'Type',corrType2);
corrMat(3,rInd,cInd)=corr(temp,y,'Type',corrType3);
rmseMat(rInd,cInd)=sqrt(mean((temp-y).^2));
corrMatOrg(1,rInd,cInd)=corr(x,y,'Type',corrType);
corrMatOrg(2,rInd,cInd)=corr(x,y,'Type',corrType2);
corrMatOrg(3,rInd,cInd)=corr(x,y,'Type',corrType3);
%%

% % orderDist
% squeeze(corrMatOrg)
% squeeze(corrMat)
% squeeze(rmseMat)

%%
metricRes=ColDistFull';
% figure
metricRes(isnan(metricRes))=0;
metricRes(isinf(metricRes))=0;
fileName=['data_L/metric_','metInd_',num2str(metInd),'_','poolInd_',num2str(poolInd),'.mat'];
save(fileName,'metricRes')
end

y=DmosScore';
% save('dmos_live','y')

%fileName=['corrAfter_','metInd_',num2str(metInd),'_','poolInd_',num2str(poolInd),'_paramInds_',num2str(paramIndArray),'_blockSize',num2str(blockSize),'.mat'];
fileName=['corrAfter_','metInd_',num2str(metInd),'_','poolInd_',num2str(poolInd),'.mat'];
save(fileName,'corrMat')
%fileName=['corrBefore_','metInd_',num2str(metInd),'_','poolInd_',num2str(poolInd),'_paramInds_',num2str(paramIndArray),'_blockSize',num2str(blockSize),'.mat'];
fileName=['corrBefore_','metInd_',num2str(metInd),'_','poolInd_',num2str(poolInd),'.mat'];
save(fileName,'corrMatOrg')
%fileName=['rmse_','metInd_',num2str(metInd),'_','poolInd_',num2str(poolInd),'_paramInds_',num2str(paramIndArray),'_blockSize',num2str(blockSize),'.mat'];
fileName=['rmse_','metInd_',num2str(metInd),'_','poolInd_',num2str(poolInd),'.mat'];
save(fileName,'rmseMat')

