function [ output_args ] = export_pdf( name, save )
    if(save)
        % save figure
        set(gcf, 'PaperPosition', [0 0 5 5]); 
        set(gcf, 'PaperSize', [5 5]); 
        saveas(gcf, name, 'pdf') %Save figure
    end
end

