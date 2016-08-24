function [f] = feature_vector(img)
    
    f = zeros(11);
    
    [r,c] = size(img);
    
    ratio = (c/r);
    white_pixel_ratio = ((bwarea(img))/(r*c));
    
    peri = bwperim(img);
    peri_pixel = find(peri==1);
    peri_count = size(peri_pixel);
    
    img = imresize(img,[50,50]);
    %img = add_pading(img);
    
    h_proj_img = HProj2image(HProj(img),img);
    v_proj_img = HProj2image(HProj(rot90(img)),img);
    
    imresize(h_proj_img,[50,50]);
    imresize(v_proj_img,[50,50]);
    
    h_proj = image_to_hProj(h_proj_img);
    v_proj = image_to_hProj(v_proj_img);
    
    h_proj_moment_2 = moment(h_proj,2);
    v_proj_moment_2 = moment(v_proj,2);
    h_proj_moment_3 = moment(h_proj,3);
    v_proj_moment_3 = moment(v_proj,3);
    
    [mr,coordr] = return_peak_location(h_proj);
    [mc,coordc] = return_peak_location(v_proj);
    
    
    f = [h_proj_moment_2,h_proj_moment_3,v_proj_moment_2,v_proj_moment_3,ratio,white_pixel_ratio,mr,coordr,mc,coordc,peri_count(1)];
    %f = [h_proj_moment_2,h_proj_moment_3,v_proj_moment_2,v_proj_moment_3,ratio,white_pixel_ratio];

end

