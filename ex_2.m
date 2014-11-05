% Constants
% Speed of light (m/s)
c = 299792458;
% Earth rotation rate (rad/s)
earth_rot_rate = 7.2921151467E-5;

% A priori receiver coordinates (m)
wank_xr = 4235956.688;
wank_yr = 834342.467;
wank_zr = 4681540.682;

% Recorded data
wank_c1 = importdata('data/WANK_C1');
wank_satt = importdata('data/WANK_SATT');
wank_xs_raw = importdata('data/WANK_SATX');
wank_ys_raw = importdata('data/WANK_SATY');
wank_zs_raw = importdata('data/WANK_SATZ');
epochs = importdata('data/Epochs.txt');
epochs = epochs(:,1);

% 3 (a): Correct satellite positions for Earth rotation during light
% travel time.
% Raw geometric distance:
rho_sr_raw = sqrt((wank_xs_raw - wank_xr).^2 ...
    + (wank_ys_raw - wank_yr).^2 + (wank_zs_raw - wank_zr).^2);
dOmega = rho_sr_raw * earth_rot_rate / c;
% Correct the coordinates.
wank_xs = wank_xs_raw .* cos(dOmega) + wank_ys_raw .* sin(dOmega);
wank_ys = - wank_xs_raw .* sin(dOmega) + wank_ys_raw .* cos(dOmega);
wank_zs = wank_zs_raw;
% Recompute the geometric distance.
rho_sr = sqrt((wank_xs - wank_xr).^2 ...
    + (wank_ys - wank_yr).^2 + (wank_zs - wank_zr).^2);

