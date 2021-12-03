% Ownship plots
xp = {[-40000 -20000 0 20000];
    [-20000 0 20000 40000];
    [-20000 0 20000 40000];
    [-30000 -20000 -10000 0 10000];
    [-50000 0 50000];
    [-10000 0 10000 20000 30000 40000];
    [-20000 0 20000 40000 60000 80000];
    [-10000 0 10000 20000 30000];
    [-20000 -10000 0 10000 20000];
    [-50000 -25000 0 25000 50000]};
yp = {[0 10000 20000 30000 40000 50000 60000 70000 80000];
    [-30000 -20000 -10000 0 10000 20000 30000];
    [-30000 -20000 -10000 0 10000 20000 30000];
    [-30000 -20000 -10000 0 10000];
    [0 20000 40000 60000 80000 100000 120000 140000];
    [0 10000 20000 30000 40000 50000];
    [0 20000 40000 60000 80000 100000];
    [0 10000 20000 30000 40000 50000];
    [0 10000 20000 30000 40000 50000];
    [0 20000 40000 60000 80000 100000 120000]};
xp_label = {{'-40000', '-20000', '0', '20000'};
    {'-20000' '0' '20000' '40000'};
    {'-20000' '0' '20000' '40000'};
    {'-30000' '-20000' '-10000' '0' '10000'};
    {'-50000' '0' '50000'};
    {'-10000' '0' '10000' '20000' '30000' '40000'};
    {'-20000' '0' '20000' '40000' '60000' '80000'};
    {'-10000' '0' '10000' '20000' '30000'};
    {'-20000' '-10000' '0' '10000' '20000'};
    {'-50000' '-25000' '0' '25000' '50000'}};
yp_label = {{'0', '10000', '20000', '30000', '40000', '50000', '60000', '70000', '80000'};
    {'-30000' '-20000' '-10000' '0' '10000' '20000' '30000'};
    {'-30000' '-20000' '-10000' '0' '10000' '20000' '30000'};
    {'-30000' '-20000' '-10000' '0' '10000'};
    {'0' '20000' '40000' '60000' '80000' '100000' '120000' '140000'};
    {'0' '10000' '20000' '30000' '40000' '50000'};
    {'0' '20000' '40000' '60000' '80000' '100000'};
    {'0' '10000' '20000' '30000' '40000' '50000'};
    {'0' '10000' '20000' '30000' '40000' '50000'};
    {'0' '20000' '40000' '60000' '80000' '100000' '120000'}};
xl = [[-55000 30000];[-21000 50000];[-21000 50000];[-33000 11000];[-75000 60000];
    [-12000 44000];[-22000 82000];[-15000 40000];[-25000 23000];[-53000 54000]];
yl = [[-2000 81000];[-35000 35000];[-35000 35000];[-33000 15000];[-2000 142000];
    [-9000 51000];[-4000 105000];[-3000 53000];[-2000 50500];[-2000 122000]];
% Zoomed in plots
xp_zoom = {[-20000 -10000 0 10000 20000];
    [-5000 0 5000];
    [-5000 0 5000];
    [-5000 -2500 0 2500 5000 75000];
    [-5000 0 5000];
    [-10000 0 10000];
    [-30000 -20000 -10000 0 10000];
    [-10000 -5000 0 5000];
    [-10000 -5000 0 5000 10000];
    [-5000 0 5000 10000]};
yp_zoom = {[40000 50000 60000 70000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [2000 4000 6000 8000 10000 12000 14000];
    [120000 122000 124000 126000 128000 130000 132000 134000 136000];
    [10000 15000 20000 25000 30000 35000 40000];
    [50000 60000 70000 80000 90000];
    [25000 27500 30000 32500 35000 37500 40000 42500];
    [15000 20000 25000 30000 35000];
    [30000 32500 35000 37500 40000 42500 45000 47500]};
xpz_label = {{'-20000' '-10000' '0' '10000' '20000'};
    {'-5000' '0' '5000'};
    {'-5000' '0' '5000'};
    {'-5000' '-2500' '0' '2500' '5000' '75000'};
    {'-5000' '0' '5000'};
    {'-10000' '0' '10000'};
    {'-30000' '-20000' '-10000' '0' '10000'};
    {'-10000' '-5000' '0' '5000'};
    {'-10000' '-5000' '0' '5000' '10000'};
    {'-5000' '0' '5000' '10000'}};
ypz_label = {{'40000' '50000' '60000' '70000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'2000' '4000' '6000' '8000' '10000' '12000' '14000'};
    {'120000' '122000' '124000' '126000' '128000' '130000' '132000' '134000' '136000'};
    {'10000' '15000' '20000' '25000' '30000' '35000' '40000'};
    {'50000' '60000' '70000' '80000' '90000'};
    {'25000' '27500' '30000' '32500' '35000' '37500' '40000' '42500'};
    {'15000' '20000' '25000' '30000' '35000'};
    {'30000' '32500' '35000' '37500' '40000' '42500' '45000' '47500'}};
xl_zoom = [[-21000 28000];[-7000 7000];[-7000 7000];[-5500 7800];[-8000 8000];
    [-19000 13000];[-33000 15000];[-12000 8000];[-13000 11000];[-9000 12000]];
yl_zoom = [[30000 70000];[19000 34000];[19000 34000];[0 14100];[118000 136500];
    [9000 43000];[45000 95000];[23500 43500];[13500 36500];[27500 48500]];
% Square Zoomed in plots
xp_sq = {[-10000 -5000 0 5000 10000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [-2000 -1000 0 1000 2000];
    [-4000 -2000 0 2000 4000];
    [-5000 -2500 0 2500 5000];
    [-10000 -5000 0 5000 10000];
    [-20000 -10000 0 10000];
    [-10000 -5000 0 5000];
    [-6000 -3000 0 3000 6000 9000];
    [-5000 0 5000 10000]};
yp_sq = {[40000 45000 50000 55000 60000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [26000 27000 28000 29000];
    [0 2000 4000 6000 8000 10000];
    [124000 126000 128000 130000 132000 134000 136000];
    [15000 20000 25000 30000 35000];
    [50000 60000 70000 80000];
    [25000 30000 35000 40000];
    [15000 20000 25000 30000];
    [25000 30000 35000 40000 45000]};
xsq_label = {{'-8000' '-4000' '0' '4000' '8000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'-2000' '-1000' '0' '1000' '2000'};
    {'-4000' '-2000' '0' '2000' '4000'};
    {'-5000' '-2500' '0' '2500' '5000'};
    {'-10000' '-5000' '0' '5000' '10000'};
    {'-20000' '-10000' '0' '10000'};
    {'-10000' '-5000' '0' '5000'};
    {'-6000' '-3000' '0' '3000' '6000' '9000'};
    {'-5000' '0' '5000' '10000'}};
ysq_label = {{'40000' '45000' '50000' '55000' '60000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'26000' '27000' '28000' '29000'};
    {'0' '2000' '4000' '6000' '8000' '10000'};
    {'124000' '126000' '128000' '130000' '132000' '134000' '136000'};
    {'15000' '20000' '25000' '30000'};
    {'50000' '60000' '70000' '80000'};
    {'25000' '30000' '35000' '40000'};
    {'15000' '20000' '25000' '30000' };
    {'25000' '30000' '35000' '40000' '45000'}};