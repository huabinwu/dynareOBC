function dynareOBC( InputFileName, varargin )
%       This command runs dynareOBC with the model file specified in
%       the InputFileName arument.
%       Please type "dynareOBC help" to see the full instructions.
%
% INPUTS
%   InputFileName:  Input file name, "help", "addpath", "rmpath" or "testsolvers"
%   varargin:       List of arguments
%             
% OUTPUTS
%   none
%        
% SPECIAL REQUIREMENTS
%   none

% Copyright (C) 2001-2015 Dynare Team and Tom Holden
%
% This file is part of dynareOBC.
%
% dynareOBC is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% dynareOBC is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with dynareOBC. If not, see <http://www.gnu.org/licenses/>.

    %% Initialization

    CurrentPath = pwd( );
    dynareOBCPath = fileparts( mfilename( 'fullpath' ) );

    WarningState = warning( 'off', 'MATLAB:rmpath:DirNotFound' );
    rmpath( genpath( [ dynareOBCPath '/dynareOBC/' ] ) );
    warning( WarningState );
    
    addpath( dynareOBCPath );

    if nargin < 1 || strcmpi( InputFileName, 'help' ) || strcmpi( InputFileName, '-help' ) || strcmpi( InputFileName, '-h' ) || strcmpi( InputFileName, '/h' ) || strcmpi( InputFileName, '-?' ) || strcmpi( InputFileName, '/?' )
        skipline( );
        disp( fileread( [ dynareOBCPath '/README.md' ] ) );
        skipline( );
        return;
    end
    
    if strcmpi( InputFileName, 'rmpath' )
        return;
    end

    OriginalPath = path;
    
    addpath( [ dynareOBCPath '/dynareOBC/JGit4MATLAB/' ] );
    addpath( [ dynareOBCPath '/dynareOBC/setup/' ] );
        
    WarningState = warning( 'off', 'jgit:noSSHpassphrase' );
    try
        disp( 'Initializing JGit.' );
        jgit version;
    catch
        RestartMatlab( CurrentPath, InputFileName, varargin{:} );
    end
    warning( WarningState );
   
    dynareOBCSetup( CurrentPath, dynareOBCPath, InputFileName, varargin{:} );
    
    path( OriginalPath );

end
