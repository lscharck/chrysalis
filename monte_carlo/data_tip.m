function output_txt = data_tip(obj,event_obj)
% Display data cursor position in a data tip
% obj          Currently not used
% event_obj    Handle to event object
% output_txt   Data tip text, returned as a character vector or a cell array of character vectors

pos = event_obj.Position;
app = event_obj.Target.Parent.Parent.RunningAppInstance;
initial_rates = rad2deg(app.run_data.initial_rates);
terminal_rates = rad2deg(app.run_data.terminal_rates);

%Going to scrub the data
axis_num = axis_finder(app,event_obj.Target.CData);
data_index = data_searcher(pos(1),pos(2),initial_rates,terminal_rates,axis_num);

%Print it out
trial_init = initial_rates(data_index,:);
trial_term = terminal_rates(data_index,:);

app.RunSelectTextArea.Value{1} = convertStringsToChars(sprintf("Initial Rates: "));
app.RunSelectTextArea.Value{2} = convertStringsToChars(sprintf("X-Axis: %2.4f deg/s", trial_init(1)));
app.RunSelectTextArea.Value{3} = convertStringsToChars(sprintf("Y-Axis: %2.4f deg/s", trial_init(2)));
app.RunSelectTextArea.Value{4} = convertStringsToChars(sprintf("Z-Axis: %2.4f deg/s", trial_init(3)));
app.RunSelectTextArea.Value{5} = convertStringsToChars(sprintf("Terminal Rates: "));
app.RunSelectTextArea.Value{6} = convertStringsToChars(sprintf("X-Axis: %2.4f deg/s", trial_term(1)));
app.RunSelectTextArea.Value{7} = convertStringsToChars(sprintf("Y-Axis: %2.4f deg/s", trial_term(2)));
app.RunSelectTextArea.Value{8} = convertStringsToChars(sprintf("Z-Axis: %2.4f deg/s", trial_term(3)));

%********* Define the content of the data tip here *********%

% Display the x and y values:
output_txt = {['{\omega_0}',formatValue(pos(1),event_obj)],...
    ['{\omega_f}',formatValue(pos(2),event_obj)]};
%***********************************************************%


% If there is a z value, display it:
if length(pos) > 2
    output_txt{end+1} = ['Z',formatValue(pos(3),event_obj)];
end

end 







%***********************************************************%

function formattedValue = formatValue(value,event_obj)
% If you do not want TeX formatting in the data tip, uncomment the line below.
% event_obj.Interpreter = 'none';
if strcmpi(event_obj.Interpreter,'tex')
    valueFormat = ' \color[rgb]{0 0.6 1}\bf';
    removeValueFormat = '\color[rgb]{.25 .25 .25}\rm';
else
    valueFormat = ': ';
    removeValueFormat = '';
end
formattedValue = [valueFormat num2str(value,4) removeValueFormat];

end

function data_index = data_searcher(init,term,initial_rates,terminal_rates,axis_num)
    %Perform Find Algorithm to search results for original run conditions
    data_index = 0;
    options = zeros(2,1);
    [~, options(1)] = min(abs(initial_rates(:,axis_num) - init));
    [~, options(2)] = min(abs(terminal_rates(:,axis_num) - term));
    
    %Just Making Sure We've got this in the bag
    if options(1) == options(2)
       data_index = options(1); 
    end
    
end

%Using Axis Specific color values to tell the index finder where to look.
%1 - X
%2 - Y
%3 - Z
function axis_num = axis_finder(app, dot_color)
axis_num = 0;

if(all(eq(app.x_color,dot_color)))
    axis_num = 1;
end 

if(all(eq(app.y_color,dot_color)))
    axis_num = 2;
end 

if(all(eq(app.z_color,dot_color)))
    axis_num = 3;
end 
end
