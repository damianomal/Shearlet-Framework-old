classdef ArgParser < handle
    %ARGPARSER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        arg_names
        arg_helps
        arg_required
        arg_values
        arg_types
        processed
    end
    
    methods
        function obj = ArgParser
            obj.arg_names = {};
            obj.arg_helps = {};
            obj.arg_required = {};
            obj.arg_values = {};
            obj.arg_types = {};
            obj.processed = [];
        end
        
        function addArg(obj, name, help, req, def, vtype)
            
            IndexC = strfind(obj.arg_names, name);
            Index = find(not(cellfun('isempty', IndexC)));
            
            if(nargin < 6)
                vtype = 'any';
            end
            
            if(numel(Index) == 0)
                obj.arg_names{end+1} = name;
                obj.arg_helps{end+1} = help;
                obj.arg_required{end+1} = req;
                obj.arg_values{end+1} = def;
                obj.arg_types{end+1} = vtype;
            else
                ME = MException('ArgParser:addArg', ...
                    'The inserted parameter already exists.');
                throw(ME);
            end
            
        end
        
        function res = parse(obj, args)
            
            new_names = args(1:2:end);
            new_vals = args(2:2:end);
            
            for index = find([obj.arg_required{:}] == true)
                if(~any(ismember(new_names, obj.arg_names{index})))
                    ME = MException('ArgParser:parse', ...
                        'The required parameters must be passed to the parse() call.');
                    throw(ME);
                end
            end
            
            for i = 1:numel(new_names)
                
                ind_temp = strfind(obj.arg_names, new_names{i});
                index = find(not(cellfun('isempty', ind_temp)));
                
                if(numel(index) == 1)
                    
                    if(~strcmp(obj.arg_types{index},'any') && ~isa(new_vals{i}, obj.arg_types{index}))
                        ME = MException('ArgParser:parse', ...
                            'One of the argument is of the wrong type.');
                        throw(ME);
                    end
                    
                    obj.arg_values{index} = new_vals{i};
                else
                    
                end
                
            end
            
            res = cell2struct(obj.arg_values, obj.arg_names, 2);
            obj.processed = res;
            
%             new_obj = obj;
            
        end
        
        function help(obj)
            
            fprintf('### Help for the ArgParser object ###\n');
            
            for i = 1:numel(obj.arg_names)
                fprintf('\nArgument: %s\n', obj.arg_names{i});
                fprintf('-- Help: %s\n', obj.arg_helps{i});
                
                if(obj.arg_required{i})
                    req = 'true';
                else
                    req = 'false';
                end
                
                fprintf('-- Required: %s\n', req);
                % fprintf('-- Value (or default): %d\n\n', obj.arg_values{i});
                
            end
            
            fprintf('#####################################\n');
        end
    end
    
end

