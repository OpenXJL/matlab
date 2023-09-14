%% 将修改的文件和原始maltab程序进行合并
% 将`matlab_2022b_win_run.zip`解压

% deploy('D:\matlab')
% deploy('D:\ssd\matlab_2022b_win_run.zip')
function deploy(varargin)

if numel(varargin) < 1
    raw_matlab_dir = matlabroot;
else
    raw_matlab_dir = varargin{1};
end

cur_dir = fileparts(mfilename('fullpath'));

if isfile(raw_matlab_dir)
    % 解压到和zip文件同一文件夹内
    unzip(zip_path, zip_dir);

    raw_matlab_dir = fullfile(zip_dir, 'matlab_2022b');
end


%% 将原始Matlab文件拷贝到仓库，存在同名文件则跳过
addpath(genpath(fullfile(cur_dir, 'utils')));

all_files = RangTraversal(raw_matlab_dir);

for i = 1 : numel(all_files)
    cur_file = all_files{i};

    % 获得相对matlab主目录的后缀目录
    split_strs = split(cur_file, 'matlab_2022b');
    path_suffix = split_strs{2};

    % 需要拷贝到的目标文件
    obj_file = fullfile(cur_dir, path_suffix);

    % 如果不存在目标文件则拷贝，存在则跳过
    if ~exist(obj_file, 'file')
        obj_dir = fileparts(obj_file);
        if ~exist(obj_dir, 'dir'); mkdir(obj_dir); end
        
        copyfile(cur_file, fileparts(obj_file));
    end
end

end


