%% Read files
Src_path        = 'src.png'; % src filename
Ref_path        = 'ref.png'; % ref filename    
Src             = double(imread(Src_path)) / 255.0;
Ref             = double(imread(Ref_path)) / 255.0;

%% Reduce size if source image is too big
OriginalSource = Src; % Keep the original source before changing its size.
rf = max(max(size(Src)))  / 640;
if (rf > 1)
    disp('source image is too big. resize automatically.')
    Src = imresize(Src, 1.0/rf);
    Ref = imresize(Ref, 1.0/rf);
end

%% Set an empty options struct
NRDC_Options = [];

%% Uncomment the next line to prefer determinism over speed.
% NRDC_Options.isParallelized = false; 

%% Set initial search range: 
set_custom_initial_search_range = false; % Set as true to change defaults
if (set_custom_initial_search_range)
    NRDC_Options.gainMin        = [0.2, 1,  1,  0.5     ]; % L, a, b, ||Dx+Dy||
	NRDC_Options.gainMax        = [3,   1,  1,  2       ]; % L, a, b, ||Dx+Dy||
	NRDC_Options.biasMin        = [-30, -20,-20,-0      ]; % L, a, b, ||Dx+Dy||
	NRDC_Options.biasMax        = [20,  20, 20, 0       ]; % L, a, b, ||Dx+Dy||
	NRDC_Options.logScaleRange  = [log(0.33),          log(3)        ];
	NRDC_Options.rotationRange  = [(-190)*0174532925,  (190)*0174532925]; % Rotation range in radians.
end

%% Construct a constraint per-pixel (enable if to change the default global constraints):
% By setting a constraint per-pixel, you may save time and increase
% accuracy, but this requires some prior knowledge on the relation between
% the two photos. For example, if you know that a rectangle in the source 
% image contains an object (e.g. face) which is not presented in the 
% reference image, you can set a constraint per pixel in this rectangle to 
% zero. Another useful case is if you want to set a constraint on the 
% maximum translation.
set_per_pixel_constraint = false; % Set as true to set a constraint per pixel manually
if (set_per_pixel_constraint)
    % Get constraint per-pixel:
    % In this example we first two types of constraints: one is the same as the
    % default global constraints used for pixel we have no information about 
    % (global_constraint) but want to limit the translation to +-15, 
    % and one for pixels which we do not want to 
    % match (no_match_constraint).
    % The constraints should be given as a matrix with entries of 8 channels
    % each of the following form:
    % per_pixel_constraint = [Min x, Min y, min log-scale, min rotation, ...
    % max x, max y, max log-scale, max rotation];
    global_constraint = [0 0 NRDC_Options.logScaleRange(1) NRDC_Options.rotationRange(1) size(Ref,2) size(Ref,1) NRDC_Options.logScaleRange(2) NRDC_Options.rotationRange(2)];
    % Reshape global constraint to be a 1x1 maatrix of 8 channels:
    global_constraint = reshape(global_constraint , [1 1 8]);
    no_match_constraint = reshape(zeros(1,8),[1,1,8]);
    dcf_size = [size(Src,1)-7, size(Src,2)-7];
    % Construct a full matrix, filled with the global constraints:
    per_pixel_constraints = repmat(global_constraint, dcf_size(1), dcf_size(2));
    
    % Limit horizontal translation:
    [xx yy] = meshgrid(0:dcf_size(2)-1,0:dcf_size(1)-1);
    per_pixel_constraints(:,:,1) = xx - 200;
    per_pixel_constraints(:,:,5) = xx + 400;
    
    % Set an empty rectangle at the middle of the image:
    rect = round([dcf_size(1)/2-80 dcf_size(2)/2-80 160 160]);
    
    % Display rect
    display_no_match_rect = false;
    if (display_no_match_rect)
        tmp = zeros(size(per_pixel_constraints,1), size(per_pixel_constraints,2));
        tmp(rect(1):rect(1)+rect(3)-1, rect(2):rect(2)+rect(4)-1) = 1;
        figure; imshow(tmp)
    end
    per_pixel_constraints(rect(1):rect(1)+rect(3)-1, rect(2):rect(2)+rect(4)-1,:) = repmat(no_match_constraint, [rect(3), rect(4), 1]);
    per_pixel_constraints = single(per_pixel_constraints);
end

%% Run NRDC (This version is optimized for best quality, not for speed).

if (~exist('per_pixel_constraints', 'var') || isempty(per_pixel_constraints))
    
    tic
    [DCF, Confidence, T, AlignedRef] = nrdc(Src, Ref, NRDC_Options);
    toc % 8.36 seconds for the attached example (using the parallelized version on 2.3GHz Intel Core i7 (2820qm) MacBook Pro)
    
else % Run with per pixel-constraint
    
    tic
    [DCF, Confidence, T, AlignedRef] = nrdc(Src, Ref, NRDC_Options, per_pixel_constraints);
    toc % 8.6 seconds for the attached example (using the parallelized version on 2.3GHz Intel Core i7 (2820qm) MacBook Pro)
end

%% Display the result:

if isempty(DCF)
    disp('No matching has been found.')
else
    % Display Dense correspondence field:
    figure; imshow(dcfDisp(DCF, size(Ref), Confidence));

    % Display some random correspondences as lines:
    dcfDispWithLines(Src, Ref, DCF, Confidence);
    
    % Show aligned reference:
    figure; imshow(AlignedRef);

    % Plot color curves:
    PlotColorTransform(T);

    % Apply color transformation:
    GlobalClrTrnsResult = evalColorTransform(single(OriginalSource), T);

    % Display the global result:
    figure; imshow(GlobalClrTrnsResult);
end
