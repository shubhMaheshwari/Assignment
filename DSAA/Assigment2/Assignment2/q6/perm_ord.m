function [new_x] = perm_ord(f_y,ord,d)


		new_y = [f_y(:,ord(1)), f_y(:,ord(2)), f_y(:,ord(3)), f_y(:,ord(4))];
		new_y = reshape(new_y,d*4,1);

		% add the flip version
		y = zeros(2*size(new_y,1),1);
		y(1:end/2) = new_y;
		y(end/2 + 1:end) = conj(flipud(new_y(:)));
		
		new_x = real(ifft(y));
end