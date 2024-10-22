#import "template.typ": arxiv

#import "@preview/physica:0.9.3": ket
#import "@preview/subpar:0.1.1"


#show: arxiv.with(
  title: "Quantum Potato Chips",
  authors: ((
    (name: "Nikolay Murzin", email: "nikm@wolfram.com", affiliation: text([Wolfram Institute, USA#footnote[nmurzin\@wolframinstitute.org]\ Wolfram Research, USA])
    //, orcid: "0000-0000-0000-0000"
    ),
    (name: "Bruno Tenorio", email: "brunot@wolfram.com", affiliation: "Wolfram Research South America, Peru"),
    (name: "Sebastian Rodriguez", email: "srodriguez@wolfram.com", affiliation: "Wolfram Research South America, Peru")),(
    (name: "John McNally", email: "jmcnally@wolfram.com", affiliation: "Wolfram Research, USA"),
    (name: "Mohammad Bahrami", email: "mbahrami@wolfram.com", affiliation: "Wolfram Research, USA"),
  )),

  abstract: [We examine qubit states under symmetric informationally-complete measurements, representing state vectors as probability 4-vectors within a 3-simplex in $bb(R)^4$. Using geometric transformations, this 3-simplex is mapped to a tetrahedron in $bb(R)^3$. A specific surface within this tetrahedron allows for the separation of probability vectors into two disjoint 1-simplices.//, corresponding to the most classical quantum states. 
  The intersection of this surface with the insphere identifies a "quantum potato chip" region, where probability 4-vectors reduce to two separable 2-vectors. States within this region can be fully reconstructed using only two given projective measurements, a feature not found elsewhere in the state space.],
  // keywords: ("First keyword", "Second keyword", "etc."),
  date: [#datetime.today().display()],
)

#place(
  top + right,
  image("images/Pringles.png", height: 15%),
  dx: 5em,
  dy: -5em
)

#set heading(numbering: "1.")

#let bib(key, text) = {
  cite(key, supplement: text, style: "minimal.csl")
}

#let float(content) = {
  place(
    auto,
    scope: "parent",
    float: true,
    content
  )
}

#let eqcode(body, label, code) = {
  block(
    below: -0.5em,
    ref(supplement: [#body #label], code)
  )
}

// #figure(
//   image("PotatoChip.png"),
//   caption: [@chipPlot3D[Potato chip]],
//   numbering: none
// )

#columns(1)[

= Introduction

A qubit in a normalized quantum state can be expressed in the basis ${bb(I), sigma_x, sigma_y, sigma_z}$ as a 4-vector $1/2{1, x, y, z}$, with ${x,y,z} in bb(R)^3$. The condition $abs(arrow(r))<=1$ ensures that the density matrix is positive semi-definite, corresponding to a _physical_ state. Since the first component of the 4-vector is fixed, the state can be fully described by the Bloch vector $arrow(r) = {x, y, z}$ in $bb(R)^3$. Alternatively, in an appropriate basis, the qubit state can be represented as a probability 4-vector ${ p_1, p_2, p_3, p_4 }$ with $sum_i p_i = 1$ and $p_i >= 0$, known as the probability phase-space representation. Symmetric Informationally Complete Positive Operator-Valued Measures (SIC-POVMs) are optimal for such representations due to their symmetry and informational completeness
//#####
//Consider a qubit in a generic normalized state#footnote[In this paper, we will focus only on quantum theory in the discrete vector space.]. In the basis ${ bb(I) , sigma_x , sigma_y , sigma_z }$, the qubit state is described by the 4-vector $1 / 2 { 1 , x , y , z }$ with $r_(x , y , z) in bb(R)$. The condition $abs(arrow(r)) <= 1$ guarantees that the state can be a _physical_ state (i.e., the density matrix is positive semi-definite). Since the first element of the 4-vector is 1/2, one can drop it, and thus the quantum state can be described in $bb(R)^3$ by the Bloch vector $arrow(r)={x,y,z}$, given the mentioned basis. Alternatively, in a proper basis, a qubit state (i.e. the state vector) can be represented by a _probability_ 4-vector as ${ p_1 , p_2 , p_3 , p_4 }$ with $sum_i p_i = 1$ and $p_i gt.eq 0$. This is what we refer to as the probability phase-space representation, where quantum state (or any quantum process such as operator, measurement or channel) can be represented by probability vectors. In this regard, Symmetric Informationally Complete Positive Operator-Valued Measures (SIC-POVMs) are ideal choice due to their symmetry and optimality 
@renes2004symmetric @saraceno2017phase @fuchs2017sic @appleby2017introducing @scott2010symmetric @appleby2014symmetric.
//#bib(<renes2004symmetric>, [[1-6]]). 
//########
// @tab:quantum_povm illustrates the probability phase-space representation of various quantum states using the Tetrahedron SIC-POVM #footnote[Tetrahedron SIC-POVM elements are given by
// ${{1 / 2, 0},{ 0, 0}}$,
// ${{ 1 / 6, frac(i - √3, √2 (3 i + 3 √3))},{- frac(i √2, 3 i + 3 √3), 1 / 3}}$, ${{ 1 / 6, frac(i + √3, √2 (3 i - 3 √3))},{ frac(i √2, 3 (- i + √3)), 1 / 3}}$,
// and ${{ 1 / 6, frac(1, 3 √2)},{ frac(1, 3 √2), 1/3}}$ and Bloch vectors of its projectors by $(0,0,1)$, $(-√2/3,-√(2/3),-1/3)$, $(-√2/3,√(2/3),-1/3)$, and $((2√2)/3,0,-1/3)$, respectively.]. 
That said, the phase-space representation has historically been associated with bases such as Wigner, Wootters, and Gell-Mann @Wootters1986-cq@Feynman1987-vj@gell-mann, which require a quasi-probability approach (i.e., $sum_i p_i = 1$ but some $p_i$ can be negative). In this paper, we focus primarily on POVMs, though we also address the quasi-probability case.

For a qubit state in a SIC-POVM, the probability vector is confined within a simplex embedded in $bb(R)^4$ space. Through appropriate geometric transformations, this 4D object can be linearly projected onto a tetrahedron in $bb(R)^3$ (see @fig:rotation). Two key questions arise. From probability theory perspective, among all the points in the tetrahedron, which ones can be reduced to a disjoint pair of 1-simplices (two line segments), representing a separable probability distribution of uncorrelated binary random variables? From the quantum theory perspective, which points within the tetrahedron correspond to _physical_ quantum states? With answers to these questions in hand, we will be able to find quantum states that correspond to two disjoint probability distributions. This is the core idea of quantum potato chips that we discuss in this paper.

We will show that for states within the quantum potato chips, it is possible to reconstruct the entire state from only two independent projective measurements. Thus we refer to quantum potato chips as the informationally-minimal states, because their probability space can be reduced into two disjoint separable ones. This result embeds classical probability structures within quantum state representations, offering a novel intersection between classical and quantum probabilistic frameworks. An immediate consequence of the existence of these states is that any classical problem with two binary variables can be mapped into qubits. Future work will examine applications and foundational implications in more detail.

*Note for the readers*: All visualizations and some formulas in this paper have corresponding Wolfram Mathematica code, which can be found at the end. These are accessible by clicking on equations or figure captions, if applicable.

#subpar.grid(
  figure(image("images/Rotate2D.png"), caption: [$"2D" arrow "1D"$]),
  figure(image("images/Rotate3D.png", width: 90%), caption: [$"3D" arrow "2D"$]),
  figure(image("images/Rotate4D.png", width: 90%), caption: [$"4D" arrow "3D"$]),
  columns: (1fr, 1fr, 1fr),
  align: bottom,
  caption: [@code:rotation[Simplex projection to its lower dimension by rotation.]],
  label: <fig:rotation>
)

// #[
// #set text(9.5pt)
// #show math.equation: set text(size: 8pt)
// #figure(table(
//     columns: 4,
//     align: (center,center,center,center),

//     table.header([#strong[Quantum State];], [#strong[Tetrahedron ($cal(T)$)];],[#strong[Rotated $cal(T)$];], [#strong[Bloch sphere];]
//     ),
    
//     table.hline(),
  
//     $ket(0)$, ${1/2, 1/6, 1/6, 1/6}$, ${1/2, - 1/6, -1/6, -1/6}$, table.cell(rowspan: 6)[#image("images/tetrahedron.png",width:55%)],
    
//     $ket(1)$, ${0, 1/3, 1/3, 1/3}$, ${1/2, 1/6, 1/6, 1/6}$,
    
//     $ket(+)=1/√2(ket(0) + ket(1))$, ${1/4, 1/12 (3-√2), 1/12 (3-√2), 1/12 (3+2√2)}$, ${1/2, - 1/(6√2), - 1/(6√2), 1/(3√2)}$,
    
//     $ket(-)=1/√2(ket(0) - ket(1))$, ${1/4, 1/12 (3+√2), 1/12 (3+√2), 1/12 (3-2 √2)}$, ${1/2, 1/(6√2), 1/(6√2) , -1/(3√2)}$,
    
//     $ket(R)=1/√2(ket(0) + i ket(1))$, ${1/4, 1/12 (3-√6), 1/12 (3+√6), 1/4}$, ${1/2, -1/(2√6), 1/(2√6), 0}$,
    
//     $ket(L)=1/√2(ket(0) - i ket(1))$, ${1/4, 1/12 (3+√6), 1/12 (3-√6), 1/4}$, ${1/2, 1/(2√6), -1/(2√6), 0}$
//   ),
//   caption: [Quantum states and their corresponding probability vectors in the tetrahedron SIC-POVM, the transformed tetrahedron probability vectors, and Bloch sphere representations. The transformation is described by @eq:transformation.]
// ) <tab:quantum_povm>

= Generating Quantum Potato Chips
<generating-quantum-potato-chip>
== SIC-POVM Case
In an Informationally-Complete POVM (IC-POVM), a qubit state is fully described by a probability $4$-vector ${p_1,p_2,p_3,p_4}$ with $sum_i p_i=1$ and $p_i>=0$. The space of probability vectors is the unit standard simplex in $bb(R)^4$, spanned by points ${1, 0, 0, 0}$, ${0, 1, 0, 0}$, ${0, 0, 1, 0}$, and ${0, 0, 0, 1}$. This is a region with the embedding dimension 4 and the geometric dimension 3. Therefore, one can reduce the embedding dimension to 3. Consider the following rotation matrix:

#eqcode($
U_(upright("rot"))(theta) = mat( cos theta, frac(sin theta, sqrt(3)), frac(sin theta, sqrt(3)), frac(sin theta, sqrt(3)); - frac(sin theta, sqrt(3)), 1 / 3 (cos theta + 2), 1 / 3 (cos theta - 1), 1 / 3 (cos theta - 1); - frac(sin theta, sqrt(3)), 1 / 3 (cos theta - 1), 1 / 3 (cos theta + 2), 1 / 3 (cos theta - 1); - frac(sin theta, sqrt(3)), 1 / 3 (cos theta - 1), 1 / 3 (cos theta - 1), 1 / 3 (cos theta + 2)),
$, <eq:gen-rotation>, <code:gen-rotation>)
which represents a 4D rotation by $theta$ in the plane spanned by ${1,1,1,1}$ and ${1,0,0,0}$. For the special case of $theta=pi/3$, one gets:

#eqcode($
  U_(upright("rot")) =1/6 
  mat(3, 3, 3, 3; - 3, 5, - 1, - 1; - 3, - 1, 5, - 1; - 3, - 1, - 1, 5), 
$, <eq:transformation>, <code:transformation>)

@eq:transformation transforms a probability vector ${p_1, p_2, p_3, 1 - (p_1 + p_2 + p_3)}$ into ${1/2, -(1+2p_1)/6 + p_2, -(1+2p_1)/6 + p_3, 1/6 (5 - 8 p_1 - 6 p_2 - 6 p_3)}$. With the first element as a constant, one can drop it and reduce the dimension from 4D to 3D. 
In a similar manner @eq:transformation transforms the original 3-simplex into a new one spanned by ${1/2, -1/2, -1/2, -1/2}$, ${1/2, 5/6, -1/6, -1/6}$, ${1/2, -1/6, 5/6, -1/6}$, and ${1/2, -1/6, -1/6, 5/6}$. With all first elements as $1/2$, the transformed simplex can be projected into $bb(R)^3$ space, as a tetrahedron spanned by ${-1/2, -1/2, -1/2}$, ${5/6, -1/6, -1/6}$, ${-1/6, 5/6, -1/6}$, and ${-1/6, -1/6, 5/6}$#footnote[Treated as Bloch vectors, normalizing their density matrices, this basis is equivalent to the Feynman basis (up-to rotation and reflection, see @fig:matreshka), which orientation is taken to be the default in this paper.]. We investigate what region of this simplex (i.e. tetrahedron) can be reduced to lower dimensional $1$-simplex, implying the original probability $4$-vector can be written as product of two disjoint probability vectors in lower dimensions.

Take a $1$-simplex spanned by points ${1, 0}$ and ${0, 1}$ (@fig:1-simplex). Any point sampled from this simplex have the form ${ p , 1 - p }$ with $0 <= p <= 1$. Consider two points randomly sampled from this $1$-simplex: ${ p , 1 - p }$ and ${ q , 1 - q }$. Their outer product will be given by:

#eqcode(
$ { p q , p (1 - q) , q (1 - p) , (1 - p) (1 - q) }. $,<eq:kp-vector>,<code:kp-vector> )

@eq:transformation transforms @eq:kp-vector into:
#eqcode(
$
{1/2,-1/6+p-(4p q)/3,-1/6+q-(4p q)/3,5/6-p-q+(2p q)/3}.
$,<eq:rotated-vector>,<code:rotated-vector>)

After dropping the first element, one gets:

#eqcode(
$
{-1/6+p-(4p q)/3,-1/6+q-(4p q)/3,5/6-p-q+(2p q)/3}
$, <eq:chip1>, <code:chip1>
)

@eq:chip1 corresponds to a three-dimensional surface parameterized by
variables $0 lt.eq p lt.eq 1$ and $0 lt.eq q lt.eq 1$. This surface is fully contained within the tetrahedron of probability space, as shown @fig:surface. Not all of the points within the tetrahedron correspond to _physical_ quantum states (i.e. states with a positive semi-definite density matrix). The only region of this tetrahedron that corresponds to physical quantum state is the sphere that is inscribed within it#footnote[The insphere, centered at the origin ${0,0,0}$, has a radius $1/(sqrt(3))$. This radius is not unity because, for instance, a normalized vector such as ${1,0,0,0}$ transforms into the vector ${1/2, -1/2, -1/2, -1/2}$, which, after dropping the first component, becomes ${-1/2, -1/2, -1/2}$. To maintain normalization, this vector must be rescaled by a factor of $2sqrt(3)$. After rescaling, the resulting sphere has radius 1, analogous to the Bloch sphere.]. 



//This constraint is the same as saying the norm of probability vector cannot be larger than $1/(2 √3)$ (similar to the condition on norm of Bloch vector). 
The intersection of the insphere and the surface in @eq:chip1, is what we called as _quantum potato chip_. The border of the quantum potato chip, as highlighted in @fig:surface by the solid red line, is described by:

#eqcode(
$ 
q=1/2(1 plus.minus √((-1 + 6p - 6p^2) / (3(1 - 2p + 2p^2)))).
$,
<eq:constraint>, <code:constraint>
)

Therefore, the quantum potato chip is a surface described in @eq:chip1 and parameterized by $p,q$ as follow:
//#float([

#eqcode(  
$ 0<=p<=1, space space
1/2(1 - √((-1 + 6p - 6p^2) / (3(1 - 2p + 2p^2)))) <= q <= 1/2(1 + √((-1 + 6p - 6p^2) / (3(1 - 2p + 2p^2)))). $,<eq:boundary>, <code:boundary>
)
]
//)

Additionally, the original $1$-simplex in @fig:surface is in fact a 1D object embedded in 3D, spanned by points ${{1, 0,0}, {0,1,0}}$. There are two other choices for points as ${{1, 0,0}, {0,0,1}}$, and ${{0,1,0}, {0,0,1}}$. Therefore, overall there are three potato chips, as shown in @fig:3-chips, and their surfaces are described by @eq:chip1, @eq:chip2 and @eq:chip3, with $p,q$ parametrized in @eq:boundary.

#eqcode(
$
{-1/6 + q- (4 p q)/3,
5/6 - p - q + (2 p q)/3,
-1/6 + p - (4 p q)/3}\
$,<eq:chip2>,<code:chips>)
#eqcode(
$
{-1/6 - p/3 + q - (2 p q)/3, -1/6 - p/3 + (4 p q)/3, 
 5/6 - (4 p)/3 - q + (4 p q)/3}
$,<eq:chip3>,<code:chips>
)

#subpar.grid(
  figure(image("images/1-simplex.png",width:80%), caption: [@code:1-simplex[A $1$-simplex as the lowest dimensional probability space]]), <fig:1-simplex>,
  figure(image("images/surface.png",width:100%), caption: [@code:surface[Intersection of tetrahedron and surface of two $1$-simplex probability spaces]]), <fig:surface>,
  figure(image("images/3-chips.png",width:80%), caption: [@code:3-chips[Three quantum potato chips]]), <fig:3-chips>,
  columns: (1fr, 1fr,1fr),
  caption: [
    (a) A 1-simplex defined by the points ${ 1 , 0 }$, ${ 0 , 1 }$ (solid blue line). //Any point sampled from this simplex takes the form ${ p , 1 - p }$ with $0 <= p <= 1$. Since the geometric dimension of this 1-simplex is 1, although it is embedded in 2D, one can project it onto a 1D segment along x-axis by the geometric matrix $mat(delim: "(", 1 / 2, - 1 / 2, 1 / 2; 1 / √2, 1 / √2, - 1 / √2; 0, 0, 1)$, which is a composition of rotation, scaling and translation.
    (b) the blue solid line represents 1-simplex (same as in @fig:1-simplex). The surface, described by @eq:chip1, lies entirely within the 2-simplex (a tetrahedron).The solid red line represents the intersection of this surface with the tetrahedron’s insphere. Only the points within the insphere correspond to valid physical quantum states.
    (c) quantum potato chips are defined in @eq:chip1, @eq:chip2, and @eq:chip3, and parametrized by @eq:boundary. With one such surface in hand, one can find the other two through proper permutation of variables.
],
  label: <fig:main-simplex>,
)


== Bloch Sphere
Consider the following SIC-POVM for qubits (further referred to as the QBism SIC-POVM)#footnote[Any other SIC-POVM for qubits is simply a rotational transformation of this QBism SIC-POVM.], generated from a fiducial vector ${e^(-i (3pi)/4)(sqrt(3) - 1), 1}$ #footnote[By applying Weyl-Heisenberg displacement operators $X^p Z^q$ for $p,q in {0,1}$.] and POVM elements as follows:
#[
#set text(9.5pt)
$
cal(Q)_1=1/12mat(
  3 - √3,
  sqrt(6)e^(-i (3pi)/4);
  sqrt(6)e^(i (3pi)/4),
  3 + √3), space
cal(Q)_2=1/12mat(
  3 - √3,
  sqrt(6)e^(i (pi)/4);
  sqrt(6)e^(-i (pi)/4),
  3 + √3), space \
cal(Q)_3=1/12mat(
  3 + √3,
  sqrt(6)e^(i (3pi)/4);
  sqrt(6)e^(-i (3pi)/4),
  3 - √3), space
cal(Q)_4=1/12mat(
  3 + √3,
  sqrt(6)e^(-i (pi)/4);
  sqrt(6)e^(i (pi)/4),
  3 - √3),
$ <eq:povm>]
where $sum_i cal(Q)_i=bb(I)$ and $Q_i>=0$.
These POVM elements correspond to the following Bloch vectors, respectively#footnote[More precisely its projectors: $Pi_i=2cal(Q)_i$. All Bloch vectors are computed from normalized density matrices ($tr(rho)=1$).]: ${-1/√3, 1/√3, -1/√3}$, ${1/√3, -1/√3, -1/√3}$, ${-1/√3, -1/√3, 1/√3}$, ${1/√3, 1/√3, 1/√3}$ (see @fig:basis-vs-povm and @fig:chip-in-bloch). Likewise, the corresponding phase-space basis matrix for this SIC-POVM is given by:
$
cal(B)=
{mat((1 - sqrt(3))/2;
      e^(-i (3pi)/4)sqrt(3/2);
      e^(i (3pi)/4)sqrt(3/2);
      (1 + sqrt(3))/2),
mat((1 - sqrt(3))/2;
      e^(i pi/4)sqrt(3/2);
      e^(-i pi/4)sqrt(3/2);
      (1 + sqrt(3))/2),
mat((1 + sqrt(3))/2;
      e^(i (3pi)/4)sqrt(3/2);
      e^(-i (3pi)/4)sqrt(3/2);
      (1 - sqrt(3))/2),
mat((1 + sqrt(3))/2;
      e^(-i pi/4)sqrt(3/2);
      e^(i pi/4)sqrt(3/2);
      (1 - sqrt(3))/2),
}.
$<eq:qbism>


For a probability vector $arrow(p)={p_1,p_2,p_3,1-(p_1+p_2+p_3)}$ in the basis of @eq:qbism, the vectorized density matrix is given by:
  $
arrow(rho) =& cal(B).arrow(p) = 
mat(
     -√3(p_1+p_2)+(1-√3)/2; 
     sqrt(3/2)e^(i (3pi)/4)((1+i)p_1+(1-i)p_2+2p_3-1);
    sqrt(3/2)e^(i pi/4)((1-i)p_1+(1+i)p_2+2p_3-1); 
    -√3(p_1+p_2)+(√3+1)/2;
  ),
$<eq:density-phase-space>

whose eigenvalues are:
$ 1/2 (1 plus.minus sqrt(3) sqrt(8 (p_1^2+p_1 (p_2+p_3-1)+p_2^2+p_2 p_3+p_3^2)-8 p_2-8 p_3+3)).//=1/2(1 plus.minus sqrt(x^2+y^2+z^2)).
$<eq:eigenvalues>

By comparing the vectorized density matrix in the Bloch sphere, $1/2{1+z, x - i y,x + i y, 1-z}$, with its counterpart in the phase-space as expressed in @eq:density-phase-space, one finds that the probability vector $arrow(p)$ is related to the Bloch vector ${x,y,z}$ by the following replacement rule and its inverse: 

#grid(
columns: 2,
align: horizon,

[$ 
mat(p_1;p_2;p_3;) arrow
1/4mat(1 - 1/√3(x - y + z); 
1 + 1/√3(x - y - z); 
1 - 1/√3(x + y - z)).
$<eq:replacement-rule>
],

[$ 
mat(x;y;z;) arrow
√3mat(1-2p_1-2p_3; 
1-2p_2-2p_3; 
1-2p_1-2p_2).
$<eq:inverse-replacement-rule>
]

)

Imposing positivity on the eigenvalues in @eq:eigenvalues and applying the transformation in @eq:replacement-rule yields the condition $sqrt(x^2+y^2+z^2)<=1$ which describes the insphere as the only region within the tetrahedron that corresponds to physical quantum states.

// #figure(image("POVMvsBasis.png"), caption: [@POVMvsBasis[XXXXX]])<fig:POVMvsBasis>

The previous geometric description of potato chips can be applied directly into the Bloch sphere. Define a qubit state by the probability vector in @eq:kp-vector in the QBism SIC-POVM. Find the state in the Hilbert space using Weyl–Wigner transformation. Set one of the eigenvalue of the density matrix as zero and solve for $q$. The result will be the same as @eq:constraint. Replacing this condition into the Bloch vector $arrow(r)$, one gets:
//#float[
$
arrow(r)=
{-√(2/(1+2p(p-1))-3), (minus.plus 1 plus.minus 2 p) √(2/(1+2p(p-1))-3), (2p-1)√3}. 
$ <eq:bloch-chip-border>
//]
As shown in @fig:chip-in-bloch, @eq:bloch-chip-border parametrizes the boundary of the quantum potato chip in the Bloch sphere (with $0<=p<=1$), similar to @fig:surface.


#subpar.grid(
    
  figure(
    image("images/povm-basis-qbism-2.png",width:80%),
    caption:[@new-measurements[QBism SIC-POVM basis element and its POVM elements in Bloch sphere.]]),
  <fig:basis-vs-povm>,
  
  figure(
    image("images/chip-in-bloch-3.png"),
    // image("chip-in-bloch-2.png",width:70%),
    caption: [@chip-in-bloch[Quantum potato chip and QBism SIC-POVM elements in Bloch sphere.]]),
  <fig:chip-in-bloch>, 
  
  figure(image("images/3-new-measurements.png",width:65%), caption:[@new-measurements[Quantum potato chips and three new POVM elements.]]),
  <fig:new-measurements>,
  
  columns: (1fr, 1fr,1fr),
  caption: [
    (a) SIC-POVM basis ($cal(B)_i$, blue) vs POVM elements ($cal(Q)_i$, green), represented in the Bloch sphere. Note the $cal(B)_i$ tetrahedron represents the available phase-space, spanned by QBism SIC-POVM basis, while the POVM elements are within the insphere.
    (b) quantum potato chip in the Bloch sphere. The green spheres are Bloch vectors for the QBism SIC-POVM in @eq:qbism.
    (c) the solid red line is the boundary of quantum potato chip, while sphere represents new POVM defined in @eq:3new-M.
  ],
  label:<fig:3-M>,
)

= Quantum Potato Chip as the Informationally-Minimal States
We investigate the properties of quantum states within the "quantum potato chip", which we argue are the most informationally-minimal among quantum states represented in the Bloch sphere. To support this claim, we present two complementary arguments. First, we demonstrate that the Matthews correlation measure vanishes exclusively for the quantum potato chip states. Second, we show that states lying on the quantum potato chip can be generated solely through projective measurements in the Pauli-X and Pauli-Z bases, further reinforcing their status as informationally-minimal quantum states.

== Matthews correlation of classical binary variables
To quantify the correlation of classical binary variables within the quantum potato chip compared to other points in the Bloch sphere, one can use the Matthews correlation coefficient. Given binary variables defining the probability vector as:
$
arrow(p) = {p_1,p_2,p_3,p_4} arrow mat(p_11, p_12; p_21, p_22),
$ <eq:prob_vector>
the corresponding Matthews correlation coefficient is given by:
$
phi = (p_22 p_11 - p_12 p_21) / sqrt((p_11 + p_12)(p_21+p_22)(p_11+p_21)(p_12+p_22)) = (sqrt(3)y-x z)/(sqrt((3-x^2)(3-z^2))),
$ <eq:matthews>
where in the last step, we replace variables by the Bloch vector components ${x,y,z}$ using @eq:inverse-replacement-rule. 

As shown in @fig:matthew, the only region with $phi=0$ is the quantum potato chip. This means that measurement predictions in @eq:prob_vector, which can be obtained experimentally by measuring POVMs, are uncorrelated, much like flipping a pair of independent biased coins (probabilities are split as described by @eq:kp-vector). Equivalently, the states within the quantum potato chips can be represented as a product state in terms of the measurement basis associated with a SIC-POVM; precisely the scenario where the qubit state does not exhibit quantum correlations between certain SIC-POVM measurement outcomes.


#subpar.grid(
  columns: (1fr, 1fr, 0.1fr),
  figure(image("images/PhiContours.png",width: 75%)), <fig:PhiContours>,

  figure(image("images/PhiContours-2.png", width: 55%)),
  <fig:PhiContours-2>,

  caption: [@PhiContours[Matthews correlation coefficient @eq:matthews for the pair of binary variables forming the probability vector @eq:prob_vector. $phi$ has minimum $-1/sqrt(3)$ and maximum $1/sqrt(3)$ at the poles of the sphere]],
  label:<fig:matthew>
)

The @eq:matthews takes a more natural form if Bloch sphere's radius#footnote[Read our footnote for insphere, after @eq:chip1] is $1/sqrt(3)$:

$
phi = (y-x z)/(sqrt((1-x^2)(1-z^2))),
$

== Construction of Quantum State by Projective Measurements
=== SIC-POVM case
A qubit state can be reconstructed from SIC-POVM probabilities, because they are informationally complete (IC)@renes2004symmetric @saraceno2017phase @fuchs2017sic @appleby2017introducing @scott2010symmetric @appleby2014symmetric. However, general qubit states cannot be recovered from only two independent projective measurements. We will show that for states within the quantum potato chips, it is possible to reconstruct the entire state from only two independent projective measurements. Thus we refer to quantum potato chips as the informationally-minimal states, because their probability space can be reduced into two disjoint separable ones.

Given a SIC-POVM such as @eq:povm, define three new POVM sets as follows:
$cal(M)_x: {Q_1+Q_3,bb(I)-(Q_1+Q_3)}$,
$cal(M)_y: {Q_1+Q_4,bb(I)-(Q_1+Q_4)}$, and 
$cal(M)_z: {Q_1+Q_2,bb(I)-(Q_1+Q_2)}$. They correspond to measurements along these Bloch vectors:
$
cal(M)_x:{
  mat(1/√3; 0; 0), 
  mat(-1/√3; 0; 0;)
  }, space
cal(M)_y:{
  mat(0; 1/√3; 0), 
  mat(0; -1/√3; 0;)
  }, space
cal(M)_z:{
  mat(0; 0; 1/√3), 
  mat(0; 0; -1/√3;)
  },
$<eq:3new-M>
This feature is also visualized in @fig:new-measurements. One can see the vectors corresponding to $cal(M)_i$ are along the Cartesian axes (i.e. the same direction for Pauli matrices), but scaled by a factor of 1/√3.

For a qubit state defined by the probability vector of @eq:kp-vector in the SIC-POVM basis of @eq:qbism, the measurement probabilities for $cal(M)_x$ is ${q,1-q}$ and for $cal(M)_z$ is ${p,1-p}$. Additionally, $cal(M)_x$, $cal(M)_y$ and $cal(M)_z$ can be treated as scaled versions of projective measurements of Pauli operators $sigma_x$, $sigma_y$ and $sigma_z$, respectively. For a generic state such as $1 / 2 (bb(I) + arrow(r) . arrow(sigma))$, the Pauli-Z probabilities are ${1/2(1-z),1/2(1+z)}$, while for $cal(M)_z$ the probabilities are ${1/6 (3 - √(3) z), 1/6 (3 + √(3) z)}$; likewise for Pauli-X, one gets ${1/2(1-x),1/2(1+x)}$ while those of $cal(M)_x$ are ${1/6 (3 - √(3) x), 1/6 (3 + √(3) x)}$. These results can be also found directly from the density matrix in the QBism SIC-POVM basis:
$ 1/(4 sqrt(3)) mat(
(sqrt(3) + x - y + z), 
(sqrt(3) - x + y + z);
 (sqrt(3) + x + y - z), 
 (sqrt(3) - x - y - z)).
$<eq:sic-density>
Adding up columns in @eq:sic-density return $cal(M)_x$ probabilities, while for rows summation, one gets $cal(M)_z$ probabilities.
Given any projective measurement for Pauli matrices, if its probability is denoted by $P(sigma_i)=p$, the corresponding $cal(M)_i$ probability will be given by 
$P(cal(M)_i) = 1/√(3)(p-1/2)+1/2$. This
scaling can also be expressed with the following doubly-stochastic matrix#footnote[https://mathworld.wolfram.com/DoublyStochasticMatrix.html]:

$
cal(S)&=1/√3bb(I)+(1-1/√3)1/2
&=1/6mat(3+√3,3-√3;;3-√3,3+√3).
$

such that

$
p -> cal(S)p.
$<eq:stoch-shrink>


Therefore, for any state within the quantum potato chips, one can perform Pauli-X and Pauli-Z projective measurements and record corresponding probabilities. By transforming these probabilities using @eq:stoch-shrink, one recovers $p$ and $q$, reconstructing the probability vector in @eq:kp-vector and fully reconstructing the quantum state. One should notice that this process is doable for states only in the quantum potato chip and not for general states.

Consider one specific example. Given the state vector from @eq:kp-vector with parameters $p = 1/3$ and $q = 2/5$, the QBism SIC-POVM probabilities are ${2/15, 1/5, 4/15, 2/5}$. For measurements $cal(M)_z$ and $cal(M)_x$, the probabilities are ${1/6(3-sqrt(3)),1/6(3+sqrt(3))}$ and ${1/10 (5-sqrt(3)), 1/10 (5+sqrt(3))}$, respectively. For Pauli-Z and Pauli-X projective measurements, or after applying the transformation from @eq:stoch-shrink, the probabilities are ${1/3,2/3}$ and ${2/5,3/5}$, respectively. Their outer product also yields ${2/15, 1/5, 4/15, 2/5}$.

This factorization allows us to decouple the probability 4-vector in a 3-simplex into two lower-dimensional disjoint distributions in 1-simplices. Consequently, the probability space for a state in the quantum potato chip can be viewed as the product of two independent subspaces, each governed by their respective probability distributions. 
//This construction reflects the disjoint nature of the probability distributions for quantum potato chip, and highlights the independence between the two subspaces. 
In practical terms, the system exhibits a decoupling of correlations between the disjoint subspaces, which simplifies the analysis and allows us to treat each subspace independently. Potential implications will be discussed in our future work.


// == Inference?

// The basis in @eq:qbism allows not just to view states as probability vectors, but also operators and arbitrary quantum channels as quasi-stochastic processes.

== Quasi-Probability Bases
//quasi and relation to experiment?

Historically, the phase-space representation of quantum states, such those in bases of Wootters @Wootters1986-cq and Feynman @Feynman1987-vj #footnote[For qubits Feynman and Wootters bases are the same and we refer to both  interchangeably.], involves quasi-probability distributions. These representations allow for the treatment of quantum states in a manner similar to classical statistical distributions, but with key distinctions, such as the possibility of negative values. For example, Wootters basis is given by:

#eqcode($
cal(W)={
  vec(1, e^(-i pi/4)/sqrt(2), e^(i pi/4)/sqrt(2), 0),
  vec(0, e^(i pi/4)/sqrt(2), e^(-i pi/4)/sqrt(2), 1),
  vec(1, -e^(-i pi/4)/sqrt(2), -e^(i pi/4)/sqrt(2), 0),
  vec(0, e^(i pi/4)/sqrt(2), -e^(-i pi/4)/sqrt(2), 1)
}.
$, <eq:wootters-matrix>, <code:wootters-matrix>
)


In Wootters basis, the density matrix for a Bloch vector ${x,y,z}$ is described by:
#eqcode($ 
  mat(
  1/4 (1 + x + y + z), 1/4 (1 + x - y - z); 
  1/4 (1 - x - y + z), 1/4 (1 - x + y - z)
    ).
$,<eq:bloch-in-wooters>,<code:bloch-in-wooters>)
The summation of elements in @eq:bloch-in-wooters along columns results in $1/2(1+z)$ and $1/2(1-z)$, which represent the probabilities associated with projective measurements along the Pauli-Z axis. Similarly, summing the elements along rows yields $1/2(1+x)$ and $1/2(1-x)$, which correspond to the probabilities of measurements along the Pauli-X axis#footnote[Pauli-Z and Pauli-X measurement can be interpreted as the position (Pauli-Z) and momentum (Pauli-X) measurements within the phase space.]. In other words, in this case, there is no need for scaling or applying any extra transformation as in @eq:stoch-shrink for SIC-POVM case.

Wootters phase-space basis is no longer a proper probability distribution, and it is usually referred to as _quasi_-distribution. This provides another description of quantum potato chips as states that correspond to the subset of quasi-distributions with all entries being positive.

#subpar.grid(
  figure(
    image("images/ClassicalStates.png",width: 90%),
    caption: [@Wootters-tetra[Tetrahedron of Wootters basis.]]
  ),<fig:ClassicalStates>,
  
  figure(image("images/ClassicalStatesRegion.png",width: 90%), caption:[@Wootters-potato[Positive probability region of Wootters phase-pace]]),
  <fig:ClassicalStatesRegion>,
  
  figure(
    image("images/Matreshka.png",width: 120%), caption: [@Matreshka[Matryoshka of tetrahedrons]]),<fig:matreshka>,

  columns: (1fr, 1fr, 1fr),
  caption: [
    (a) the tetrahedron represents points in the phase-space of Wootters basis that corresponds to only positive probabilities. Note the Bloch sphere is not inscribed within the tetrahedron and not all points within the tetrahedron represents quantum states. Pauli-Z eigenstates are $ket(arrow.t), ket(arrow.b)$ and X are $ket(arrow.l), ket(arrow.r)$.
    (b) Quantum potato chip represents the states with independent observables, but represented in the Wootters basis. Its boundary is the solid black line. The region inside the Bloch sphere is the intersection of the Wootters tetrahedron and Bloch sphere, corresponding to quantum states represented by positive probability vectors#footnote[Refer to Fig.4 in @appleby2011properties, which has a similar visualization, in a slightly different context.] 
    (c) The correspondence between the probabilistic phase-space basis (blue), quasi-probabilistic Feynman basis @Feynman1987-vj (orange) and SIC-POVM projectors. Each tetrahedron is a scaled down version of the previous one by a factor of $sqrt(3)$ (green). Each corner is denoted by two arrows, representing spins along z and x axes (up/down for z-axis and right/left for x-axis).
    
  ],
  label: <fig:3-MM>,
)

Allowing quasi probabilities has some geometric consequences. If one considers only positive (say, classical) probabilities, the corresponding tetrahedron does not completely contain the Bloch sphere (see @fig:3-MM). In other words, parts of Bloch sphere outside of the tetrahedron correspond to states with negative probabilities in this basis. Additionally, the parametrization of the quantum potato chip will be different compared to @eq:constraint: 
$ q=1/2(1 plus.minus √(((1-p)p) / (2(1 - 2p + 2p^2)))). $<eq:constraint-Wootters>

A similar factorization argument for the probability vectors of the quantum potato chip can be applied in this context. However, it is crucial to note that, unlike the SIC-POVM case, the probabilities here do not necessarily correspond to directly measurable quantities, as they may take on negative values. 

// #figure(image("Matreshka.png",width: 60%), caption: [@Matreshka[The correspondence between the probabilistic phase-space basis, quasi-probabilistic Feynman basis @Feynman1987-vj and SIC-POVM projectors. Each tetrahedron is a scaled down version of the previous one by a factor of $sqrt(3)$]])<fig:matreshka>

= Effect of Error Channels on the Quantum Potato Chip
In this section, we explore the impact of noise on the quantum potato chip. Specifically, we model various types of errors using known quantum channels. See @tab:channels for detailed description of quantum channels, their Kraus operators and how they transform the Bloch sphere.


#[#set text(9.5pt)
#show math.equation: set text(size: 8pt)
#figure(
  align(horizon)[#table(
    columns: 3,
    rows: (.5cm, 1cm),
    table.header([#strong[Channel name];], [#strong[List of Kraus operators];],[#strong[Channel's effect on Bloch sphere];]),
    table.hline(),
    [Bit flip], [${sqrt(xi) space sigma_x,sqrt(1-xi) space bb(I)}$],table.cell(rowspan: 6)[#image("images/channels.png",width:90%)],
    [Phase flip], [${sqrt(xi) space sigma_z,sqrt(1-xi) space bb(I)}$],
    [Bit-phase flip], [${sqrt(xi) space sigma_y,sqrt(1-xi) space bb(I)}$],
    [Depolarization], [${sqrt(xi/4) space sigma_x,sqrt(xi/4) space sigma_y,sqrt(xi/4) space sigma_z,sqrt(1-(3xi)/4) space bb(I)}$],
    [Amplitude damping], [${(1-sqrt(xi))/2 sigma_z+(1+sqrt(1-xi))/2 bb(I),sqrt(xi)/2 sigma_x+i sqrt(xi)/2 sigma_y }$],
    [Phase damping], [${(1-sqrt(1-xi))/2 sigma_z+(1+sqrt(1-xi))/2 bb(I),
    &sqrt(xi)/2 bb(I)- sqrt(xi)/2 sigma_z }$]
  )]
  , caption: [@code:channels[Common noise channels and their corresponding Kraus operators. We also show how each one changes Bloch sphere.]]
  )<tab:channels>
]

The Bloch surface of the quantum potato chip, $sqrt(3){ (1 - 2 q), (2p-1)(2q-1),(1 - 2 p)}$ will be transformed into a new one as show in the following equation, for bit flip, phase flip, bit-phase flip, depolarization, amplitude damping, and phase damping, respectively:

#[#set text(9.5pt)
#show math.equation: set text(size: 8pt)
#figure(
  align(horizon)[#table(
    columns: 3,
    rows: (.5cm, 1cm),
    table.header([#strong[Channel name];], [#strong[Resultant Bloch vector];],[#strong[Channel's effect on Potato chip];]),
    table.hline(),
    [Bit flip], [$sqrt(3){- f_q, -f_p f_q f_xi,  f_p f_xi}$],table.cell(rowspan: 6)[#image("images/channels-on-potato.png",width:100%)],
    [Phase flip], [$sqrt(3){f_q f_xi, -f_p f_q f_xi, -f_p}$],
    [Bit-phase flip], [$sqrt(3){-f_q f_xi, f_p f_q,  f_p f_xi}$],
    [Depolarization], [$sqrt(3){-f_q (1-xi), f_p f_q (1-xi), -f_p (1-xi)}$],
    [Amplitude damping], [$sqrt(3){-f_q (1-xi), f_p f_q sqrt(1-xi), xi/sqrt(3)-f_p (1-xi)}$],
    [Phase damping], [$sqrt(3){-f_q sqrt(1 - xi), f_p f_q sqrt(1-xi), -f_p}$]
  )]
  , caption: [@code:channels-on-potato[Channels effect on potato chip. Considering $f_p=2p-1$, $f_q=2q-1$, $f_xi=2xi-1$. Image: We set error rate/probability as $xi=1/3$. The only noise channels that keep states within the quantum potato chips are bit flip, phase flip and phase damping.]]
  )<tab:channels-on-potato>
]


//$
// mat("BitFlip";
// "PhaseFlip";
// "BitPhaseFlip";
// "Depolarization";
// "AmplitudeDamping";
// "PhaseDamping") arrow
//mat(delim: #none,
//  "BitFlip: " {sqrt(3) (-1 + 2 q);
//  sqrt(3) (-1 + 2 p) (-1 + 2 q) (-1 + 2 xi);
//  sqrt(3) (-1 + 2 p) (1 - 2 xi)};
//  "PhaseFlip: " {sqrt(3) (-1 + 2 q) (1 - 2 xi), 
//  sqrt(3) (-1 + 2 p) (-1 + 2 q) (-1 + 2 xi), 
//  sqrt(3) (-1 + 2 p)};
// "PhaseDamping: " 
//{(-1 + 2 q) sqrt(3 - 3 xi), -((-1 + 2 p) (-1 + 2 q) sqrt(3 - 3 xi)), 
// sqrt(3) (-1 + 2 p)};
// "BitPhaseFlip: " {sqrt(3) (-1 + 2 q) (1 - 2 ), -sqrt(3) (-1 + 2 p) (-1 + 2 q), sqrt(3) (-1 + 2 p) (1 - 2 xi)};
 //"Depolarization: "
// {-sqrt(3) (-1 + 2 q) (-1 + xi), 
// sqrt(3) (-1 + 2 p) (-1 + 2 q) (-1 + xi), sqrt(3) (-1 + 2 p) (-1 + xi)};
// "AmplitudeDamping: "
//{(-1 + 2 q) sqrt(3 - 3 xi), -((-1 + 2 p) (-1 + 2 q) sqrt(
//    3 - 3 xi)), -sqrt(3) - 
//  2 sqrt(3) p (-1 + xi) + xi + sqrt(3) xi}
//)
//$


Upon a close analysis, one can show that bit flip, phase flip and phase damping map the states within the quantum potato chip to other states within the quantum potato chip, only reducing the volume of the region (see Table 2).//@fig:channels-on-potato
On the other hand, other channels map states such that they go outside of the quantum potato chip. To explicitly show that the probabilities are still separable for the bit flip case, the Bloch vector can be obtained by new variables $q',p'$ and @eq:kp-vector with ${p' = p + xi (1-2p), q' = q}$, for the phase flip it will be ${q' = q + xi (1-2q), p' = p}$, while for the phase damping it will be ${p' = p,
  q' = 1/2 (1 - sqrt(1 - xi) + 2 q sqrt(1 - xi))}$.


//#figure(
//  image("images/channels-on-potato.png", width: 60%),
//  caption: [@code:channels-on-potato[channels effect o//n potato chip. We set error rate/probability as $xi=1/3$. The only noise channels that keep states within the quantum potato chips are bit flip, phase flip and phase damping.]],
//) <fig:channels-on-potato>



= Unconventional Liouvillian Evolution at the Boundary of Quantum Potato Chips

A natural physics question arises: can the boundary of the quantum potato chip be understood as the result of state evolution under a master equation, starting from an appropriate initial condition?

Given that the trajectory of each individual probability vector $P = {p, 1-p}$ and $Q = {q, 1-q}$ is already known and constrained by @eq:constraint, the parameter $p$ can be interpreted as a time variable in a parametric equation for the whole system. We can identify two time (or parameter)-dependent transition matrices that generate the desired trajectory.

$
P'(p) = cal(L)_1(p) P(p),
space space
Q'(p) = cal(L)_2(p) Q(p)
$

By combining these two time-dependent transition matrices, we obtain the resulting transition matrix, which governs the overall evolution of the system.
$
cal(L) = log(e^(cal(L)_1) times.circle e^(cal(L)_2))
$

Any $2 times 2$ doubly stochastic transition matrix depends on only a single parameter, as the requirement that both its rows and columns sum to 1 imposes strict constraints on its form.
$
cal(L)_1 = mat(x,-x;-x,x), space
cal(L)_2 = mat(y,-y;-y,y)
$

We can then simply solve for $x$ and $y$ as follows:
$
x &= 1 / (2p - 1), space
y &= (1 - 2p) / (4p(1+p(-3 - 2p(p-2)))).
$
Accordingly, for the overall transition matrix one finds:

#eqcode(
$
cal(L) = mat(delim: "(", frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)), frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)), frac(1, 1 - 2 p), 0; frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)), frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)), 0, frac(1, 1 - 2 p); frac(1, 1 - 2 p), 0, frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)), frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)); 0, frac(1, 1 - 2 p), frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)), frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)))
$,
<eq:Liovillian>, <code:Liovillian>
)

In the Hilbert space, the master equation corresponding to the above transition can be expressed as:
$
dot(rho)=gamma_1(L_1 rho L_1^dagger-1/2{L_1^dagger L_1, rho})+gamma_2
(L_2 rho L_2^dagger-1/2{L_2^dagger L_2, rho}),
$
with two Lindblad jump operators:
$
L_1 = 1/sqrt(1-2p)(bb(I)+sigma_z),
space space
L_2 = 1/2sqrt((1-2p)/(p(1-p)(1-2p(1-p)))) space sigma_x.
$ <eq:Lindblads>
However, here we have unconventional (negative) opposite damping rates $gamma_1=-gamma_2=1$. Additionally, because of the singularity at $p=1/2$ in @eq:Lindblads, damping rates should swap signs to close the trajectory:

$
gamma_1=-gamma_2=cases(&1 "if" 0 < p <= 1/2, - &1 "if" 1/2<p<1)
$

#figure(
  image("images/evolution.png", width: 30%),
  caption: [@code:evolution[Two solutions from @eq:constraint-Wootters define opposite shifts to the initial state $ket(-) plus.minus delta p$, evolving in opposite directions.]]
) <fig:evolution>


While this specific evolution may lack an immediate physical interpretation, it is significant that, starting from any point on the boundary of the quantum chip, there is a non-conventional dynamical equation, guaranteeing that the quantum state remains pure physical state confined to it.

= Concluding remarks
// SIC-POVMs provide a natural way of describing quantum objects in the phase space. In this regard, a qubit state can be described by a probability $4$-vector in a $3$-simplex space. With proper geometric transformation, $3$-simplex can be projected into a tetrahedron in $bb(R)^3$. Quantum states are inside the insphere of the tetrahedron, meaning not all points within the tetrahedron corresponds a quantum state. Independently, a particular surface within the tetrahedron can be constructed by product of two independent $1$-simplex as probability space, providing the most minimal (say classical) description of quantum states. The part of aforementioned surface within the insphere forms a region we call as a quantum potato chip, which is the only part of the tetrahedron probability space that can be reduced to lower-dimensional probability space. This unique feature might provide advantage for these states as potential source for any computation. Of course, an important open question would be how any [universal] quantum computation can be reduced to only probabilistic rules, in a classical way, if possible and what new features should be incorporated into this machinary, to reproduce quantum results. This is a topics of our future research.

SIC-POVMs offer an elegant framework for representing qubit states geometrically, using a 4-dimensional probability vector within a 3-simplex. Through geometric transformations, this simplex can be projected into a regular tetrahedron in $bb(R)^3$. Crucially, not all points in this tetrahedron represent valid qubits, with physical quantum states residing within the insphere of the tetrahedron. A specific surface within this space, defined by the product of two 1-simplices, representing uncorrelated pair of binary variables, intersects the insphere forming the "quantum potato chip," a subset of quantum states of the qubit with uncorrelated projective observables.

This suggests an important question: can universal quantum computation still be achieved after restricting qubits to such states? Exploring this question and possible modifications to quantum formalism will be explored in future work. The geometric structure of SIC-POVMs suggests that understanding these spaces could unlock new pathways in quantum computing and quantum state representation.

a model on binary variables; binary variables are mapped into potato chips

// columns

#set heading(numbering: none)

= Acknowledgement
Computational aspects of this paper (e.g., mathematical derivation of formulas and visualizations) were done in the version 14.0 of the Wolfram Language. We also extensively used the Wolfram quantum framework, which a library of functionalities to perform symbolic and numeric quantum computation in the discrete finite-dimensional vector space. We thank James Wiles from Wolfram Institute, for his valuable comments on an early draft of our work.

#pagebreak()
// add style to handle multireference cite
#bibliography("references.bib", full: true, style: "american-physics-society")

#pagebreak()

#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#codly(number-format: none, zebra-fill: none)

#set heading(numbering: (..) => "", level: 4)

// == <chipPlot3D>
// ```WL 
// ParametricPlot3D[
//  Evaluate[
//   Rest@RotationTransform[{{1, 1, 1, 1}, {1, 0, 0, 0}}]@
//     Flatten@KroneckerProduct[{p, 1 - p}, {q, 1 - q}]], {p, 0, 1}, {q, 
//   1/2 - √[(-1 + 6 p - 6 p^2)/(1 - 2 p + 2 p^2)]/(2 √[3]), 
//   1/2 + √[(-1 + 6 p - 6 p^2)/(1 - 2 p + 2 p^2)]/(2 √[3])}, 
//  Mesh -> None, PlotPoints -> 200, Boxed -> False, Axes -> False]
// ```

= @fig:rotation <code:rotation>
```WL
GraphicsRow[
 {
  ListLinePlot[{
    {{0, 1}, {1, 0}},
    RotationTransform[{{1, 1}, {0, 1}}]@{{0, 1}, {1, 0}}
  },
  
  Mesh -> All, 
  Ticks -> None, 
  PlotRange -> {{-1, 1}, {0, 1}}, 
  AspectRatio -> 1/2, AxesLabel -> {"X", "Y"}
   
],
  
  Framed[
    "\!\(\*OverscriptBox[\(\[LongRightArrow]\),SubscriptBox[\(U\),\\(rot\)]]\)",
    FrameStyle -> None
  ],
  
  NumberLinePlot[Interval[{0, 1}], PlotStyle -> ColorData[97][2]]
  
  }
]

GraphicsRow[{
  
  Graphics3D[
   {#, TranslationTransform[{0, 0, -1/Sqrt[3]}]@
       RotationTransform[{ConstantArray[1, 3], UnitVector[3, 3]}]@#}
     &@Simplex[IdentityMatrix[3]],
   Axes -> True, AxesLabel -> {"X", "Y", "Z"},
   Ticks -> None, ViewPoint -> {3, -1, 1}
   ],
  
  Framed[
    "\!\(\*OverscriptBox[\(\[LongRightArrow]\), SubscriptBox[\(U\), \\(rot\)]]\)", 
    FrameStyle -> None
  ], 
  
  TernaryListPlot[{}, Method -> {"Backdrop" -> LightOrange}]
  
  }]


GraphicsRow[{
  Style[MatrixForm@IdentityMatrix[4], 30],
  
  Framed[
   "\!\(\*OverscriptBox[\(\[Rule]\), SubscriptBox[\(U\), \(rot\)]]\)",
    FrameStyle -> None
  ],
  
  Graphics3D[
   {
    Opacity[.5], 
    Simplex@RotationTransform[{ConstantArray[1, 4], 
         UnitVector[4, 1]}][IdentityMatrix[4]][[All, 2 ;;]]
    },
    
   Boxed -> False,
   
   Epilog -> {
     AxisObject[Line[{{.03, 0.15}, {0.23, .83}}], {0, 1}, 
      TickDirection -> "Inward", TickLengths -> 0], 
     AxisObject[Line[{{.77, 0.15}, {.03, 0.15}}], {0, 1}, 
      TickDirection -> "Inward", TickLengths -> 0], 
     AxisObject[Line[{{.03, 0.15}, {.6, 0.67}}], {0, 1}, 
      TickLabels -> None, TickLengths -> 0]
     }]
  }]
```

= @eq:gen-rotation <code:gen-rotation>
```WL
rot = RotationMatrix[θ, {{1, 1, 1, 1}, {1, 0, 0, 0}}];
rot // MatrixForm
```

= @eq:transformation <code:transformation>
```WL
rotation = rot /. θ -> π/3;
rotation // MatrixForm
```

= @eq:kp-vector <code:kp-vector>
```WL
product = KroneckerProduct[{p, 1 - p}, {q, 1 - q}] // Flatten
```
= @eq:rotated-vector <code:rotated-vector>
```WL
surface4d = rotation . product // ComplexExpand
```

= @eq:chip1 <code:chip1>
```WL
surface = Rest[surface4d]
```

= @eq:constraint <code:constraint>
```WL
boundary = Normal[Solve[Norm[2 Sqrt[3] surface] == 1, q, Reals]]
```

= @eq:boundary <code:boundary>
```WL
{0 <= p <= 1, First[#] <= q <= Last[#] &@Values[Flatten@boundary]}
```

= @eq:chip2 & @eq:chip3 <code:chips>
```WL
products = Permute[product, #] & /@ {{1, 4, 2, 3}, {3, 1, 2, 4}};
surfaces = ComplexExpand[Rest[rotation . #] & /@ products]
```

= @fig:1-simplex <code:1-simplex> 
```WL
Graphics[{
  {Text[Style["{q,1-q}", 10], {.37, .83}], 
   Text[Style["{p,1-p}", 10], {.7, .45}]},
  {ColorData[97][1], Simplex[{{1, 0}, {0, 1}}]}, {Black, 
   Point[{.25, .75}]},
  {Red, Point[{.65, .35}]}
  },
 	Axes -> True, AxesOrigin -> {0, 0},
 	AxesLabel -> {"p", "1-p"}, PlotLabel -> "1-simplex",
 	Frame -> True, GridLines -> Automatic, 
 FrameTicks -> {{Automatic, None}, {Automatic, None}}
 ]
``` 


= @fig:surface <code:surface>
```WL
Show[
 	Graphics3D[
  	{ 
      {Opacity[.5], Ball[{0, 0, 0}, 1/(2 Sqrt[3])]},
      {ColorData[97][1], Thickness[.005], Simplex[{{1, 0, 0}, {0, 1, 0}}]}
    },
  	
      Axes -> True, 
      AxesOrigin -> {0, 0, 0}, 
      Boxed -> False
  	],
 
 	ParametricPlot3D[surface /. boundary, {p, 0, 1}, Mesh -> None, PlotStyle -> Red],
  
 	ParametricPlot3D[surface, {p, 0, 1}, {q, 0, 1}, PlotStyle -> {Opacity[0.6]}],
 
 ImageSize -> 400]
```

= @fig:3-chips <code:3-chips>
```WL
ParametricPlot3D[
 Evaluate[Prepend[surfaces, surface]], {p, 0, 1}, Prepend[Flatten[Values[boundary]], q],
  Mesh -> None, 
  PlotStyle -> Opacity[.5], 
  PlotPoints -> 200, 
  Boxed -> False, 
  Axes -> False, 
  ImageSize -> 200
]
```


= @fig:basis-vs-povm <POVMvsBasis>
```WL
(*blochsphere is given in previous examples*)
basisPnts = 
  QuantumState[#]["BlochVector"] & /@ 
   QuantumBasis["QBismSIC"]["Elements"];
qbism = QuantumState[#]["BlochVector"] & /@ 
    QuantumMeasurementOperator["QBismSICPOVM"]["POVMElements"] // 
   Simplify;
Show[blochsphere,
 Graphics3D[{
   {MapIndexed[{PointSize[0.01], Sphere[#1, .05], Black, 
       Text[Subscript["\[ScriptCapitalB]", #2[[1]]], 1.05 #1]} &, 
     basisPnts],
    {Opacity[.2], FaceForm[None], 
     EdgeForm[{Opacity[.5], Thick, ColorData[97][1]}], 
     Tetrahedron[basisPnts]}},
   {
    ColorData[97][3],
    MapIndexed[{PointSize[0.01], Sphere[#1, .05], Black, 
       Text[Subscript["\[ScriptCapitalQ]", #2[[1]]], 1.2 #1]} &, 
     qbism],
    {Opacity[.5], EdgeForm[{Thick, ColorData[97][3]}], 
     Tetrahedron[qbism]}}
   }, Boxed -> False]]
```

= @fig:chip-in-bloch <chip-in-bloch>
```WL
blochsphere = Show[
   Graphics3D[{
            { Opacity[0.2], Sphere[]}, Black, Thickness[0.001], 
     Opacity[1.0],
             
     Splice @ {Line[{{0, 1, 0}, {0, -1, 0}}], 
       Line[{{0, 0, 1}, {0, 0, -1}}], Line[{{1, 0, 0}, {-1, 0, 0}}]},
             Splice @ {
                       Text[Ket[{0}], {0, 0, 1.05}],  
       Text[Ket[{1}], {0, 0, -1.05}],
                       Text[Ket[{"R"}], {0, 1.05, 0}], 
       Text[Ket[{"L"}], {0, -1.05, 0}],
                       Text[Ket[{"+"}], {1.05, 0, 0}], 
       Text[Ket[{"-"}], {-1.05, 0, 0}]}
     }, Boxed -> False ],
   ParametricPlot3D[
                {{Cos[t], Sin[t], 0}, {0, Cos[t], Sin[t]}, {Cos[t], 
      0, Sin[t]}},
                {t, 0, 2 Pi},
                PlotStyle -> ConstantArray[{Black, Thin}, 3]
            ]];
qbism = {{-(1/Sqrt[3]), 1/Sqrt[3], -(1/Sqrt[3])}, {1/Sqrt[
  3], -(1/Sqrt[3]), -(1/Sqrt[3])}, {-(1/Sqrt[3]), -(1/Sqrt[3]), 1/
  Sqrt[3]}, {1/Sqrt[3], 1/Sqrt[3], 1/Sqrt[3]}};
boundary = {{q -> 
     1/2 - Sqrt[(-2 + 12 p - 12 p^2)/(1 - 2 p + 2 p^2)]/(
      2 Sqrt[6])}, {q -> 
     1/2 + Sqrt[(-2 + 12 p - 12 p^2)/(1 - 2 p + 2 p^2)]/(
      2 Sqrt[6])}};
blochVector = {Sqrt[3] (-1 + 2 q), Sqrt[3] (-1 + p (2 - 4 q) + 2 q), 
   Sqrt[3] (-1 + 2 p)};
Show[
 Graphics3D[{
   ColorData[97][3],
   MapIndexed[{PointSize[0.01], Sphere[#1, .05], Black, 
      Text[Subscript["\[ScriptCapitalQ]", #2[[1]]], 1.2 #1]} &, qbism],
   {Opacity[.5], EdgeForm[{Thick, ColorData[97][3]}], 
    Tetrahedron[qbism]}}, Boxed -> False],
 ParametricPlot3D[blochVector /. boundary, {p, 0, 1}, 
  PlotStyle -> Red],
 ParametricPlot3D[
  blochVector, {p, 0, 1}, {q, Sequence @@ boundary[[All, -1, -1]]}, 
  PlotPoints -> 200, Mesh -> None, PlotStyle -> Opacity[.7]],
 blochsphere
 ]
```

= @fig:new-measurements <new-measurements>
```WL
(*get blochsphere from previous examples*)
vec1 = {-Sqrt[-3 + 2/(1 + 2 (-1 + p) p)], (-1 + 2  p)  Sqrt[-3 + 2/(
     1 + 2 (-1 + p) p)], Sqrt[3]  (-1 + 2  p)};
vec2 = {Sqrt[-3 + 2/(
    1 + 2 (-1 + p) p)], (1 - 2  p)  Sqrt[-3 + 2/(1 + 2 (-1 + p) p)], 
   Sqrt[3]  (-1 + 2  p)};
Legended[Show[
  blochsphere,
  ParametricPlot3D[{vec1, vec2}, {p, 0, 1}, PlotStyle -> Red],
  Graphics3D[{Opacity[.5],
    Green, 
    Sphere[#, .05] & /@ {{1/Sqrt[3], 0, 0}, {-(1/Sqrt[3]), 0, 0}},
    Blue, 
    Sphere[#, .05] & /@ {{0, -(1/Sqrt[3]), 0}, {0, 1/Sqrt[3], 0}},
    Cyan, Sphere[#, .05] & /@ {{0, 0, 1/Sqrt[3]}, {0, 0, -(1/Sqrt[3])}}
    }]], 
 Placed[SwatchLegend[{Green, Blue, 
    Cyan}, {"\!\(\*SubscriptBox[\(\[ScriptCapitalM]\), \(1\)]\)", 
    "\!\(\*SubscriptBox[\(\[ScriptCapitalM]\), \(2\)]\)", 
    "\!\(\*SubscriptBox[\(\[ScriptCapitalM]\), \(3\)]\)"}], {.95, \
.85}]]
```

= @fig:ClassicalStates <Wootters-tetra>
```WL
Show[Graphics3D[{{Text[Ket[{"\[UpArrow]"}], {0, 0, 1.3}], 
    Text[Ket[{"\[DownArrow]"}], {0, 0, -1.3}], 
    Text[Ket[{"\[RightArrow]"}], {1.3, 0, 0}], 
    Text[Ket[{"\[LeftArrow]"}], {-1.3, 0, 0}]}, Opacity[.5], Sphere[],
    Cyan, Simplex[{{1, 1, 1}, {1, -1, -1}, {-1, -1, 1}, {-1, 
      1, -1}}]}, Boxed -> False], 
 ParametricPlot3D[{{-1 + 
     2  p, (-1 + 2  p)  (-1 + 
       2  (1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])), -1 + 
     2  (1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])}, {-1 + 
     2  p, (-1 + 2  p)  (-1 + 
       2  (1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])), -1 + 
     2  (1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])}}, {p, 0, 1}, 
  PlotStyle -> Directive[Thickness[.01], Black]], 
 ParametricPlot3D[{-1 + 2  p, (-1 + 2  p)  (-1 + 2  q), -1 + 
    2  q}, {p, 0, 1}, {q, 
   1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))], 
   1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))]}, Mesh -> None, 
  PlotStyle -> Yellow]]
```


= @fig:ClassicalStatesRegion <Wootters-potato>
```WL
Show[Graphics3D[{{Text[Ket[{"\[UpArrow]"}], {0, 0, 1.3}], 
    Text[Ket[{"\[DownArrow]"}], {0, 0, -1.3}], 
    Text[Ket[{"\[RightArrow]"}], {1.3, 0, 0}], 
    Text[Ket[{"\[LeftArrow]"}], {-1.3, 0, 0}]}, Opacity[.5], 
   Sphere[]}, Boxed -> False], 
 ParametricPlot3D[{{-1 + 
     2  p, (-1 + 2  p)  (-1 + 
       2  (1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])), -1 + 
     2  (1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])}, {-1 + 
     2  p, (-1 + 2  p)  (-1 + 
       2  (1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])), -1 + 
     2  (1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])}}, {p, 0, 1}, 
  PlotStyle -> Directive[Thickness[.01], Black]], 
 BoundaryDiscretizeRegion[
  CSGRegion[
   "Intersection", {Ball[], 
    Simplex[{{1, 1, 1}, {1, -1, -1}, {-1, -1, 1}, {-1, 1, -1}}]}], 
  PrecisionGoal -> 4]]
```

= @fig:matreshka <Matreshka>
```WL
densityMatrix[phi_] := KroneckerProduct[phi, Conjugate[phi]]
blochVector[rho_?MatrixQ] := Tr /@ (PauliMatrix[Range[3]] . rho)
blochVector[phi_?VectorQ] := blochVector[densityMatrix[phi]]

basis = {{{1/2 (1 - Sqrt[3]), (-(1/2) - I/2) Sqrt[
      3]}, {(-(1/2) + I/2) Sqrt[3], 
     1/2 (1 + Sqrt[3])}}, {{1/2 (1 - Sqrt[3]), (1/2 + I/2) Sqrt[
      3]}, {(1/2 - I/2) Sqrt[3], 
     1/2 (1 + Sqrt[3])}}, {{1/2 (1 + Sqrt[3]), (-(1/2) + I/2) Sqrt[
      3]}, {(-(1/2) - I/2) Sqrt[3], 
     1/2 (1 - Sqrt[3])}}, {{1/2 (1 + Sqrt[3]), (1/2 - I/2) Sqrt[
      3]}, {(1/2 + I/2) Sqrt[3], 1/2 (1 - Sqrt[3])}}};
basisVectors = blochVector /@ basis;
povmProjectors = 2 Inverse[Outer[Tr@*Dot, #, #, 1]] . # &@basis;
feynmanVectors = {{-1, 1, -1}, {1, -1, -1}, {-1, -1, 1}, {1, 1, 1}};
povmVectors = blochVector /@ povmProjectors // Simplify;
labels = {"\[DownArrow]\[LeftArrow]", "\[DownArrow]\[Rule]", 
   "\[UpArrow]\[LeftArrow]", "\[UpArrow]\[Rule]"};
Legended[Graphics3D[{
   Opacity[.5],
   Sphere[],
   {{Text[Ket[{"\[UpArrow]"}], {0, 0, 1.3}], 
     Text[Ket[{"\[DownArrow]"}], {0, 0, -1.3}], 
     Text[Ket[{"\[RightArrow]"}], {1.3, 0, 0}], 
     Text[Ket[{"\[LeftArrow]"}], {-1.3, 0, 0}]}},
   {
    ColorData[97][1],
    MapIndexed[{PointSize[0.01], Sphere[#1, .05], Black, 
       Text[Subscript["\[ScriptCapitalB]", labels[[#2[[1]]]]], 
        1.1 #1]} &, basisVectors], {FaceForm[None], 
     EdgeForm[{Opacity[.5], Thick, ColorData[97][1]}], 
     Tetrahedron[basisVectors]}
    },
   {
    ColorData[97][2], 
    MapIndexed[{PointSize[0.01], Sphere[#1, .05], Black, 
       Text[Subscript["\[ScriptCapitalF]", labels[[#2[[1]]]]], 
        1.2 #1]} &, feynmanVectors], {FaceForm[None], 
     EdgeForm[{Thick, ColorData[97][2]}], 
     Tetrahedron[feynmanVectors]}
    },
   {
    ColorData[97][3], 
    MapIndexed[{PointSize[0.01], Sphere[#1, .05], Black, 
       Text[Subscript["\[ScriptCapitalQ]", labels[[#2[[1]]]]], 
        1.2 #1]} &, povmVectors], {FaceForm[None], 
     EdgeForm[{Thick, ColorData[97][3]}], Tetrahedron[povmVectors]}
    }
   }, Boxed -> False],
 SwatchLegend[
  ColorData[97] /@ Range[3], {"Basis", "Feynman", "SIC-POVM"}]
 ]
```

= @fig:PhiContours, @fig:PhiContours-2 <PhiContours>
```WL
Show[
 Graphics3D[{{Text[Ket[{"\[UpArrow]"}], {0, 0, 1.3}], 
    Text[Ket[{"\[DownArrow]"}], {0, 0, -1.3}], 
    Text[Ket[{"\[RightArrow]"}], {1.3, 0, 0}](*,Text[
    Ket[{"\[LeftArrow]"}],{-1.3,0,0}]*)}}],
 SliceContourPlot3D[(Sqrt[3] y - x z)/Sqrt[(x^2 - 3) (z^2 - 3)], 
  "CenterSphere", {x, y, z} \[Element] Ball[], Contours -> 5, 
  ColorFunction -> 
   Function[x, Opacity[1, ColorData["SunsetColors"][x]]], 
  ContourStyle -> Directive[Thick, Black], PlotLegends -> Automatic, 
  PlotPoints -> 10],
 Boxed -> False
 ]

ContourPlot3D[(
 Sqrt[3] y - x z)/Sqrt[(x^2 - 3) (z^2 - 3)], {x, -1, 1}, {y, -1, 
  1}, {z, -1, 1}, Contours -> Range[1/2, -1/2, -1/4], 
 RegionFunction -> Function[{x, y, z}, x^2 + y^2 + z^2 < 1], 
 Mesh -> None, RegionBoundaryStyle -> None, Boxed -> False, 
 Axes -> False, PlotLegends -> Automatic, PlotRangePadding -> None
]
```


= @fig:ClassicalStates <ClassicalStates>
```WL
Show[Graphics3D[{{Text[Ket[{"\[UpArrow]"}], {0, 0, 1.3}], 
    Text[Ket[{"\[DownArrow]"}], {0, 0, -1.3}], 
    Text[Ket[{"\[RightArrow]"}], {1.3, 0, 0}], 
    Text[Ket[{"\[LeftArrow]"}], {-1.3, 0, 0}]}, Opacity[.5], Sphere[],
    Cyan, Simplex[{{-((1 + Sqrt[3])/Sqrt[2 (2 + Sqrt[3])]), (
      1 + Sqrt[3])/Sqrt[
      2 (2 + Sqrt[3])], -((1 + Sqrt[3])/Sqrt[2 (2 + Sqrt[3])])}, {(
      1 + Sqrt[3])/Sqrt[
      2 (2 + Sqrt[3])], -((1 + Sqrt[3])/Sqrt[2 (2 + Sqrt[3])]), -((
       1 + Sqrt[3])/Sqrt[2 (2 + Sqrt[3])])}, {-1, -1, 1}, {1, 1, 
      1}}]}, Boxed -> False],
 ParametricPlot3D[{{-1 + 
     2 p, (-1 + 2 p) (-1 + 
       2 (1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])), -1 + 
     2 (1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])}, {-1 + 
     2 p, (-1 + 2 p) (-1 + 
       2 (1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])), -1 + 
     2 (1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))])}}, {p, 0, 1}, 
  PlotStyle -> Directive[Thickness[.01], Black]],
 ParametricPlot3D[{-1 + 2 p, (-1 + 2 p) (-1 + 2 q), -1 + 2 q}, {p, 0, 
   1}, {q, 1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))], 
   1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))]}, Mesh -> None, 
  PlotStyle -> Yellow]
 ]
```

= @eq:wootters-matrix <code:wootters-matrix>
```WL
(*Make sure the Wolfram quantum paclet is already installed*)
QuantumBasis["Wootters"]["Matrix"] // MatrixForm
```

= @eq:bloch-in-wooters <code:bloch-in-wooters>
```WL
(*Make sure the Wolfram quantum paclet is already installed*)
ArrayReshape[
 QuantumPhaseSpaceTransform[QuantumState["BlochVector"[{x, y, z}]], 
   "Wootters"]["AmplitudesList"], {2, 2}]
```


= @tab:channels <code:channels>
```WL
\[Psi]i = 
  QuantumState[
   "BlochVector"[FromSphericalCoordinates[{1, \[Theta], \[Phi]}]]];
GraphicsGrid[
 Partition[
  With[{bloch = 
       QuantumChannel[{StringDelete[#, "\n"], .35}][\[Psi]i][
        "BlochCartesianCoordinates"]}, 
     Show[QuantumState["UniformMixture"]["BlochPlot", 
       "ShowLabels" -> False], 
      ParametricPlot3D[
       bloch, {\[Theta], 0, \[Pi]}, {\[Phi], 0, 2 \[Pi]}, 
       PlotRange -> {{-1, 1}, {-1, 1}, {-1, 1}}, 
       PlotStyle -> Opacity[.5], Mesh -> None], 
      PlotLabel -> #]] & /@ {"BitFlip", "PhaseFlip", "PhaseDamping", 
    "BitPhaseFlip", "Depolarizing", "AmplitudeDamping"},
  UpTo[3]], ImageSize -> Full
 ]
```

= @tab:channels-on-potato <code:channels-on-potato>
```WL
\[Xi] = 1/3;
potato = 
  ParametricPlot3D[{Sqrt[3] (-1 + 2 q), 
    Sqrt[3] (-1 + p (2 - 4 q) + 2 q), Sqrt[3] (-1 + 2 p)}, {q, 0, 
    1}, {p, 1/6 (3 - Sqrt[-9 + 6/(1 + 2 (-1 + q) q)]), 
    1/6 (3 + Sqrt[-9 + 6/(1 + 2 (-1 + q) q)])}, PlotPoints -> 120, 
   PlotStyle -> Opacity[.75], Mesh -> None, 
   PlotRange -> {{-1, 1}, {-1, 1}, {-1, 1}}, Axes -> False, 
   Boxed -> False];
bloch = QuantumState["UniformMixture"]["BlochPlot", 
   "ShowLabels" -> False, "ShowAxes" -> False];
opts = {PlotRange -> {{-1, 1}, {-1, 1}, {-1, 1}}, Boxed -> False, 
   Axes -> False, ImagePadding -> -40};
GraphicsGrid[
 Partition[{Show[
    ParametricPlot3D[{Sqrt[3] (-1 + 2 q), 
      Sqrt[3] (-1 + 2 p) (-1 + 2 q) (-1 + 2 \[Xi]), 
      Sqrt[3] (-1 + 2 p) (1 - 2 \[Xi])}, {q, 0, 1}, {p, 
      1/6 (3 - Sqrt[-9 + 6/(1 + 2 (-1 + q) q)]), 
      1/6 (3 + Sqrt[-9 + 6/(1 + 2 (-1 + q) q)])}, PlotStyle -> Green, 
     PlotPoints -> 50], potato, bloch, PlotLabel -> "BitFlip", opts], 
   Show[ParametricPlot3D[{Sqrt[3] (-1 + 2 q) (1 - 2 \[Xi]), 
      Sqrt[3] (-1 + 2 p) (-1 + 2 q) (-1 + 2 \[Xi]), 
      Sqrt[3] (-1 + 2 p)}, {q, 0, 1}, {p, 
      1/6 (3 - Sqrt[-9 + 6/(1 + 2 (-1 + q) q)]), 
      1/6 (3 + Sqrt[-9 + 6/(1 + 2 (-1 + q) q)])}, PlotStyle -> Green, 
     PlotPoints -> 50], potato, bloch, PlotLabel -> "PhaseFlip", 
    opts], Show[
    ParametricPlot3D[{(-1 + 2 q) Sqrt[
        3 - 3 \[Xi]], -((-1 + 2 p) (-1 + 2 q) Sqrt[3 - 3 \[Xi]]), 
      Sqrt[3] (-1 + 2 p)}, {q, 0, 1}, {p, 
      1/6 (3 - Sqrt[-9 + 6/(1 + 2 (-1 + q) q)]), 
      1/6 (3 + Sqrt[-9 + 6/(1 + 2 (-1 + q) q)])}, PlotStyle -> Green, 
     PlotPoints -> 50], potato, bloch, PlotLabel -> "PhaseDamping", 
    opts], Show[
    ParametricPlot3D[{Sqrt[
        3] (-1 + 2 q) (1 - 2 \[Xi]), -Sqrt[3] (-1 + 2 p) (-1 + 2 q), 
      Sqrt[3] (-1 + 2 p) (1 - 2 \[Xi])}, {q, 0, 1}, {p, 
      1/6 (3 - Sqrt[-9 + 6/(1 + 2 (-1 + q) q)]), 
      1/6 (3 + Sqrt[-9 + 6/(1 + 2 (-1 + q) q)])}, PlotStyle -> Green, 
     PlotPoints -> 50], potato, bloch, PlotLabel -> "BitPhaseFlip", 
    opts], Show[
    ParametricPlot3D[{-Sqrt[3] (-1 + 2 q) (-1 + \[Xi]), 
      Sqrt[3] (-1 + 2 p) (-1 + 2 q) (-1 + \[Xi]), -Sqrt[3] (-1 + 
         2 p) (-1 + \[Xi])}, {q, 0, 1}, {p, 
      1/6 (3 - Sqrt[-9 + 6/(1 + 2 (-1 + q) q)]), 
      1/6 (3 + Sqrt[-9 + 6/(1 + 2 (-1 + q) q)])}, PlotStyle -> Green, 
     PlotPoints -> 50], potato, bloch, PlotLabel -> "Depolarizing", 
    opts], Show[
    ParametricPlot3D[{(-1 + 2 q) Sqrt[
        3 - 3 \[Xi]], -((-1 + 2 p) (-1 + 2 q) Sqrt[
          3 - 3 \[Xi]]), -Sqrt[3] - 2 Sqrt[3] p (-1 + \[Xi]) + \[Xi] +
        Sqrt[3] \[Xi]}, {q, 0, 1}, {p, 
      1/6 (3 - Sqrt[-9 + 6/(1 + 2 (-1 + q) q)]), 
      1/6 (3 + Sqrt[-9 + 6/(1 + 2 (-1 + q) q)])}, PlotStyle -> Green, 
     PlotPoints -> 50], potato, bloch, 
    PlotLabel -> "AmplitudeDamping", opts]}, UpTo[3]], 
 Spacings -> -40]
```

= @eq:Liovillian <code:Liovillian>
```WL
P = {p, 1 - p};
Q = {q, 1 - q} /. q -> 1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))];
ℒ1 = {{x, -x}, {-x, x}} /. 
  Solve[Thread[{{x, -x}, {-x, x}} . P == D[P, p], x], x][[1]]
ℒ2 = {{y, -y}, {-y, y}} /. 
  Solve[Thread[{{y, -y}, {-y, y}} . Q == D[Q, p], y], y][[1]]
ℒ = 
 MatrixLog[
    KroneckerProduct[MatrixExp[ℒ1], 
     MatrixExp[ℒ2]]] // ComplexExpand // FullSimplify
```

= @fig:evolution <code:evolution>
```WL
proba = Flatten[KroneckerProduct[{p, 1 - p}, {q, 1 - q}]];
state = QuantumWeylTransform[
   QuantumState[proba, "Wootters", "Parameters" -> {p, q}]];
sol = Solve[Simplify[Norm[state["BlochVector"]] == 1], q, Reals] // 
    Simplify // Normal;
    
L1 = QuantumOperator[{{2/Sqrt[1 - 2 p], 0}, { 0 , 0}}];
L2 = QuantumOperator[{{0, Sqrt[-1 + 2 p]/(
     2 Sqrt[(-1 + p) p (1 + 2 (-1 + p) p)])}, { Sqrt[-1 + 2 p]/(
     2 Sqrt[(-1 + p) p (1 + 2 (-1 + p) p)]), 0}}];
\[Gamma] = (-1)^{Boole[p > 1/2], Boole[p <= 1/2]};

p0 = 0.0001;
p1 = 1;
init1 = state[<|p -> p, sol[[1]]|> /. p -> p0];
init2 = state[<|p -> p, sol[[2]]|> /. p -> p0];
final1 = 
  Quiet@QuantumEvolve[
    QuantumOperator["Hamiltonian"[{L1, L2}, \[Gamma]]], 
    init1, {p, p0, p1}];
final2 = 
  Quiet@QuantumEvolve[
    QuantumOperator["Hamiltonian"[{L1, L2}, \[Gamma]]], 
    init2, {p, p0, p1}];
Show[QuantumState["-"]["BlochPlot", "ShowAxes" -> False, 
  "ShowArrow" -> False],
 Graphics3D[{Red, Thick, Arrow[{{0, 0, 0}, init1["BlochVector"]}], 
   Blue, Arrow[{{0, 0, 0}, init2["BlochVector"]}]}],
 ParametricPlot3D[
  Evaluate[{final1["BlochVector"], final2["BlochVector"]}], {p, p0, 
   p1}, PlotStyle -> {Directive[Thickness[.01], Red], 
    Directive[Thickness[.01], Blue]}], 
 ParametricPlot3D[{-1 + 2 p, (-1 + 2 p) (-1 + 2 q), -1 + 2 q}, {p, 0, 
   1}, {q, 1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))], 
   1/2 + Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))]}, Mesh -> None, 
  PlotStyle -> Yellow]]
```

//bloch vector for chip
// ```WL
// r = {{1/2 - Sqrt[3]/2 + Sqrt[3]  p, (1/2 + I/2)  Sqrt[
//      3]  (-I + (1 + I)  p)  (-1 + 2  q)}, {(-(1/2) - I/2)  Sqrt[
//      3]  (-1 + (1 + I)  p)  (-1 + 2  q), 
//     1/2  (1 + Sqrt[3] - 2  Sqrt[3]  p)}};
// sol = Normal@Solve[Eigenvalues[r][[1]] == 0, q, Reals];
// vec1 = FullSimplify[{Sqrt[3]  (-1 + 2  q), 
//     Sqrt[3]  (-1 + p  (2 - 4  q) + 2  q), Sqrt[3]  (-1 + 2  p)} /. 
//    sol[[1]]]
// vec2 = FullSimplify[{Sqrt[3]  (-1 + 2  q), 
//     Sqrt[3]  (-1 + p  (2 - 4  q) + 2  q), Sqrt[3]  (-1 + 2  p)} /. 
//    sol[[2]]]
// ```

