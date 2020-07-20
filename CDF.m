%Random variable PDFs and CDFs

%Define simulation parameters

L=100000;%length of random samples
mean_normal = 1;stddev_normal = 2;
    %mean and standard deviation of normal RV values
res_hist = 100; %Histogram resolution
%Generate random samples for different values
b_unif = rand(1,L);
b_normal = (stddev_normal * randn(1,L)+mean_normal);
            %Normal random values
b_rayleigh = (sqrt(randn(1,L).^2 + randn(1,L).^2));
%obtain cumulative distribution function
[N_unif,edges_unif] = histcounts(b_unif,res_hist);
N_unif_cum = cumsum(N_unif)./L;
[N_normal, edges_normal] = histcounts(b_normal,res_hist);
N_normal_cum = cumsum(N_normal)./L;
[N_ray1, edges_rayl] = histcounts(b_rayleigh,res_hist);
N_ray1_cum = cumsum(N_ray1)./L;
 
%calculate probabilty of values between 0.7 and 1
x_lower = 0.7;
x_upper = 1.0;

unif_ind_range = find((x_lower <= edges_unif) &(edges_unif <x_upper));
normal_ind_range = find((x_lower <= edges_normal) & (edges_normal < x_upper));
ray1_ind_range = find((x_lower <= edges_ray1) & (edges_ray1 < x_upper));

prob_unif = sum(N_unif(unif_ind_range))./L;
prog_normal = sum(N_normal(normal_ind_range))./L;
prob_ray1 = sum(N_ray1(ray1_ind_range))./L;
