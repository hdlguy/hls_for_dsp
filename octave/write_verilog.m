% write_fade_hpp.m
% writes out the fader random variable constants to a Verilog header file.
% Values are scaled to work with fixed point math, phase -Pi/Pi corresponds to the twos complement integer range.

function [retval] = write_verilog (states, fd, filename)

    B_phi = 14; % bits in phi word.
    A_phi = 2^(B_phi-1);
    B_cos = 18; % bits in wd_cos_alpha word.
    A_cos = 2^(B_cos-1);

    N = size(states.theta, 1);
    M = size(states.Phi, 3);
    
    fp = fopen(filename, 'w');
    fprintf(fp, '// %s\n', filename);
    fprintf(fp, '// This file autogenerated to provide the "states" structure for the Verilog fader.\n\n');   

    fprintf(fp, 'package states_pack;\n');
    fprintf(fp, '    typedef struct {\n');
    fprintf(fp, '        logic   [%d-1:0][%d-1:0]   phi_imag;\n', M, B_phi);
    fprintf(fp, '        logic   [%d-1:0][%d-1:0]   phi_real;\n', M, B_phi);
    fprintf(fp, '        logic   [%d-1:0][%d-1:0]   wd_sin_alpha;\n', M, B_cos);
    fprintf(fp, '        logic   [%d-1:0][%d-1:0]   wd_cos_alpha;\n', M, B_cos);
    fprintf(fp, '    } fade_struct; \n');
    
    fprintf(fp, '    const state_array state[%d] = {\n', N);
    
    wd_cos_alpha = zeros(1,M);
    wd_sin_alpha = zeros(1,M);
    for i=1:N
        fprintf(fp, '    // channel = %d\n', i-1);
        fprintf(fp, '    {\n');
        fprintf(fp, '        {');
        for j=1:M
            fprintf(fp, '%f', states.Phi(i,1,j));
            if (j!=M) 
                fprintf(fp, ', ');
            else
                fprintf(fp, '}, // phi_real\n');
            end
        end
        
        fprintf(fp, '        {');
        for j=1:M
            fprintf(fp, '%f', states.phi(i,1,j));
            if (j!=M) 
                fprintf(fp, ', ');
            else
                fprintf(fp, '}, // phi_imag\n');
            end
        end
    
        % we need to precompute the cos(alpha) and sin(alpha).
        for j=1:M
            alpha = ( 2*pi*j - pi + states.theta(i,1,1) )/(4*M);
            wd_cos_alpha(j) = 2*pi*fd*cos(alpha);
            wd_sin_alpha(j) = 2*pi*fd*sin(alpha);
        end
        
        fprintf(fp, '        {');
        for j=1:M
            fprintf(fp, '%f', wd_cos_alpha(j));
            if (j!=M) 
                fprintf(fp, ', ');
            else
                fprintf(fp, '}, // wd_cos_alpha\n');
            end
        end
        
        fprintf(fp, '        {');
        for j=1:M
            fprintf(fp, '%f', wd_sin_alpha(j));
            if (j!=M) 
                fprintf(fp, ', ');
            else
                fprintf(fp, '} // wd_sin_alpha\n');
            end
        end
        
        if (i!=N)
            fprintf(fp, '    },\n');
        else
            fprintf(fp, '    }\n');
        end
    end
    
    fprintf(fp, '};\n');
    
    
    fclose(fp);

endfunction

%        for(int i=0; i<M; i++){
%            theta = 2.0*M_PI*(((double)rand())/rand_max) - M_PI; // uniformly random over [-M_PI, M_PI).
%            alpha = (2.0*M_PI*(i+1) - M_PI + theta)/(4.0*M);
%            std::cout << j << ", " << i << " alpha = " << alpha << ", theta = " << theta << "\n";
%            state[j].cos_alpha[i]    = (fade_type)cos(alpha); // [-1.0, +1.0]
%            state[j].sin_alpha[i]    = (fade_type)sin(alpha);



%typedef struct {
%    fade_type phi_real[M];
%    fade_type phi_imag[M];
%    fade_type cos_alpha[M];
%    fade_type sin_alpha[M];
%} rand_state;

