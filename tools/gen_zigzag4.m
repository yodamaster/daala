function order = gen_zigzag4(x, filename)

file=fopen(filename, 'w');

%Construct bands
B = ones(4,4);
B(1,1)=0;
#imagesc(B);

order=[];
for k=1:1
   mask = B==k;
   [dummy,ind]=sort(-x.*mask'(:));
   order = [order;ind(1:sum(sum(mask)))];
end
%start indexing at 0
order = order-1;

fprintf(file, "/* This file is automatically generated. */\n");
fprintf(file, "const unsigned char od_zigzag4[%d][2] = {\n  ", length(order));
for k=1:length(order)
   fprintf(file, "{%d, %d}", mod(order(k),4), floor(order(k)/4));
   if (k!=length(order))
      fprintf(file, ",");
   end
   if (mod(k,4)==0)
      fprintf(file, "\n  ");
   else
      fprintf(file, " ");
   end
end
fprintf(file, "};\n");

fclose(file);
