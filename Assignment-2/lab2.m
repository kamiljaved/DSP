% [Assignment No. 2]   Introduction to Sampling and Linear Time-Invariant Systems
% Reg. No. :   2016-EE-189

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    TASK 1    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%

% >>> task <<< record audio for 15 seconds at 44100 samples per second

% Sampling Frequency (samples per second)
Fs = 44100;

% [syntax] recorder = audiorecorder(Fs,nBits,NumChannels,ID)
recorder = audiorecorder(Fs, 8, 2, 1);

% set funtions to execute on recording start/end
recorder.StartFcn = 'disp(''Start speaking.'')';
recorder.StopFcn = 'disp(''End of recording.'')';

% record for 15 seconds, in blocking mode
% [syntax] recordblocking(recorderObj, length_seconds)
recordblocking(recorder, 15);

figure;
% get the recorded data, and plot it
rec = recorder.getaudiodata;
stem(rec, 'filled', 'MarkerSize', 1);
xlabel('n'); ylabel('x[n]'); 
xlim([0 length(rec)]);
title(strcat(num2str(length(rec)), ' audio samples  x[n]  (2 channels)'));

% save the audio data to a .wav file
filename = 'lab2.wav';
audiowrite(filename, rec, Fs);

% >>> task <<< playback the audio, at a different sample rate, to fit within 10 seconds

% read audio data back from the created file
[x, Fs] = audioread(filename);

% calc. new sample rate for playback
duration = 10;              % 10 seconds
pb_sampleRate = length(x)/duration

% [syntax] sound(seq,Fs,nBits)
sound(x, pb_sampleRate, 8); 
pause(duration);            % wait for sound to finish

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%    TASK 2    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%

% >>> task <<< generate an echo effect on the Task 1 voice recording (15s)

% first generate the delayed sequence
nd = 22050;                 % #samples delay to be added
% x[n] is a 661500 × 2 size matrix (2 channel audio)
% xd[n] matrix would have the size (661500+nd) × 2
xd = vertcat(zeros(nd, 2), x);

figure;
% plot the delayed sequence
stem(xd, 'filled', 'MarkerSize', 1);
xlabel('n'); ylabel('x_d[n]'); xlim([0 length(xd)]);
title('Delayed Sequence x_d[n]');

% pad zeros to the end of x[n] to match its dimensions with xd[n]
xp = vertcat(x, zeros(nd, 2));

% add (padded) x[n] and xd[n] to get the echo-effect signal y[n]
y = xp+xd;

figure;
% plot the resultant signal y[n]
stem(y, 'filled', 'MarkerSize', 1);
xlabel('n'); ylabel('y[n]'); xlim([0 length(y)]);
title('y[n] = x[n] + x_d[n]');

% get and play y(t) using sound command
sound(y, Fs);
