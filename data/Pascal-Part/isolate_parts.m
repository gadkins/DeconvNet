close all
anno_files = './Annotations_Part/%s.mat';
examples_path = './examples';
examples_imgs = dir([examples_path, '/', '*.jpg']);
cmap = VOClabelcolormap();
desired_class = 15;              % 'person'
desired_part = 'head';
output_dir = './person_parts';

pimap = part2ind();     % part index mapping

for ii = 1:numel(examples_imgs)
    imname = examples_imgs(ii).name;
    img = imread([examples_path, '/', imname]);
    % load annotation -- anno
    load(sprintf(anno_files, imname(1:end-4)));
    objects = get_class_obj(anno, desired_class);
    if(isempty(objects))
        continue;
    end
    
    for oo = 1:size(objects,2)
        parts = get_parts(objects{oo}, desired_part);
        if (~isempty(parts))
            [cls_mask, inst_mask, part_mask] = ...
                part_mat2map(img, pimap, objects, parts);
                
%                 figure;imshow(part_mask, cmap); title('Part Mask');
            cropped_part = mask2rgb(img,part_mask,[250,250]);
            figure; imshow(cropped_part);
        end
        % display annotation
%         subplot(2,2,1); imshow(img); title('Image');
%         subplot(2,2,2); imshow(cls_mask, cmap); title('Class Mask');
%         subplot(2,2,3); imshow(inst_mask, cmap); title('Instance Mask');
%         subplot(2,2,4); imshow(part_mask, cmap); title('Part Mask');
%         pause;
    end
end