function dsdt = ddesystem(t,s,L,p)
    x = s(1); y = s(2); z = s(3);
    xlag = L(1); zlag = L(3);

    dxdt = p.rho*x*z/(p.g+z)-p.beta1*xlag*zlag-p.delta*x;

    dydt = p.alpha*y*(1-y)-p.gamma1*y*z;

    dzdt = z*(1-z)-p.beta2*xlag*zlag-p.gamma2*y*z;

    dsdt = [dxdt; dydt; dzdt];
end