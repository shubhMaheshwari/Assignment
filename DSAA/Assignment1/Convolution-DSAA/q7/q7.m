
inp = [12, 20, 3, 10, 22, 19, 23, 16, 0, 21, 23, 16, 18]
inp_size = size(inp,2)

out = [75, 52, 33, 97, 251, 211, 63, 65]
out_size = size(out,2)

% Assuming stride = 1
% Assuming padding = 0
filter_size = (size(inp,2) - size(out,2) + 1);


inp_pred = zeros(filter_size,out_size);
for i = 1:inp_size - filter_size + 1
    inp_pred(:,i) = inp(i:i+filter_size-1);
end
inp_pred

filter = out*pinv(inp_pred)

epoch = 1000; 
lr = 0.001;
FILTER = rand(1,filter_size).*10

for ind = 1:epoch

out_pred = FILTER*inp_pred;
loss = sum((out - out_pred).^2)/(2*out_size);
gradient = (out_pred - out)*inp_pred'/out_size;
FILTER = FILTER - lr.*gradient;

end

FILTER = round(FILTER)
out_pred = FILTER*inp_pred
out

FILTER = flip(FILTER)


