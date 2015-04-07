function [ output_args ] = export_pdf( name )
global exportar
if(exportar == 1)
    % save figure
    set(gcf, 'PaperPosition', [0 0 5 5]); 
    set(gcf, 'PaperSize', [5 5]); 
    saveas(gcf, name, 'pdf') %Save figure
end
end

