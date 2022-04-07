% @Author - Justin Brouillette
% @Date - 4/5/2022
%% Get Run Name
prompt = 'Enter Name For Run';
dlgtitle = 'Name Your Run';
dims = [1 35];
definput = {'default'};
run_name = inputdlg(prompt,dlgtitle,dims,definput);
run_name = run_name{1};
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
% Sample size
n = 10;
expected_rates = deg2rad(5); %We expect 5 deg/s per axis
margin = 2;

%Generating a matrix of rates in the range [-margin * rates, margin * rates]
random_rates = margin * (-expected_rates + 2 * (expected_rates) * rand(n,3));

%% Preparing for Monte Carlo Run
output_rates = zeros(n,3);


X_0 = zeros(1,7);
X_0(1) = 1;

%% Monte Carlo Run and Output Storage
tic
for i = 1:n
    X_0(5:7) = random_rates(i,:);
    sim_out = sim('intermediate_model',500);
    output_rates(i,:) = sim_out.logsout{3}.Values.Data(end,5:7);
    toc
end

%% Save for Later Post Processing
cd run_storage
data_store.initial_rates = random_rates;
data_store.output_rates = output_rates;
save(run_name, 'data_store');
cd ../

