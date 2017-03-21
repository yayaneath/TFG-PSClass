%%% Primer script para generar datos para entrenar. Divide por dimensiones para calcular características y luego las junta.

days = ['FC'; 'FD'; 'JB'; 'JC'];

for f = 2 : 2
    totalClasses = zeros(0,0);
    totalData = zeros(0,0);
    
    for i = 1 : 4
        day = days(i, :);
        [data, classes] = compDayFeatures(day, f);
        totalClasses = [totalClasses; classes];
        totalData = [totalData data];
    end
    
    cl0 = (totalClasses == 0)'; cl1 = (totalClasses == 1)';
    cl2 = (totalClasses == 2)'; cl3 = (totalClasses == 3)';
    cl4 = (totalClasses == 4)';
    
    classes_0 = totalClasses(cl0'); classes_1 = totalClasses(cl1');
    classes_2 = totalClasses(cl2'); classes_3 = totalClasses(cl3');
    classes_4 = totalClasses(cl4');
    
    data_0 = zeros(0); data_1 = zeros(0);
    data_2 = zeros(0); data_3 = zeros(0);
    data_4 = zeros(0);
    
    switch f
        case 1            
            data_0 = totalData(cl0);
            data_1 = totalData(cl1);
            data_2 = totalData(cl2);
            data_3 = totalData(cl3);
            data_4 = totalData(cl4);
        case 2
            dim1 = totalData(:,:,1); dim2 = totalData(:,:,2);
            data_0 = [dim1(cl0) dim2(cl0)];
            data_1 = [dim1(cl1) dim2(cl1)];
            data_2 = [dim1(cl2) dim2(cl2)];
            data_3 = [dim1(cl3) dim2(cl3)];
            data_4 = [dim1(cl4) dim2(cl4)];
        case 3
            dim1 = totalData(:,:,1); dim2 = totalData(:,:,2);
            dim3 = totalData(:,:,3);
            data_0 = [dim1(cl0) dim2(cl0) dim3(cl0)];
            data_1 = [dim1(cl1) dim2(cl1) dim3(cl1)];
            data_2 = [dim1(cl2) dim2(cl2) dim3(cl2)];
            data_3 = [dim1(cl3) dim2(cl3) dim3(cl3)];
            data_4 = [dim1(cl4) dim2(cl4) dim3(cl4)];
        case 4
            dim1 = totalData(:,:,1); dim2 = totalData(:,:,2);
            dim3 = totalData(:,:,3); dim4 = totalData(:,:,4);
            data_0 = [dim1(cl0) dim2(cl0) dim3(cl0) dim4(cl0)];
            data_1 = [dim1(cl1) dim2(cl1) dim3(cl1) dim4(cl1)];
            data_2 = [dim1(cl2) dim2(cl2) dim3(cl2) dim4(cl2)];
            data_3 = [dim1(cl3) dim2(cl3) dim3(cl3) dim4(cl3)];
            data_4 = [dim1(cl4) dim2(cl4) dim3(cl4) dim4(cl4)];
        case 5
            dim1 = totalData(:,:,1); dim2 = totalData(:,:,2);
            dim3 = totalData(:,:,3); dim4 = totalData(:,:,4);
            dim5 = totalData(:,:,5);
            data_0 = [dim1(cl0) dim2(cl0) dim3(cl0) dim4(cl0) ...
                dim5(cl0)];
            data_1 = [dim1(cl1) dim2(cl1) dim3(cl1) dim4(cl1) ...
                dim5(cl1)];
            data_2 = [dim1(cl2) dim2(cl2) dim3(cl2) dim4(cl2) ...
                dim5(cl2)];
            data_3 = [dim1(cl3) dim2(cl3) dim3(cl3) dim4(cl3) ...
                dim5(cl3)];
            data_4 = [dim1(cl4) dim2(cl4) dim3(cl4) dim4(cl4) ...
                dim5(cl4)];
        case 6
            dim1 = totalData(:,:,1); dim2 = totalData(:,:,2);
            dim3 = totalData(:,:,3); dim4 = totalData(:,:,4);
            dim5 = totalData(:,:,5); dim6 = totalData(:,:,6);
            data_0 = [dim1(cl0) dim2(cl0) dim3(cl0) dim4(cl0) ...
                dim5(cl0) dim6(cl0)];
            data_1 = [dim1(cl1) dim2(cl1) dim3(cl1) dim4(cl1) ...
                dim5(cl1) dim6(cl1)];
            data_2 = [dim1(cl2) dim2(cl2) dim3(cl2) dim4(cl2) ...
                dim5(cl2) dim6(cl2)];
            data_3 = [dim1(cl3) dim2(cl3) dim3(cl3) dim4(cl3) ...
                dim5(cl3) dim6(cl3)];
            data_4 = [dim1(cl4) dim2(cl4) dim3(cl4) dim4(cl4) ...
                dim5(cl4) dim6(cl4)];
        case 7
            dim1 = totalData(:,:,1); dim2 = totalData(:,:,2);
            dim3 = totalData(:,:,3); dim4 = totalData(:,:,4);
            dim5 = totalData(:,:,5); dim6 = totalData(:,:,6);
            dim7 = totalData(:,:,7);
            data_0 = [dim1(cl0) dim2(cl0) dim3(cl0) dim4(cl0) ...
                dim5(cl0) dim6(cl0) dim7(cl0)];
            data_1 = [dim1(cl1) dim2(cl1) dim3(cl1) dim4(cl1) ...
                dim5(cl1) dim6(cl1) dim7(cl1)];
            data_2 = [dim1(cl2) dim2(cl2) dim3(cl2) dim4(cl2) ...
                dim5(cl2) dim6(cl2) dim7(cl2)];
            data_3 = [dim1(cl3) dim2(cl3) dim3(cl3) dim4(cl3) ...
                dim5(cl3) dim6(cl3) dim7(cl3)];
            data_4 = [dim1(cl4) dim2(cl4) dim3(cl4) dim4(cl4) ...
                dim5(cl4) dim6(cl4) dim7(cl4)];
        case 8
            dim1 = totalData(:,:,1); dim2 = totalData(:,:,2);
            dim3 = totalData(:,:,3); dim4 = totalData(:,:,4);
            dim5 = totalData(:,:,5); dim6 = totalData(:,:,6);
            dim7 = totalData(:,:,7); dim8 = totalData(:,:,8);
            data_0 = [dim1(cl0) dim2(cl0) dim3(cl0) dim4(cl0) ...
                dim5(cl0) dim6(cl0) dim7(cl0) dim8(cl0)];
            data_1 = [dim1(cl1) dim2(cl1) dim3(cl1) dim4(cl1) ...
                dim5(cl1) dim6(cl1) dim7(cl1) dim8(cl1)];
            data_2 = [dim1(cl2) dim2(cl2) dim3(cl2) dim4(cl2) ...
                dim5(cl2) dim6(cl2) dim7(cl2) dim8(cl2)];
            data_3 = [dim1(cl3) dim2(cl3) dim3(cl3) dim4(cl3) ...
                dim5(cl3) dim6(cl3) dim7(cl3) dim8(cl3)];
            data_4 = [dim1(cl4) dim2(cl4) dim3(cl4) dim4(cl4) ...
                dim5(cl4) dim6(cl4) dim7(cl4) dim8(cl4)];
    end 
    
    fname = sprintf('data_%df_v2.mat', f);
    save(fname, 'totalClasses', 'totalData', ...
                'classes_0', 'classes_1', ...
                'classes_2', 'classes_3', ...
                'classes_4', 'data_0', ...
                'data_1', 'data_2', 'data_3', 'data_4');
end

