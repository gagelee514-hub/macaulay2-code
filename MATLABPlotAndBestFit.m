filename = "HERMITIAN-BlackMagic-Polynomial.out";
fid = fopen(filename, 'r');

if fid == -1
    error('Could not open the file. Check that the filename is correct and in the same folder.');
end

Val = []; % Initialize the Val matrix

% 2. Read the file line-by-line
while ~feof(fid)
    % Read the current line and remove any leading/trailing invisible whitespace
    line = strtrim(fgetl(fid)); 
    
    % 3. Check if the line starts with '(' (This automatically skips the INFO header)
    if startsWith(line, '(') && endsWith(line, ')')
        
        % 4. Strip the '(' from the start and ')' from the end
        clean_line = line(2:end-1); 
        
        % 5. Convert the clean text "11, 1, 2141, .00730582" into a 1x4 numeric array
        num_row = str2num(clean_line); 
        
        % 6. Append this row to Val
        if length(num_row) >= 4
            Val = [Val; num_row]; 
        end
    end
end

% Close the file now that we are done reading
fclose(fid);

j = 1;
for i = 1:size(Val,1)
    Dmat(j,1) = Val(i,1);
    Dmat(j,2) = Val(i,2);
    Dmat(j,3) = Val(i,4);
    j = j+1;
end


group_ids = unique(Dmat(:,1)); % Finds all unique numbers in column 1
num_groups = length(group_ids); % Counts how many unique lines exist

log_fit = fittype('a*log(x) + b');
models_to_test = {'poly1', 'poly2', 'poly3', 'exp1', 'power1', log_fit};

best_equations = cell(num_groups, 1);

figure(1);
hold on;

% Loop from 1 to the number of detected groups
for k = 1:num_groups
    current_id = group_ids(k);
    
    idx = (Dmat(:,1) == current_id);
    
    x = Dmat(idx, 2); 
    y = Dmat(idx, 3);
    if length(x) < 2
        continue; 
    end
    
    best_rsquare = -Inf; 
    best_fit_object = [];
    best_model_name = '';
    last_error = ''; 
    for j = 1:length(models_to_test)   
        warning('off', 'all');
        try
            [current_fit, gof] = fit(x, y, models_to_test{j});
            if gof.rsquare > best_rsquare
                best_rsquare = gof.rsquare;
                best_fit_object = current_fit;
                if ischar(models_to_test{j})
                    best_model_name = models_to_test{j};
                else
                    best_model_name = 'Logarithmic (a*log(x) + b)';
                end
            end
        catch ME
            last_error = ME.message;
            continue; 
        end
    end
    
    if ~isempty(best_fit_object)
        best_equations{k} = best_fit_object;
        fprintf('\n--- Line %g Results ---\n', current_id);
        fprintf('Best model type: %s with R^2 = %.4f\n', best_model_name, best_rsquare);
        disp(best_fit_object); 
        
        plot(x, y, 'o', 'MarkerSize', 4); 
        
        h = plot(best_fit_object); 
        h.LineWidth = 1.5; 
        
        h.Annotation.LegendInformation.IconDisplayStyle = 'off';
    else
        fprintf('Line %g fit failed. Reason: %s\n', current_id, last_error);
    end
end

hold off;
xlabel('Column 2');
ylabel('Column 3');
warning('on', 'all');


figure(2);
hold on;

for k = 1:num_groups
    current_id = group_ids(k);
    
    idx = (Dmat(:,1) == current_id);
    x = Dmat(idx, 2); 
    y = Dmat(idx, 3);
    if isempty(x)
        continue; 
    end
    plot(x, y, '-', 'LineWidth', 1.5); 
end
hold off;
