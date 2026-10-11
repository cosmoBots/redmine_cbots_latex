# Ejemplo de fórmulas LaTeX

Página de muestra para probar las macros `latex` y `latex_block` de
Redmine Cbots LaTeX. Cópiala en una página wiki o en un texto que procese las
macros de Redmine. MathJax necesita que el navegador pueda acceder a jsDelivr.

## Mecánica

Segunda ley de Newton:

{{latex_block(\mathbf{F}=m\mathbf{a})}}

Ley de gravitación universal:

{{latex_block(F=G\frac{m_1m_2}{r^2})}}

Ley de Hooke para un muelle ideal:

{{latex_block(F=-kx)}}

## Ecuación de ondas

La ecuación de ondas unidimensional describe, entre otros fenómenos, la
propagación de una perturbación por una cuerda tensa:

{{latex_block(\frac{\partial^2 u}{\partial t^2}=c^2\frac{\partial^2 u}{\partial x^2})}}

Aquí, `u` es la perturbación y `c` la velocidad de propagación.

## Termodinámica

Primera ley, tomando `W` como el trabajo realizado por el sistema:

{{latex_block(\Delta U=Q-W)}}

Ecuación de estado del gas ideal:

{{latex_block(pV=nRT)}}

Rendimiento máximo de una máquina térmica reversible de Carnot, con
`T_c < T_h` y temperaturas absolutas:

{{latex_block(\eta_{\mathrm{Carnot}}=1-\frac{T_c}{T_h})}}

## Geometría

Teorema de Pitágoras:

{{latex_block(a^2+b^2=c^2)}}

Longitud de una circunferencia y área del círculo de radio `r`:

{{latex_block(C=2\pi r,\qquad A=\pi r^2)}}

Área y volumen de una esfera de radio `r`:

{{latex_block(A=4\pi r^2,\qquad V=\frac{4}{3}\pi r^3)}}

## Primitivas (integrales indefinidas)

En todas las filas, `C` es una constante de integración. Las condiciones
indican los valores para los que se aplica cada fórmula.

| Integrando | Primitiva | Condición |
|---|---|---|
| {{latex(x^n)}} | {{latex(\frac{x^{n+1}}{n+1}+C)}} | {{latex(n\ne -1)}} |
| {{latex(1/x)}} | {{latex(\ln\lvert x\rvert+C)}} | {{latex(x\ne 0)}} |
| {{latex(e^{ax})}} | {{latex(\frac{e^{ax}}{a}+C)}} | {{latex(a\ne 0)}} |
| {{latex(\sin(ax))}} | {{latex(-\frac{\cos(ax)}{a}+C)}} | {{latex(a\ne 0)}} |
| {{latex(\cos(ax))}} | {{latex(\frac{\sin(ax)}{a}+C)}} | {{latex(a\ne 0)}} |
| {{latex(1/(1+x^2))}} | {{latex(\arctan x+C)}} | — |
| {{latex(\sec^2(ax))}} | {{latex(\frac{\tan(ax)}{a}+C)}} | {{latex(a\ne 0)}} |

## Derivadas

En la tabla, `u=u(x)` y `v=v(x)` son funciones derivables; `u'` y `v'`
representan sus derivadas respecto a `x`.

| Función | Derivada | Condición |
|---|---|---|
| {{latex(x^n)}} | {{latex(nx^{n-1})}} | Para exponentes reales, donde la función esté definida |
| {{latex(e^{ax})}} | {{latex(ae^{ax})}} | — |
| {{latex(\ln x)}} | {{latex(\frac{1}{x})}} | {{latex(x>0)}} |
| {{latex(\sin(ax))}} | {{latex(a\cos(ax))}} | — |
| {{latex(\cos(ax))}} | {{latex(-a\sin(ax))}} | — |
| {{latex(\tan(ax))}} | {{latex(a\sec^2(ax))}} | Donde {{latex(\cos(ax)\ne 0)}} |
| {{latex(u+v)}} | {{latex(u'+v')}} | — |
| {{latex(uv)}} | {{latex(u'v+uv')}} | Regla del producto |
| {{latex(u/v)}} | {{latex(\frac{u'v-uv'}{v^2})}} | {{latex(v\ne 0)}} |
| {{latex(f(u))}} | {{latex(f'(u)u')}} | Regla de la cadena |

## Transformada de Fourier

Usamos la convención
{{latex(\mathcal{F}\{f\}(\omega)=\int_{-\infty}^{\infty}f(t)e^{-i\omega t}\,dt)}}.
La función `\operatorname{sinc}(x)` se define como
{{latex(\operatorname{sinc}(x)=\frac{\sin x}{x})}}, con valor `1` en `x=0`.

| Señal {{latex(f(t))}} | Transformada {{latex(F(\omega))}} | Condición |
|---|---|---|
| {{latex(e^{-a\lvert t\rvert})}} | {{latex(\frac{2a}{a^2+\omega^2})}} | {{latex(a>0)}} |
| {{latex(e^{-at}u(t))}} | {{latex(\frac{1}{a+i\omega})}} | {{latex(a>0)}} |
| {{latex(e^{-t^2/(2\sigma^2)})}} | {{latex(\sigma\sqrt{2\pi}\,e^{-\sigma^2\omega^2/2})}} | {{latex(\sigma>0)}} |
| {{latex(\operatorname{rect}(t/T))}} | {{latex(T\,\operatorname{sinc}(\omega T/2))}} | {{latex(T>0)}}; {{latex(\operatorname{rect}(y)=1)}} si {{latex(\lvert y\rvert<1/2)}} |

`u(t)` es el escalón unitario. La última pareja usa el pulso rectangular
centrado, de anchura `T`.

## Transformada de Laplace

Usamos la transformada unilateral:
{{latex(\mathcal{L}\{f(t)\}=F(s)=\int_0^{\infty}f(t)e^{-st}\,dt)}}.
La columna de convergencia indica una región suficiente para estas parejas.

| Función {{latex(f(t))}} | Transformada {{latex(F(s))}} | Convergencia |
|---|---|---|
| {{latex(1)}} | {{latex(\frac{1}{s})}} | {{latex(\operatorname{Re}(s)>0)}} |
| {{latex(t^n)}} | {{latex(\frac{n!}{s^{n+1}})}} | `n` entero no negativo; {{latex(\operatorname{Re}(s)>0)}} |
| {{latex(e^{at})}} | {{latex(\frac{1}{s-a})}} | {{latex(\operatorname{Re}(s)>a)}} |
| {{latex(\sin(\omega_0t))}} | {{latex(\frac{\omega_0}{s^2+\omega_0^2})}} | {{latex(\operatorname{Re}(s)>0)}} |
| {{latex(\cos(\omega_0t))}} | {{latex(\frac{s}{s^2+\omega_0^2})}} | {{latex(\operatorname{Re}(s)>0)}} |
| {{latex(u(t-a))}} | {{latex(\frac{e^{-as}}{s})}} | {{latex(a\geq 0)}}; {{latex(\operatorname{Re}(s)>0)}} |

## Fórmula en línea

Las macros también se pueden usar dentro de un párrafo: la energía en reposo
de una masa `m` es {{latex(E=mc^2)}}. Esta forma compacta resulta útil para
probar que una fórmula no interrumpe el flujo de lectura.
