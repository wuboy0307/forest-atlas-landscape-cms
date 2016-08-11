class PageType < EnumerateIt::Base
  associate_values(
    open_content: [1, 'Open Content'],
    analysis_dashboard: [2, 'Analysis Dashboard'],
    dynamic_indicator_dashboard: [3, 'Dynamic Indicator Dashboard'],
    homepage: [4, 'Homepage']
  )
end
