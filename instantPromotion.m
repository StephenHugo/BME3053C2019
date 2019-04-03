function instantPromotion(p)

for t=1:numel(p)
    figure
    plot(p(t).raw,'color',p(t).favoritecoloratthetime)
    title(p(t).date)
end

end