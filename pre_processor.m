%% fetch and proces data

sim_out = sim('basic_model', 2500); % to get data from the model
%f = fopen('Data_out.dat', 'w+');

time = sim_out.logsout{3}.Values.Time;
mu = sim_out.logsout{3}.Values.Data(:, 1);
eta1 = sim_out.logsout{3}.Values.Data(:, 2);
eta2 = sim_out.logsout{3}.Values.Data(:, 3);
eta3 = sim_out.logsout{3}.Values.Data(:, 4);
quat = [mu eta1 eta2 eta3];
quat_sparse = quat(1, :);

dt = 1;
i = 1;

tOld = time(1);
tNew = tOld;

while i <= length(time)
    
    tNew = time(i);
    
    if tNew < tOld + dt
        
        i = i + dt;
        
    else
        
        quat_sparse = [quat_sparse; quat(i, :)];
        tOld = tNew;
        i = i + 1;
    end
    
end

eul = quat2eul(quat_sparse); % save me to a file please :)