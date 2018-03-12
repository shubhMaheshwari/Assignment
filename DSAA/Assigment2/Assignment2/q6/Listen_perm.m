function [right_perm] = Listen_perm(audiofile)

x = audioread(audiofile);

figure;
subplot(3,1,1);
plot(x);
title('Original Sound');
% Only work in fourier domain
f_y = fft(x);
% 
subplot(3,1,2);
plot(abs(f_y));
title('Ft of original');
% We do not need the conjugate
f_y = f_y(1:end/2);
subplot(3,1,3);
plot(abs(f_y));
title('Half');
% Divide the whole into 4 parts 
pause
d = size(f_y,1)/4;
f_y = reshape(f_y,d,4);

or = perms([1,2,3,4]);
	for i = [1:24]
		or(i,:)
		% Permute and reshape to original shape
		new_x = perm_ord(f_y,or(i,:),d);
		
		subplot(2,1,2);
		plot(new_x);
		title('New Sound');

		sound(new_x,41400);
		pause
	end

	right_perm = [2,3,1,4]
end