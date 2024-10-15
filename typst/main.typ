#import "template.typ": arxiv

#import "@preview/physica:0.9.3": ket
#import "@preview/subpar:0.1.1"


#show: arxiv.with(
  title: "Quantum Potato Chips",
  authors: (
    (name: "Nikolay Murzin", email: "nmurzin@wolframinstitute.org", affiliation: "Wolfram Institute"
    //, orcid: "0000-0000-0000-0000"
    ),
    (name: "Bruno, Sebastian", email: "XX", affiliation: "xxx"),
    (name: "Mohammad Bahrami", email: "mbahrami@wolfram.com", affiliation: "Wolfram Research"),
  ),
  
  abstract: [We analyze qubit states in the symmetric informationally-complete measurements, where state vectors are represented as probability 4-vectors within a 3-simplex in $bb(R)^4$. Through appropriate geometric transformations, this 3-simplex is mapped onto a tetrahedron in $bb(R)^3$. A specific surface within this tetrahedron allows for the separation of probability vectors into two disjoint 1-simplices.//, corresponding to the most classical quantum states. 
  The intersection of this surface with the insphere identifies a "quantum potato chip" region, where probability 4-vectors reduce to two separable 2-vectors. Due to this unique feature, states within the potato chip can be reconstructed fully by using only two projective measurements, a feature unavailable for other points in the state space.],
  // keywords: ("First keyword", "Second keyword", "etc."),
  date: [#datetime.today().display()],
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

// #figure(
//   image("PotatoChip.png"),
//   caption: [@chipPlot3D[Potato chip]],
//   numbering: none
// )

#columns(1)[

= Introduction

A qubit in a normalized quantum state can be expressed in the basis ${bb(I), sigma_x, sigma_y, sigma_z}$ as a 4-vector $1/2{1, r_x, r_y, r_z}$, with $r_(x,y,z) in bb(R)$. The condition $abs(arrow(r))<=1$ ensures that the density matrix is positive semi-definite, corresponding to a _physical_ state. Since the first component of the 4-vector is fixed, the state can be fully described by the Bloch vector $arrow(r) = {r_x, r_y, r_z}$ in $bb(R)^3$. Alternatively, in an appropriate basis, the qubit state can be represented as a probability 4-vector ${ p_1, p_2, p_3, p_4 }$ with $sum_i p_i = 1$ and $p_i >= 0$, known as the probability phase-space representation. Symmetric Informationally Complete Positive Operator-Valued Measures (SIC-POVMs) are optimal for such representations due to their symmetry and informational completeness
//#####
//Consider a qubit in a generic normalized state#footnote[In this paper, we will focus only on quantum theory in the discrete vector space.]. In the basis ${ bb(I) , sigma_x , sigma_y , sigma_z }$, the qubit state is described by the 4-vector $1 / 2 { 1 , r_x , r_y , r_z }$ with $r_(x , y , z) in bb(R)$. The condition $abs(arrow(r)) <= 1$ guarantees that the state can be a _physical_ state (i.e., the density matrix is positive semi-definite). Since the first element of the 4-vector is 1/2, one can drop it, and thus the quantum state can be described in $bb(R)^3$ by the Bloch vector $arrow(r)={r_x,r_y,r_z}$, given the mentioned basis. Alternatively, in a proper basis, a qubit state (i.e. the state vector) can be represented by a _probability_ 4-vector as ${ p_1 , p_2 , p_3 , p_4 }$ with $sum_i p_i = 1$ and $p_i gt.eq 0$. This is what we refer to as the probability phase-space representation, where quantum state (or any quantum process such as operator, measurement or channel) can be represented by probability vectors. In this regard, Symmetric Informationally Complete Positive Operator-Valued Measures (SIC-POVMs) are ideal choice due to their symmetry and optimality 
@renes2004symmetric @saraceno2017phase @fuchs2017sic @appleby2017introducing @scott2010symmetric @appleby2014symmetric.
//########
//#bib(<renes2004symmetric>, [[1-4]]). 
// @tab:quantum_povm illustrates the probability phase-space representation of various quantum states using the Tetrahedron SIC-POVM #footnote[Tetrahedron SIC-POVM elements are given by
// ${{1 / 2, 0},{ 0, 0}}$,
// ${{ 1 / 6, frac(i - √3, √2 (3 i + 3 √3))},{- frac(i √2, 3 i + 3 √3), 1 / 3}}$, ${{ 1 / 6, frac(i + √3, √2 (3 i - 3 √3))},{ frac(i √2, 3 (- i + √3)), 1 / 3}}$,
// and ${{ 1 / 6, frac(1, 3 √2)},{ frac(1, 3 √2), 1/3}}$ and Bloch vectors of its projectors by $(0,0,1)$, $(-√2/3,-√(2/3),-1/3)$, $(-√2/3,√(2/3),-1/3)$, and $((2√2)/3,0,-1/3)$, respectively.]. 
That said, the phase-space representation historically were connected with some bases such as Wigner, Wootters or Gell-Mann @gell-mann where one needs _quasi_-probability treatment (i.e. $sum_i p_i = 1$ but $p_i$ can be negative). In this paper, we will focus more on POVMs, though we will discuss quasi-probability case, too.

For a qubit state in a SIC-POVM, the probability vector is confined within a simplex embedded in $bb(R)^4$ space. Through appropriate geometric transformations, this 4D object can be projected onto a tetrahedron in $bb(R)^3$ (see @fig:rotation). There are two important questions in order. From probability theory perspective, among all the points in the tetrahedron, which ones can be reduced to a disjoint pair of 1-simplices (two line segments), representing a separable probability distribution? And from a quantum theory perspective, what points in the tetrahedron corresponds to _physical_ quantum states? With answers to these questions in hand, we will be able to find quantum states that are most minimal, or alternatively, most classical (since they correspond to two disjoint probability distributions). This is the core idea of quantum potato chips that we will discuss in this paper.

#subpar.grid(
  figure(image("images/Rotate2D.png"), caption: [$2D arrow 1D$]),
  figure(image("images/Rotate3D.png", width: 90%), caption: [$3D arrow 2D$]),
  figure(image("images/Rotate4D.png", width: 90%), caption: [$4D arrow 3D$]),
  columns: (1fr, 1fr, 1fr),
  align: bottom,
  caption: [@code:rotation[Simplex projection to its lower dimension by rotation.]],
  label: <fig:rotation>
)

#[
#set text(9.5pt)
#show math.equation: set text(size: 8pt)
#figure(table(
    columns: 4,
    align: (center,center,center,center),

    table.header([#strong[Quantum State];], [#strong[Tetrahedron ($cal(T)$)];],[#strong[Rotated $cal(T)$];], [#strong[Bloch sphere];]
    ),
    
    table.hline(),
  
    $ket(0)$, ${1/2, 1/6, 1/6, 1/6}$, ${1/2, - 1/6, -1/6, -1/6}$, table.cell(rowspan: 6)[#image("images/tetrahedron.png",width:55%)],
    
    $ket(1)$, ${0, 1/3, 1/3, 1/3}$, ${1/2, 1/6, 1/6, 1/6}$,
    
    $ket(+)=1/√2(ket(0) + ket(1))$, ${1/4, 1/12 (3-√2), 1/12 (3-√2), 1/12 (3+2√2)}$, ${1/2, - 1/(6√2), - 1/(6√2), 1/(3√2)}$,
    
    $ket(-)=1/√2(ket(0) - ket(1))$, ${1/4, 1/12 (3+√2), 1/12 (3+√2), 1/12 (3-2 √2)}$, ${1/2, 1/(6√2), 1/(6√2) , -1/(3√2)}$,
    
    $ket(R)=1/√2(ket(0) + i ket(1))$, ${1/4, 1/12 (3-√6), 1/12 (3+√6), 1/4}$, ${1/2, -1/(2√6), 1/(2√6), 0}$,
    
    $ket(L)=1/√2(ket(0) - i ket(1))$, ${1/4, 1/12 (3+√6), 1/12 (3-√6), 1/4}$, ${1/2, 1/(2√6), -1/(2√6), 0}$
  ),
  caption: [Quantum states and their corresponding probability vectors in the tetrahedron SIC-POVM, the transformed tetrahedron probability vectors, and Bloch sphere representations. The transformation is described by @eq:transformation.]
) <tab:quantum_povm>
]

= Generating Quantum Potato Chips
<generating-quantum-potato-chip>
== SIC-POVM Case
In an Informationally-Complete POVM (IC-POVM), a qubit state is fully described by a probability $4$-vector ${p_1,p_2,p_3,p_4}$ with $sum_i p_i=1$ and $p_i>=0$. The space of probability vectors is the unit standard simplex in $bb(R)^4$, spanned by points ${1, 0, 0, 0}$, ${0, 1, 0, 0}$, ${0, 0, 1, 0}$, and ${0, 0, 0, 1}$. This is a region with the embedding dimension 4 and the geometric dimension 3. Therefore, one can reduce the embedding dimension to 3. Consider the following rotation matrix:
$
  U_(upright("rot")) =1/6 
  mat(delim: "[", 3, 3, 3, 3; - 3, 5, - 1, - 1; - 3, - 1, 5, - 1; - 3, - 1, - 1, 5), 
$<eq:transformation>


// #float(
// [
//   $
//   U_(upright("rot")) = 
//   { {1 / 2, 1 / 2, 1 / 2, 1 / 2},{- 1 / 2, 5 / 6, - 1 / 6, - 1 / 6},{ - 1 / 2, - 1 / 6, 5 / 6, - 1 / 6},{ - 1 / 2, - 1 / 6, - 1 / 6, 5 / 6}}, 
//   $<eq:transformation>
// ]
// )
which represents the rotation about the origin that transforms the vector ${ 1 , 1 , 1 , 1 }$ to the direction of the vector ${ 1 , 0 , 0 , 0 }$. @eq:transformation transforms the original simplex into a new one spanned by ${1/2, -1/2, -1/2, -1/2}$, ${1/2, 5/6, -1/6, -1/6}$, ${1/2, -1/6, 5/6, -1/6}$, and ${1/2, -1/6, -1/6, 5/6}$. With all first elements as $1/2$, the transformed simplex can be projected into $bb(R)^3$ space, as a tetrahedron spanned by ${-1/2, -1/2, -1/2}$, ${5/6, -1/6, -1/6}$, ${-1/6, 5/6, -1/6}$, and ${-1/6, -1/6, 5/6}$. We investigate what region of this simplex (i.e. tetrahedron) can be reduced to lower dimensional $1$-simplex, implying the original probability $4$-vector can be written as product of two disjoint probability vectors in lower dimensions.

Take a $1$-simplex spanned by points ${1, 0}$ and ${0, 1}$ (@fig:1-simplex). Any point sampled from this simplex have the form ${ p , 1 - p }$ with $0 <= p <= 1$. Consider two points randomly sampled from this $1$-simplex: ${ p , 1 - p }$ and ${ q , 1 - q }$. Their Kronecker product after flattening will be given by:
$ { p q , p (1 - q) , q (1 - p) , (1 - p) (1 - q) }. $<eq:kp-vector> 
@eq:transformation transforms @eq:kp-vector into:
$
{1/2,-1/6+p-(4p q)/3,-1/6+q-(4p q)/3,5/6-p-q+(2p q)/3}.
$
After dropping the first element, one gets:

$
{-1/6+p-(4p q)/3,-1/6+q-(4p q)/3,5/6-p-q+(2p q)/3}
$ <eq:chip1>

@eq:chip1 corresponds to a three-dimensional surface parameterized by
variables $0 lt.eq p , q lt.eq 1$. This surface is fully contained within the tetrahedron of probability space, as shown @fig:surface. Not all of the points within the tetrahedron correspond to _physical_ quantum states (i.e. states with a positive semi-definite density matrix). The only region of this tetrahedron that corresponds to physical quantum state is the sphere that is inscribed within it#footnote[The insphere, centered at the origin ${0,0,0}$, has a radius $1/(2sqrt(3))$. This radius is not unity because, for instance, a normalized vector such as ${1,0,0,0}$ transforms into the vector ${1/2, -1/2, -1/2, -1/2}$, which, after dropping the first component, becomes ${-1/2, -1/2, -1/2}$. To maintain normalization, this vector must be rescaled by a factor of $2sqrt(3)$. After rescaling, the resulting sphere has radius 1, analogous to the Bloch sphere.]. 



//This constraint is the same as saying the norm of probability vector cannot be larger than $1/(2 √3)$ (similar to the condition on norm of Bloch vector). 
The intersection of the insphere and the surface in @eq:chip1, is what we called as _quantum potato chip_. The border of the quantum potato chip, as highlighted in @fig:surface by the solid red line, is described by:
$ q=1/2(1 plus.minus √((-1 + 6p - 6p^2) / (3(1 - 2p + 2p^2)))). $<eq:constraint>

Therefore, the quantum potato chip is a surface described in @eq:chip1 and parameterized by $p,q$ as follow:
//#float([
$ 0<=p<=1, space space
1/2(1 - √((-1 + 6p - 6p^2) / (3(1 - 2p + 2p^2)))) <= q <= 1/2(1 - √((-1 + 6p - 6p^2) / (3(1 - 2p + 2p^2)))). $<eq:surface>]
//)

Additionally, the original $1$-simplex in @fig:surface is in fact a 1D object embedded in 3D, spanned by points ${{1, 0,0}, {0,1,0}}$. There are two other choices for points as ${{1, 0,0}, {0,0,1}}$, and ${{0,1,0}, {0,0,1}}$. Therefore, overall there are three potato chips, as shown in @fig:3-chips, and their surfaces are described by @eq:chip1 and @3-chips, with $p,q$ parametrized in @eq:surface.

$ {-1/6 + q - (4 p q)/3, 
 1/6 (5 - 6 q + p (-6 + 4 q)), -1/6 + p - (4 p q)/3},\
 {-1/6 + q - 1/3 p (1 + 2 q), 1/6 (-1 + p (-2 + 8 q)), 
 1/6 (5 + 8 p (-1 + q) - 6 q)} $ <3-chips>


#subpar.grid(
  figure(image("images/1-simplex.png",width:80%), caption: [@code:1-simplex[$1$-simplex as lowest dimensional probability space]]), <fig:1-simplex>,
  figure(image("images/surface.png",width:100%), caption: [@code:surface[Intersection of tetrahedron and surface of two $1$-simplex probability spaces]]), <fig:surface>,
  figure(image("images/3-chips.png",width:80%), caption: [@code:3-chips[Three quantum potato chips]]), <fig:3-chips>,
  columns: (1fr, 1fr,1fr),
  caption: [
    (a) a 1-simplex spanned by points ${ { 1 , 0 } , { 0 , 1 } }$. Any
    point sampled from this simplex will have the form ${ p , 1 - p }$
    with $0 <= p <= 1$. //Since the geometric dimension of this 1-simplex is 1, although it is embedded in 2D, one can project it onto a 1D segment along x-axis by the geometric matrix $mat(delim: "(", 1 / 2, - 1 / 2, 1 / 2; 1 / √2, 1 / √2, - 1 / √2; 0, 0, 1)$, which is a composition of rotation, scaling and translation.
    (b) the blue solid line represents 1-simplex in
    @fig:1-simplex. The surface is described in @eq:chip1,
    which is fully contained within the 3-simplex (that is a tetrahedron). The solid red line is the intersection of the surface and the tetrahedron's insphere. The points inside the insphere are the only points of the tetrahedron that correspond to physical quantum states. 
    // If axes are denoted by ${x,y,z}$, the corresponding probability vector ${p_1,p_2,p_3,1-(p_1+p_2+p_3)}$ is connected with ${x,y,z}$ by ${p_1 arrow 1/4 (1 - 2(x+y+ z)), p_2 arrow 1/6 (3/2 + 5 x - y - z), p_3 arrow 1/6 (3/2 - x + 5 y - z)}$
    (c) three quantum potato chips are defined in @eq:chip1 and @3-chips, and parametrized by @eq:surface,
],
  label: <fig:main-simplex>,
)


== Bloch Sphere
Consider the following SIC-POVM for qubits#footnote[Any other SIC-POVM for qubits, such as the Tetrahedral SIC-POVM in @tab:quantum_povm, is simply a rotational transformation of this QBism SIC-POVM.] (usually called as the QBism SIC-POVM), with POVM elements as follows:
#[
#set text(9.5pt)
$
cal(Q)_1=mat(
  (3 + √3)/12, (1 + i )/(4sqrt(3));
  (1 - i )/(4sqrt(3)), (3 - √3)/12), space
cal(Q)_2=mat(
  (3 + √3)/12, -(1 + i )/(4sqrt(3));
  -(1 - i )/(4sqrt(3)), (3 - √3)/12), space
cal(Q)_3=mat(
  (3 - √3)/12, (1 - i )/(4sqrt(3));
  (1 + i )/(4sqrt(3)), (3 + √3)/12), space
cal(Q)_4=mat(
  (3 - √3)/12, -(1 - i )/(4sqrt(3));
     -(1 + i )/(4sqrt(3)), (3 + √3)/12),
$ <eq:povm>]
where $sum_i cal(Q)_i=bb(I)$ and $Q_i>=0$.
These POVM elements correspond to the following Bloch vectors, respectively: ${1/(2√3), -1/(2√3), 1/(2√3)}$, ${-1/(2√3), 1/(2√3), 1/(2√3)}$, ${1/(2√3), 1/(2√3), -1/(2√3)}$, ${-1/(2√3), -1/(2√3), -1/(2√3)}$ (see @fig:basis-vs-povm and @fig:chip-in-bloch). Likewise, the corresponding phase-space basis matrix for this SIC-POVM is given by:
$
cal(B)=
{mat((1 + sqrt(3))/2;
      e^(i pi/4)sqrt(3/2);
      e^(-i pi/4)sqrt(3/2);
      (1 - sqrt(3))/2),
mat((1 + sqrt(3))/2;
      -e^(i pi/4)sqrt(3/2);
      -e^(-i pi/4)sqrt(3/2);
      (1 - sqrt(3))/2),
mat((1 - sqrt(3))/2;
      e^(-i pi/4)sqrt(3/2);
      e^(i pi/4)sqrt(3/2);
      (1 + sqrt(3))/2),
mat((1 - sqrt(3))/2;
      -e^(-i pi/4)sqrt(3/2);
      -e^(i pi/4)sqrt(3/2);
      (1 + sqrt(3))/2),
}.
$<eq:qbism>


For a probability vector $arrow(p)={p_1,p_2,p_3,1-(p_1+p_2+p_3)}$ in the basis of @eq:qbism, the vectorized density matrix is given by:
  $
arrow(rho) =& cal(B).arrow(p) = 
mat(
     √3(p_1+p_2)+(1-√3)/2; 
     e^(-i pi/4)sqrt(3/2)((1+i)p_1+(1-i)p_2+2p_3-1);
    e^(i pi/4)sqrt(3/2)((1-i)p_1+(1+i)p_2+2p_3-1); 
    -√3(p_1+p_2)+(√3+1)/2;
  ),
$<eq:density-phase-space>

whose eigenvalues are:
$ 1/2 (1 plus.minus sqrt(3) sqrt(8 (p_1^2+p_1 (p_2+p_3-1)+p_2^2+p_2 p_3+p_3^2)-8 p_2-8 p_3+3)).
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

The previous geometric description of potato chips can be applied directly into the Bloch sphere. Define a qubit state by the probability vector in @eq:kp-vector in the QBism SIC-POVM. Find the state in the Hilbert space using Weyl–Wigner transformation. Set one of the eigenvalue of the density matrix as zero and solve for $q$. The result will be the same as @eq:constraint. Replacing this condition into the Bloch vector, one gets:
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
    (a) SIC-POVM basis ($cal(B)_i$, blue) vs POVM elements ($cal(Q)_i$, green), represented in the Bloch sphere. Note the $cal(B)_i$ tetrahedron represents the available phase-space, spanned by basis, while the POVM elements are within the insphere.
    (b) quantum potato chip in the Bloch sphere. The green spheres are Bloch vectors for the QBism SIC-POVM in @eq:qbism.
    (c) the solid red line is the boundary of quantum potato chip, while sphere represents new POVM defined in @eq:3new-M.
  ],
  label:<fig:3-M>,
)

= Why Quantum Potato Chips Are Most-Classical States?
We investigate the properties of quantum states within the "quantum potato chip", which we argue is the most classical among quantum states represented on the Bloch sphere. To support this claim, we present two complementary arguments. First, we demonstrate that the Matthews correlation measure vanishes exclusively for the quantum potato chip state, signifying its classical nature. Second, we show that states lying on the quantum potato chip can be generated solely through projective measurements in the Pauli-X and Pauli-Z bases, further reinforcing its status as a minimal (or call it most-classical) quantum states.

== Matthews correlation as a measure for classicality
To quantify the classicality of the quantum potato chip compared to other points in the Bloch sphere, one can use Matthews correlation coefficient. Given binary variable defining the probability vector as
$
arrow(p) = {p_1,p_2,p_3,p_4} = mat(p_11, p_12; p_21, p_22),
$ <prob_vector>
the corresponding Matthews correlation coefficient is given by:
//#float[
  $
phi = (p_22 p_11 - p_12 p_21) / sqrt((p_11 + p_12)(p_21+p_22)(p_11+p_21)(p_12+p_22)) = (sqrt(3)y-x z)/(sqrt((x^2-3)(z^2-3))),
$ <matthews>
//]
where in the last step, we replace variables by the Bloch vector components ${x,y,z}$ using @eq:inverse-replacement-rule. As shown in @fig:matthew, the only region with $phi=0$ is the quantum potato chip. This means that measurement predictions in @prob_vector, which can be obtained experimentally by measuring POVMs, are uncorrelated, much like flipping a fair coin (probabilities are evenly split as described by @eq:kp-vector).

#subpar.grid(
  columns: (1fr, 1fr),
  figure(image("images/PhiContours.png",width: 75%)), <fig:PhiContours>,

  figure(image("images/PhiContours-2.png", width: 55%)),
  <fig:PhiContours-2>,

  caption: [@PhiContours[Matthews correlation coefficient @matthews for the pair of binary variables forming the probability vector @prob_vector. $phi$ has minimum $-1/sqrt(3)$ and maximum $1/sqrt(3)$ at the poles of the sphere]],
  label:<fig:matthew>
)


== Construction of Quantum State by Projective Measurements
=== SIC-POVM case
A qubit state can be reconstructed from SIC-POVM probabilities, because they are informationally complete (IC). However, qubit states cannot be recovered from only two independent projective measurements. We will show that for quantum states within potato chips, it is doable, and thus we refer to quantum potato chips as the most-classical states, because their probability space can be reduced into two disjoin separable ones.

Given QBism POVM, define three new POVM sets as follows:
$cal(M)_1: {Q_1+Q_3,bb(I)-(Q_1+Q_3)}$,
$cal(M)_2: {Q_1+Q_4,bb(I)-(Q_1+Q_4)}$, and 
$cal(M)_3: {Q_1+Q_2,bb(I)-(Q_1+Q_2)}$. They correspond to measurements along these Bloch vectors:
$
cal(M)_1:{
  mat(1/√3; 0; 0), 
  mat(-1/√3; 0; 0;)
  }, space
cal(M)_2:{
  mat(0; 1/√3; 0), 
  mat(0; -1/√3; 0;)
  }, space
cal(M)_3:{
  mat(0; 0; 1/√3), 
  mat(0; 0; -1/√3;)
  },
$<eq:3new-M>
This feature is also visualized in @fig:new-measurements, as one can see the vectors corresponding to $cal(M)_i$ are along the Cartesian axes (i.e. the same direction for Pauli matrices), but only shrunken.

For a qubit state defined by the probability vector of @eq:kp-vector in the SIC-POVM basis of @eq:qbism, the measurement probabilities for $cal(M)_1$ is ${q,1-q}$ and for $cal(M)_3$ is ${p,1-p}$. Additionally, $cal(M)_1$, $cal(M)_2$ and $cal(M)_3$ can be treated as shrunk version of projective measurements of Pauli operators $sigma_x$, $sigma_y$ and $sigma_z$, respectively. For a generic state such as $1 / 2 (bb(I) + arrow(r) . arrow(sigma))$, the Pauli-Z probabilities are ${1/2(1-r_z),1/2(1+r_z)}$, while for $cal(M)_3$ the probabilities are ${1/6 (3 - √(3) r_z), 1/6 (3 + √(3) r_z)}$; likewise for Pauli-X, one gets ${1/2(1-r_x),1/2(1+r_x)}$ while those of $cal(M)_1$ are ${1/6 (3 - √(3) r_x), 1/6 (3 + √(3) r_x)}$. In other words, given any projective measurement for Pauli matrices, if their probabilities is denoted by $p$, the corresponding $cal(M)_i$ probabilities will be given by 
$p -> 1/√(3)(p-1/2)+1/2$.
Shrinking can also be expressed with the following doubly-stochastic matrix:

$
cal(S)&=1/√3bb(I)+(1-1/√3)1/2
&=1/6mat(3+√3,3-√3;;3-√3,3+√3).
$

such that

$
p -> cal(S)p.
$<eq:stoch-shrink>


Therefore, for any state within quantum potato chips, one can perform Pauli-X and Pauli-Z projective measurements and record corresponding probabilities. By transforming these probabilities using @eq:stoch-shrink, one recovers $p$ and $q$, and thus reconstructing the probability vector in @eq:kp-vector; meaning constructing the quantum state, fully. One should notice that this process is doable only for quantum potato chip and no other states. 

Given the state vector from @eq:kp-vector with parameters $p = 0.3$ and $q = 0.5$, the QBism SIC-POVM probabilities are ${0.2, 0.1, 0.466667, 0.233333}$. For measurements $cal(M)_3$ and $cal(M)_1$, the probabilities are ${0.3, 0.7}$ and ${0.666667, 0.333333}$, respectively. The Kronecker product of these results matches ${0.2, 0.1, 0.466667, 0.233333$}. Similarly, for Pauli-Z and Pauli-X projective measurements, the probabilities are ${0.15359, 0.84641}$ and ${0.788675, 0.211325$}, respectively. After applying the transformation from @eq:stoch-shrink, their Kronecker product also yields ${0.2, 0.1, 0.466667, 0.233333}$.

This factorization allows us to decouple the probability 4-vector in a 3-simplex into two lower-dimensional disjoint distributions in 1-simplices. Consequently, the probability space for quantum potato chip can be viewed as the product of two independent subspaces, each governed by their respective probability distributions. 
//This construction reflects the disjoint nature of the probability distributions for quantum potato chip, and highlights the independence between the two subspaces. 
In practical terms, the system exhibits a decoupling of correlations between the disjoint subspaces, which simplifies the analysis and allows us to treat each subspace independently. 

== Quasi-Probability Bases
Historically, the phase-space representation of quantum states, such those in bases of Wootters @Wootters1986-cq and Feynman @Feynman1987-vj, involves quasi-probability distributions. These representations allow for the treatment of quantum states in a manner similar to classical statistical distributions, but with key distinctions, such as the possibility of negative values. For example, Wootters basis is given by:
$
cal(W)={
  vec(1, e^(-i pi/4)/sqrt(2), e^(i pi/4)/sqrt(2), 0),
  vec(0, e^(i pi/4)/sqrt(2), e^(-i pi/4)/sqrt(2), 1),
  vec(1, -e^(-i pi/4)/sqrt(2), -e^(i pi/4)/sqrt(2), 0),
  vec(0, e^(i pi/4)/sqrt(2), -e^(-i pi/4)/sqrt(2), 1)
}.
$ <eq:wootters-basis>


In Wootters basis, a quantum state with a Bloch vector ${x,y,z}$ is described by:
$ mat(
1/4 (1 + x + y + z), 1/4 (1 + x - y - z); 1/4 (1 - x - y + z), 
 1/4 (1 - x + y - z)
).
$
The summation of elements along a column results in $1/2(1+z)$ and $1/2(1-z)$, which represent the probabilities associated with projective measurements along the Pauli-Z axis. Similarly, summing the elements along a row yields $1/2(1+x)$ and $1/2(1-x)$, which correspond to the probabilities of measurements along the Pauli-X axis. These probabilities can be interpreted as outcomes for position (Pauli-Z) and momentum (Pauli-X) measurements within the phase space.

This phase-space basis is a shrunken version of the SIC-POVM basis as the new probability vector in this basis would no longer be a proper distribution, but a quasi-distribution with its entries outside $[0,1]$ interval. It is usually referred to as _quasi_-distribution. This provides a new insight into quantum potato chips because states within chips correspond to the subset of quasi-distributions with all entries being positive.

#subpar.grid(
  figure(
    image("images/ClassicalStates.png",width: 90%),
    caption: [@Wootters-tetra[Tetrahedron of Wootters basis.]]
  ),<fig:ClassicalStates>,
  
  figure(image("images/ClassicalStatesRegion.png",width: 90%), caption:[@Wootters-potato[Positive probability region of Wootters phase-pace]]),
  <fig:ClassicalStatesRegion>,
  
  figure(
    image("images/Matreshka.png",width: 120%), caption: [@Matreshka[Tetrahedron of different bases]]),<fig:matreshka>,

  columns: (1fr, 1fr, 1fr),
  caption: [
    (a) the tetrahedron represents points in the phase-space of Wootters basis that corresponds to only positive probabilities. Note the Bloch sphere is not inscribed within the tetrahedron and not all points within the tetrahedron represents quantum states. Pauli-Z eigenstates are $ket(arrow.t), ket(arrow.b)$ and X are $ket(arrow.l), ket(arrow.r)$.

    (b) Potato chip represents the states with independent observables, but represented in the Wootters basis. Its boundary is the solid black line. The region inside the Bloch sphere is the intersection of the Wootters tetrahedron and Bloch sphere, that corresponds to quantum states and also represented by positive probability vectors#footnote[Refer to Fig.4 in @appleby2011properties, which has a similar visualization, in a slightly different context.] 
    (c) The correspondence between the probabilistic phase-space basis, quasi-probabilistic Feynman basis @Feynman1987-vj and SIC-POVM projectors. Each tetrahedron is a scaled down version of the previous one by a factor of $sqrt(3)$.
    
  ],
  label: <fig:3-MM>,
)

Quasi feature of probabilities has some geometric consequences. If one considers only positive (say, classical) probabilities, the corresponding tetrahedral does not contains the Bloch sphere (see @fig:3-MM). In other words, parts of Bloch sphere outside of the tetrahedron corresponding to cases with negative probabilities in this basis. Additionally, the parametrization of the quantum potato chip will be different compared to @eq:constraint: 
$ q=1/2(1 plus.minus √(((1-p)p) / (2(1 - 2p + 2p^2)))). $<eq:constraint-Wootters>

A similar factorization argument for the probability vectors of the quantum potato chip can be applied in this context. However, it is crucial to note that, unlike the SIC-POVM case, the probabilities here do not necessarily correspond to directly measurable quantities, as they may take on negative values. 

// #figure(image("Matreshka.png",width: 60%), caption: [@Matreshka[The correspondence between the probabilistic phase-space basis, quasi-probabilistic Feynman basis @Feynman1987-vj and SIC-POVM projectors. Each tetrahedron is a scaled down version of the previous one by a factor of $sqrt(3)$]])<fig:matreshka>


= Unconventional Liouvillian Evolution at the Boundary of Quantum Potato Chip

A natural question arises: Can the boundary of the chip be understood as the result of state evolution under a master equation, starting from an appropriate initial condition?

Given that the trajectory of each individual probability vector $P = {p, 1-p}$ and $Q = {q, 1-q}$ is already known, constrained by @eq:constraint, and thus its parametric equation, the single parameter $p$ can now be interpreted as a time variable. Consequently, we can identify two time (or parameter)-dependent transition matrices that generate the desired trajectory.

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
#[
#set math.equation(numbering: (..n) => {
  [#text(numbering("(1)", ..n))@Liovillian[#super($dagger$)]]
})
#set text(size: 9.5pt)
//#float[
$
cal(L) = mat(delim: "(", frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)), frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)), frac(1, 1 - 2 p), 0; frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)), frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)), 0, frac(1, 1 - 2 p); frac(1, 1 - 2 p), 0, frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)), frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)); 0, frac(1, 1 - 2 p), frac(1 - 2 p, 4 (p - 1) p (2 (p - 1) p + 1)), frac(8 (p - 1) p ((p - 1) p + 1) + 1, 4 (p - 1) p (2 p - 1) (2 (p - 1) p + 1)))
$ <eq:Liovillian>
//]
]

In the Hilbert space the master equation corresponding to the above transition can be expressed with two Lindblad jump operators:

$
L_1 = mat(2/sqrt(1-2p),0;0,0),
space space
L_2 = 1/2sqrt((1-2p)/(p(1-p)(1-2p(1-p)))) space sigma_x
$

But with unconventional (negative) opposite damping rates $gamma_1=-gamma_2=1$.

$
dot(rho)=(L_1 rho L_1^dagger-1/2{L_1^dagger L_1, rho})-
(L_2 rho L_2^dagger-1/2{L_2^dagger L_2, rho})
$
While this specific evolution may lack an immediate physical interpretation, it is significant that, starting from any point on the boundary of the quantum chip, this evolution guarantees that the quantum state remains confined to the boundary for the entire duration of the process.

= Concluding remarks
// SIC-POVMs provide a natural way of describing quantum objects in the phase space. In this regard, a qubit state can be described by a probability $4$-vector in a $3$-simplex space. With proper geometric transformation, $3$-simplex can be projected into a tetrahedron in $bb(R)^3$. Quantum states are inside the insphere of the tetrahedron, meaning not all points within the tetrahedron corresponds a quantum state. Independently, a particular surface within the tetrahedron can be constructed by product of two independent $1$-simplex as probability space, providing the most minimal (say classical) description of quantum states. The part of aforementioned surface within the insphere forms a region we call as a quantum potato chip, which is the only part of the tetrahedron probability space that can be reduced to lower-dimensional probability space. This unique feature might provide advantage for these states as potential source for any computation. Of course, an important open question would be how any [universal] quantum computation can be reduced to only probabilistic rules, in a classical way, if possible and what new features should be incorporated into this machinary, to reproduce quantum results. This is a topics of our future research.

SIC-POVMs offer an elegant framework for representing qubit states geometrically, using a 4-dimensional probability vector within a 3-simplex. Through geometric transformations, this simplex can be projected into a tetrahedron $bb(R)^3$. Crucially, not all points in this tetrahedron represent valid quantum states, with quantum states residing within the insphere of the tetrahedron. A specific surface within this space, defined by the product of two 1-simplices, represents the most classical (minimal) description of quantum states. The region where this surface intersects the insphere forms the "quantum potato chip," a subset that can be reduced to a lower-dimensional probability space. This reduction suggests potential computational advantages for these states, though an important open question remains: how can universal quantum computation be fully described using purely probabilistic (classical) rules? Exploring this question and the necessary modifications to quantum machinery forms the basis of our future research. The geometric structure of SIC-POVMs suggests that understanding these spaces could unlock new pathways in quantum computing and quantum state representation.

// columns

#set heading(numbering: none)

= Acknowledgement
Computational aspects of this paper (e.g., mathematical derivation of formulas and visualizations) were done in the version 14.0 of the Wolfram Language. We also extensively used the Wolfram quantum framework, which a library of functionalities to perform symbolic and numeric quantum computation in the discrete finite-dimensional vector space. 

#pagebreak()
// add style to handle multireference cite
#bibliography("references.bib", full: true)

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
GraphicsRow[{ListLinePlot[{{{0, 1}, {1, 0}}, 
    RotationTransform[{{1, 1}, {0, 1}}]@{{0, 1}, {1, 0}}}, 
   Mesh -> All, Ticks -> None, PlotRange -> {{-1, 1}, {0, 1}}, 
   AspectRatio -> 1/2, AxesLabel -> {"X", "Y"}], 
  Framed["\!\(\*OverscriptBox[\(\[LongRightArrow]\), SubscriptBox[\(U\
\), \(rot\)]]\)", FrameStyle -> None], 
  NumberLinePlot[Interval[{0, 1}], PlotStyle -> ColorData[97][2]]}]

GraphicsRow@{Graphics3D[{Simplex[IdentityMatrix[3]], 
    TranslationTransform[{0, 0, -1/Sqrt[3]}]@
     RotationTransform[{ConstantArray[1, 3], UnitVector[3, 3]}]@
      Simplex[IdentityMatrix[3]]}, Axes -> True, 
   AxesLabel -> {"X", "Y", "Z"}, Ticks -> None, 
   ViewPoint -> {3, -1, 1}],
  Framed[
   "\!\(\*OverscriptBox[\(\[LongRightArrow]\), SubscriptBox[\(U\), \
\(rot\)]]\)", FrameStyle -> None], 
  TernaryListPlot[{}, Method -> {"Backdrop" -> LightOrange}]
  }

GraphicsRow[{Style[MatrixForm@IdentityMatrix[4], 30], 
  Framed["\!\(\*OverscriptBox[\(\[LongRightArrow]\), SubscriptBox[\(U\
\), \(rot\)]]\)", FrameStyle -> None], 
  Graphics3D[{Opacity[.5], 
    Simplex@RotationTransform[{ConstantArray[1, 4], 
         UnitVector[4, 1]}][IdentityMatrix[4]][[All, 2 ;;]]}, 
   Boxed -> False, 
   Epilog -> {(*AxisObject[Line[{{0.23,.83},{.77,0.15}}],{0,1},
     TickDirection\[Rule]"Inward"],*)
     AxisObject[Line[{{.03, 0.15}, {0.23, .83}}], {0, 1}, 
      TickDirection -> "Inward", TickLengths -> 0],
     AxisObject[Line[{{.77, 0.15}, {.03, 0.15}}], {0, 1}, 
      TickDirection -> "Inward", TickLengths -> 0],
     AxisObject[Line[{{.03, 0.15}, {.6, 0.67}}], {0, 1}, 
      TickLabels -> None, TickLengths -> 0]
     }]
  }]
}]
```

= @fig:1-simplex <code:1-simplex> 
```WL
Graphics[{{Text[Style["{q,1-q}", 10], {.37, .83}], 
   Text[Style["{p,1-p}", 10], {.7, .45}]}, {ColorData[97][1], 
   Simplex[{{1, 0}, {0, 1}}]}, {Black, Point[{.25, .75}]}, {Red, 
   Point[{.65, .35}]}}, Axes -> True, AxesOrigin -> {0, 0}, 
 AxesLabel -> {"p", "1-p"}, PlotLabel -> "1-simplex", Frame -> True, 
 GridLines -> Automatic, 
 FrameTicks -> {{Automatic, None}, {Automatic, None}}]
``` 


= @fig:surface <code:surface>
```WL
v = FullSimplify@
   Rest@RotationTransform[{{1, 1, 1, 1}, {1, 0, 0, 0}}]@
     Flatten@KroneckerProduct[{p, 1 - p}, {q, 1 - q}];
boundary = Normal@Solve[Norm[2 Sqrt[3] v] == 1, q, Reals];
Show[Graphics3D[{{Opacity[.5], 
    Ball[{0, 0, 0}, 1/(2 Sqrt[3])]}, {ColorData[97][1], 
    Thickness[.005], Simplex[{{1, 0, 0}, {0, 1, 0}}]}}, Axes -> True, 
  AxesOrigin -> {0, 0, 0}, Boxed -> False], 
 ParametricPlot3D[v /. boundary, {p, 0, 1}, Mesh -> None, 
  PlotStyle -> Red],
 ParametricPlot3D[v, {p, 0, 1}, {q, 0, 1}, 
  PlotStyle -> {Opacity[
     0.6]}],(*AxesLabel->{"x","y","z"},*)(*AxesStyle\[Rule]{Red,Thick}\
,*)ImageSize -> 400]
```

= @fig:3-chips <code:3-chips>
```WL
ParametricPlot3D[
 Evaluate[
  FullSimplify@
     Rest@RotationTransform[{{1, 1, 1, 1}, {1, 0, 0, 0}}]@
       Permute[Flatten@KroneckerProduct[{p, 1 - p}, {q, 1 - q}], 
        PermutationCycles@#] & /@ {{1, 2, 3, 4}, {1, 4, 2, 3}, {3, 1, 
     2, 4}}], {p, 0, 1}, {q, 
  1/2 - Sqrt[(-1 + 6 p - 6 p^2)/(1 - 2 p + 2 p^2)]/(2 Sqrt[3]), 
  1/2 + Sqrt[(-1 + 6 p - 6 p^2)/(1 - 2 p + 2 p^2)]/(2 Sqrt[3])}, 
 Mesh -> None, PlotStyle -> Opacity[.5], PlotPoints -> 200, 
 Boxed -> False, Axes -> False, ImageSize -> 800]
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

= @eq:Liovillian <Liovillian>
```WL
P = {p, 1 - p};
Q = {q, 1 - q} /. q -> 1/2 - Sqrt[-(((-1 + p) p)/(2 - 4 p + 4 p^2))];
\[ScriptCapitalL]1 = {{x, -x}, {-x, x}} /. 
  Solve[Thread[{{x, -x}, {-x, x}} . P == D[P, p], x], x][[1]]
\[ScriptCapitalL]2 = {{y, -y}, {-y, y}} /. 
  Solve[Thread[{{y, -y}, {-y, y}} . Q == D[Q, p], y], y][[1]]
\[ScriptCapitalL] = 
 MatrixLog[
    KroneckerProduct[MatrixExp[\[ScriptCapitalL]1], 
     MatrixExp[\[ScriptCapitalL]2]]] // ComplexExpand // FullSimplify
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