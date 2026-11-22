require File.expand_path('../../test_helper', __FILE__)

class LatexRendererTest < ActiveSupport::TestCase
  LatexRenderer = RedmineCbotsLatex::LatexRenderer

  def setup
    @tmp_dir = Dir.mktmpdir('latex_renderer_test')
  end

  def teardown
    FileUtils.rm_rf(@tmp_dir)
  end

  # ---------------------------------------------------------------------------
  # split_text
  # ---------------------------------------------------------------------------
  test 'split_text finds display math between double dollars' do
    pieces = LatexRenderer.split_text('before $$ a^2 + b^2 $$ after')
    formula = pieces.grep(LatexRenderer::Formula).first
    assert_equal 'a^2 + b^2', formula.tex
    assert formula.display
    assert_equal ['before ', ' after'], pieces.grep(String)
  end

  test 'split_text finds inline math between single dollars' do
    formula = LatexRenderer.split_text('the value $x_1$ is').grep(LatexRenderer::Formula).first
    assert_equal 'x_1', formula.tex
    assert_not formula.display
  end

  test 'split_text accepts spaces next to single dollars' do
    formulas = LatexRenderer.split_text('see $ FWHM = 1.0 $ and $ \\lambda$ here').grep(LatexRenderer::Formula)
    assert_equal ['FWHM = 1.0', '\\lambda'], formulas.map(&:tex)
  end

  test 'split_text finds bracket and parenthesis delimiters' do
    formulas = LatexRenderer.split_text('\\[ E = mc^2 \\] and \\( y \\)').grep(LatexRenderer::Formula)
    assert_equal ['E = mc^2', 'y'], formulas.map(&:tex)
    assert_equal [true, false], formulas.map(&:display)
  end

  test 'split_text finds multiline display math' do
    formula = LatexRenderer.split_text("$$\n\\frac{a}{b}\n$$").grep(LatexRenderer::Formula).first
    assert_equal '\\frac{a}{b}', formula.tex
  end

  test 'split_text does not treat prices as math' do
    assert_empty LatexRenderer.split_text('it costs $5 and then $6 more').grep(LatexRenderer::Formula)
  end

  test 'split_text returns plain text when there is no math' do
    assert_equal ['nothing here'], LatexRenderer.split_text('nothing here')
  end

  # ---------------------------------------------------------------------------
  # formula_targets
  # ---------------------------------------------------------------------------
  MIXED_HTML = '<p>wiki $x$ and ${A} y ${B}</p>' \
               '<p><span class="latex-preview-content">\\(y^2\\)</span></p>' \
               '<div class="redmine-latex-content"><p>notebook $z$</p></div>'.freeze

  test 'formula_targets takes formulas anywhere by default' do
    fragment = Nokogiri::HTML5.fragment(MIXED_HTML)
    formulas = LatexRenderer.formula_targets(fragment).flat_map { |_, pieces| pieces.grep(LatexRenderer::Formula) }
    assert_equal ['x', '{A} y', 'y^2', 'z'], formulas.map(&:tex)
  end

  test 'formula_targets with marked_only takes only macro and marked containers' do
    fragment = Nokogiri::HTML5.fragment(MIXED_HTML)
    targets = LatexRenderer.formula_targets(fragment, marked_only: true)
    formulas = targets.flat_map { |_, pieces| pieces.grep(LatexRenderer::Formula) }
    assert_equal ['y^2', 'z'], formulas.map(&:tex)
  end

  # ---------------------------------------------------------------------------
  # render_html
  # ---------------------------------------------------------------------------
  test 'render_html returns the html untouched when python is not available' do
    html = '<p>$$ x $$</p>'
    result = LatexRenderer.render_html(html, python_bin: '/nonexistent/python', cache_dir: @tmp_dir)
    assert_equal html, result
  end

  test 'render_html returns the html untouched when there is no math' do
    html = '<p>plain</p>'
    result = LatexRenderer.render_html(html, python_bin: '/nonexistent/python', cache_dir: @tmp_dir)
    assert_equal html, result
  end

  test 'render_html replaces formulas with images and skips code blocks' do
    python = latex_python
    skip 'python with matplotlib is not available' unless python

    html = '<p>Area $$ \\pi r^2 $$ and $x_1$</p><pre>$$ not math $$</pre>'
    result = LatexRenderer.render_html(html, python_bin: python, cache_dir: @tmp_dir)

    assert_equal 2, result.scan('<img').size
    assert_includes result, 'data:image/png;base64,'

    image = Nokogiri::HTML5.fragment(result).at_css('img')
    assert_includes image['style'], "width: #{image['width']}px"
    assert_includes image['style'], "height: #{image['height']}px"
    png = Base64.strict_decode64(image['src'].split(',', 2).last)
    assert_equal "\x89PNG\r\n\x1A\n".b, png.byteslice(0, 8)

    assert_includes result, '<pre>$$ not math $$</pre>'
    assert_not_includes result, '\\pi r^2 $$'
  end

  test 'render_html with marked_only leaves wiki dollar text alone' do
    python = latex_python
    skip 'python with matplotlib is not available' unless python

    html = '<p>price $x$</p><p><span class="latex-preview-content">\\(y^2\\)</span></p>'
    result = LatexRenderer.render_html(html, python_bin: python, cache_dir: @tmp_dir, marked_only: true)

    assert_equal 1, Nokogiri::HTML5.fragment(result).css('img').size
    assert_includes result, 'price $x$'
  end

  test 'render_html leaves a formula that cannot be rendered as text' do
    python = latex_python
    skip 'python with matplotlib is not available' unless python

    html = '<p>$$ \\begin{align} a &= b \\end{align} $$</p>'
    result = LatexRenderer.render_html(html, python_bin: python, cache_dir: @tmp_dir)

    assert_not_includes result, '<img'
    assert_includes result, 'align'
  end

  test 'render_html supports left and right absolute value delimiters' do
    python = latex_python
    skip 'python with matplotlib is not available' unless python

    html = '<p>\\(\\ln\\lvert x\\rvert+C\\) and \\(e^{-a\\lvert t\\rvert}\\)</p>'
    result = LatexRenderer.render_html(html, python_bin: python, cache_dir: @tmp_dir)

    assert_equal 2, Nokogiri::HTML5.fragment(result).css('img').size
    assert_not_includes result, '\\(\\ln'
  end

  private

  # Python of the configured virtualenv, only when matplotlib can be imported
  def latex_python
    python = Setting.plugin_redmine_cbots_latex['python_bin'].to_s
    return unless File.executable?(python)

    python if system(python, '-c', 'import matplotlib', out: File::NULL, err: File::NULL)
  end
end
