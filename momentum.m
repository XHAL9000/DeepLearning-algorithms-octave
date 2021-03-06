function [res loss iter] = momentum( f,x0,tlr,bet)
  fun=function_handle(f);
  grad=function_handle(gradient(f));
  iter = 0;
  [l c]=size(x0');
  loss = [];
  grad_average = zeros(l,c);
  epsilon=10e-5;
  syms alpha;
  x0=x0';
  while(norm(grad(num2cell(x0){:}))>tlr && iter<100 )
    grad_average = bet*grad_average +(1- bet) * grad(num2cell(x0){:});
    v=x0-alpha*grad_average;
    phi=fun(num2cell(v){:}); 
    mu = newto(phi,1,tlr);
    x0=x0-mu*grad_average;
    loss=[loss,fun(num2cell(x0){:})];
    iter++;
  endwhile
  res = x0 
  iter=iter
  loss = loss
endfunction