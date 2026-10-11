# Redmine Cbots LaTeX

Plugin independiente para Redmine que añade macros LaTeX y una API Ruby para
renderizar fórmulas como imágenes en HTML estático. No depende de cosmoSys ni de
Jupyter.

> **EXPERIMENTAL:** Está disponible para evaluación, pero su cobertura y
> compatibilidad aún no se consideran asentadas. Se probará en el flujo de
> despliegue existente, sin crear ramas o variantes adicionales sólo para
> aislarla; sus interfaces y comportamiento todavía pueden cambiar.

El renderizador se extrajo de
[redmine_notebook_preview](https://github.com/cosmoBots/redmine_notebook_preview);
la vista previa de notebooks consume su API para exportar fórmulas.

## Instalación

Instala el directorio del plugin como `plugins/redmine_cbots_latex` y reinicia
Redmine. No añade tablas ni requiere migraciones. El repositorio independiente
del plugin aún está pendiente de crear/publicar.

## Macros

- `{{latex(x^2)}}` representa una fórmula en línea.
- `{{latex_block(\frac{a}{b})}}` representa una fórmula en bloque.

El archivo [`formulas_example.md`](formulas_example.md) contiene una página de
muestra con ecuaciones, derivadas, primitivas y tablas de Fourier y Laplace.

MathJax se carga de forma diferida desde jsDelivr al encontrar contenido marcado
por estas macros o por la clase `redmine-latex-content`. La carga desde CDN
requiere conexión a Internet; puede sustituirse por una copia local en entornos
aislados.

## Renderizado estático

`RedmineCbotsLatex::LatexRenderer.render_html(html)` reemplaza fórmulas
reconocidas por imágenes PNG, usando la configuración del plugin. También admite
`python_bin:` y `cache_dir:` para que un plugin consumidor reutilice su entorno.
Utiliza `matplotlib.mathtext`,
no una distribución TeX completa; fórmulas no compatibles quedan como texto.
Para esta función se necesita Python 3 con `matplotlib`. Las macros del navegador
no requieren esa dependencia. El plugin no intercepta automáticamente todos los
exportadores de Redmine; el plugin consumidor debe invocar la API en su salida
estática.

El plugin Notebook Preview puede usar esta API para convertir fórmulas de la
vista previa al exportar documentos estáticos.

## Configuración

Las rutas pueden definirse en Administración → Plugins → Redmine Cbots LaTeX o
mediante `LATEX_PYTHON_BIN` y `LATEX_CACHE_DIR`. Python usa `/usr/bin/python3`
por defecto. Sin matplotlib, la conversión
estática se omite de forma segura y el contenido original se conserva.

## Dependencias

- Redmine (sin dependencia de cosmoSys).
- MathJax 4 se obtiene del CDN para la presentación en el navegador.
- Python 3 + matplotlib son opcionales y sólo se usan para el renderizado
  estático a PNG.

Licencia: GNU GPL v3, conforme a la licencia del código del que se extrajeron
las macros y el renderizador. El renderizador se conserva con atribución al
plugin de origen.
