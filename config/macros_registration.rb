Redmine::WikiFormatting::Macros.register do
  desc 'Render an inline LaTeX formula with MathJax. Example: {{latex(x^2)}}'
  macro :latex do |_obj, args, _text|
    formula = args.join(',')
    content_tag(:span, "\\(#{formula}\\)", class: 'latex-preview-content')
  end

  desc 'Render a display-style LaTeX formula with MathJax. Example: {{latex_block(\\frac{a}{b})}}'
  macro :latex_block do |_obj, args, _text|
    formula = args.join(',')
    content_tag(:div, "\\[#{formula}\\]", class: 'latex-preview-content')
  end
end
