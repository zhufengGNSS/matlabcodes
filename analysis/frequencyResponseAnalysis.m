% for lp=0:1:100
%     filename = ['tt',num2str(lp),'.txt'];
%     load(filename);
% end

sssize = 10;
snapshots = [];
% for lp1=0:sssize:100-1
%     vnidx = lp1:1:lp1+sssize-1;
for lp1=0:sssize*2:100-1 % 0번 포함한 짝수번 데이터만 읽기 위함..
    vnidx = lp1:2:lp1+sssize*2-1; % 0번 포함한 짝수번 데이터만 읽기 위함..
    if sum(vnidx>100) == 0
        temp = [];
        for lp2=1:length(vnidx)
            vn = ['tt',num2str(vnidx(lp2))];
            eval(['temp = [temp; ',vn,'];']);
        end
        snapshots = [snapshots temp];
    end
end

% snapshots = snapshots - 3.2768e4;

fFs = 210e6;
for lp=1:100/(sssize*2)
    figure;
    plot(snapshots(:,lp));
    title(['snapshot size = ',num2str(sssize),' snapshot#',num2str(lp)]);
    grid on;
    ylim([1.5e4 5e4]);
    saveas(gcf,['TimeDomain_SSS',num2str(sssize),'_',num2str(lp)],'png');
    close;

    [dBWHz, nfft] = fPlotPSD(snapshots(:,lp)', fFs, 0, 100);
        ylabel('Power/frequency (dB/Hz)');
        xlabel('Frequency (MHz)');
        xlim([0 (fFs*1e-6/2)]);
        grid on;
        title(['snapshot size = ',num2str(sssize),' snapshot#',num2str(lp)]);
        ylim([-60 80]);
        saveas(gcf,['FreqDomain_SSS',num2str(sssize),'_',num2str(lp)],'png');
        xlim([68 72]);
        ylim([-40 40]);
        saveas(gcf,['ZoomInFreqDomain_SSS',num2str(sssize),'_',num2str(lp)],'png');
        close;
        ylim([-140 -40]);
end

