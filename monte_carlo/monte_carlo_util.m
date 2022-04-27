% @Author - Justin Brouillette
% @Date - 4/26/2022
%% Get Run Name
prompt = {'Enter Name For Run', 'Sample Size (n = ?)', 'Margin','Run Type (Rates or MMOI)'};
dlgtitle = 'Run Info';
dims = [1 40];
definput = {'Default Name', '0', '0.0','No Run'};
answers = inputdlg(prompt,dlgtitle,dims,definput);
run_name = answers{1};
n = str2num(answers{2});
margin = str2num(answers{3});
run_type = answers{4};

if (strcmp(run_name,"Default Name") || n == 0 || strcmp(run_type,"No Run"))
       msgbox('Can you change the responses please? We will try this again later.')  
end
run_name = strcat(run_name, '.mat');

    

%% Adding Paths as Necessary
cd ../
chrysalis_main = pwd;
addpath(pwd)

addpath(strcat(chrysalis_main, '/model'));
addpath(strcat(chrysalis_main, '/magnetorquer'));
addpath(strcat(chrysalis_main, '/controller'));

cd monte_carlo

%% Intialize Field and Mass Moment of Inertia
%Magnetic Field
b_field = magnetic_field();


%Mass Moment of Inertia
I = MMOI;
%% Initializing Rates with Random Calls
expected_rates = deg2rad(5); %We expect 5 deg/s per axis
% margin = 2;

%Generating a matrix of rates in the range [-margin * rates, margin * rates]
random_rates = (margin+1) * (-expected_rates + 2 * (expected_rates) * rand(n,3));
%% Preparing for Monte Carlo Run
terminal_rates = zeros(n,3);
total_time = zeros(n,1);

X_0 = zeros(1,7);
X_0(1) = 1;

%% Monte Carlo Run and Output Storage
tic
for i = 1:n
    fprintf("This is run number %i\n",i)
    X_0(5:7) = random_rates(i,:);
    sim_out = sim('intermediate_model',1800);
    terminal_rates(i,:) = sim_out.logsout{3}.Values.Data(end,5:7);
    total_time(i) = sim_out.tout(end);
    toc
    
    %% Save for Later Post Processing
    cd run_storage
    data_store.initial_rates = random_rates;
    data_store.terminal_rates = terminal_rates;
    data_store.total_time = total_time;
    data_store.margin = margin;
    data_store.run_type = run_type;
    save(run_name, 'data_store');
    cd ../
    
end

%% Save for Later Post Processing - Moved to loop to save the pain
cd run_storage
data_store.initial_rates = random_rates;
data_store.terminal_rates = terminal_rates;
data_store.total_time = total_time;
data_store.margin = margin;
data_store.run_type = run_type;
save(run_name, 'data_store');
cd ../

disp('Remeber! Margin saved for this run will be user input, not 1 + margin!');
