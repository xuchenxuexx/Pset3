n=3;      %number of state
q=0.05;    %std of process 
r=0.04;    %std of measurement
Q=q^2*eye(n); % covariance of process
R=r^2;        % covariance of measurement 
dt = 0.1; % delta t = 0.1s
wt = (2*pi/60)*110; %angular velocity in rad/s
vt = wt*20 % velocity in mm/s
f=@(x)[x(1)+wt*dt;x(2)+vt*cos(x(1))*dt;x(3)+vt*cos(x(1))*dt];  % nonlinear state equations
[xr1,yr1,xr2,yr2] = findref(x(2),x(3),x(1));
h=@(x)[sqrt((x(2)-xr1)^2+(x(3)-yr1)^2);sqrt((x(2)-xr2)^2+(x(3)-yr2)^2);atan((x(3)-yr1)/(x(2)-xr1))-x(1)];            % measurement equation
s=[0;0;1];                                % initial state
x=s+q*randn(3,1); %initial state          % initial state with noise
P = eye(n);                               % initial state covraiance
N=20;                                     % total dynamic steps
xV = zeros(n,N);          %estmate        % allocate memory
sV = zeros(n,N);          %actual
zV = zeros(3,1,N);
for k=1:N
  z = h(s) + r*randn;                     % measurments
  sV(:,k)= s;                             % save actual state
  zV(:,:,k)  = z;                             % save measurment
  [x, P] = ekf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
  s = f(s) + q*randn(3,1);                % update process 
end
for k=1:3                                 % plot results
  subplot(3,1,k)
  plot(1:N, sV(k,:), '-', 1:N, xV(k,:), '--')
end