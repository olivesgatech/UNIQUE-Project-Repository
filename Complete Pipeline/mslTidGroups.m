function corrVec=tid_groups(tid_full,tid_gt,type_corr)


index_1=[0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 1 0 0 0]';
index_2=[1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0]';
index_3=[0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0]';
index_4=[0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]';
index_5=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 0]';
index_6=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0]';
index_7=[0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0]';
index_8=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';


% index_1=[1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0]';
% index_2=[1 0 1 1 1 1 0 1 1 1 1 0 0 0 0 0 0 0 1 0 1 0 0 0]';
% index_3=[1 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0]';
% index_4=[0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 1 0 0 1 1]';
% index_5=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1]';
% index_6=[0 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 0 1 0 0 0 1 1 0]';
% index_7=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';
index=[index_1,index_2,index_3,index_4,index_5,index_6,index_7,index_8];

corrR_mk=0;
corrP_mk=0;

   for mm=1:8 
        counter=1;
        temp=0;
        temp_gt=0;       
        for ii=1:25
            for jj=1:24
                    
                        for kk=1:5
                                if index(jj,mm)==1
                                      temp=[temp,tid_full(counter)];
                                      temp_gt=[temp_gt,tid_gt(counter)];
                                end
                                counter=counter+1; 
                        end
                    
        
            end
        end
        temp=temp(2:end);
        temp_gt=temp_gt(2:end);
            [corrR_mk(mm),corrP_mk(mm)]=corr(temp',temp_gt','type',type_corr);
      size(temp,2)
   end
   
   corrVec=abs(corrR_mk);