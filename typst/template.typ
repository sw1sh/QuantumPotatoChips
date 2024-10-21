// based on https://typst.app/universe/package/arkheion
#let arxiv(
  title: "",
  abstract: [],
  keywords: (),
  authors: (),
  date: none,
  body,
) = {
  // Set the document's basic properties.
  set document(title: title, author: authors.flatten().map(a => a.name))
  set page(
    margin: {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    },
    numbering: "1",
    number-align: center
  )
  set text(font: "New Computer Modern", lang: "en", size: 11pt)

  show figure.caption: set text(size: 8pt)

  set math.equation(numbering: "(1)")
  show math.equation: eq => {
    if eq.block and eq.numbering != none {
      text(eq, size: 10pt)
    } else {
      eq
    }
  }
  
  set heading(numbering: "1.1")

  // Set run-in subheadings, starting at level 4.
  show heading: it => {
    // H1 and H2
    if it.level == 1 {
      pad(
        bottom: 10pt,
        it
      )
    }
    else if it.level == 2 {
      pad(
        bottom: 8pt,
        it
      )
    }
    else if it.level > 3 {
      text(11pt, weight: "bold", it.body + " ")
    } else {
      it
    }
  }

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      let isEq = str(it.target).starts-with("eq:")
      // Override equation references.
      link(el.location())[#if isEq [Eq.] else []#numbering(
        el.numbering,
        ..counter(eq).at(el.location())
      )]
    } else {
      // Other references as usual.
      it
    }
  }

  //line(length: 100%, stroke: 2pt)
  // Title row.
  pad(
    bottom: 4pt,
    top: 4pt,
    align(center)[
      #block(text(weight: 500, 1.75em, title))
      #v(1em, weak: true)
    ]
  )
  //line(length: 100%, stroke: 2pt)

  // Author information.
  pad(
    top: 1em,
    bottom: 1em,
    x: 3em,
    grid(
      rows: (3em,) * authors.len(),
      gutter: 3em,
      ..authors.map(row => 
        grid(
          columns: (1fr,) * row.len(),
          ..row.map(author => align(center)[
            #if author.keys().contains("orcid") {
              link("http://orcid.org/" + author.orcid)[
                #pad(bottom: -8pt,
                  grid(
                    columns: (8pt, auto, 8pt),
                    rows: 10pt,
                    [],
                    [*#author.name*],
                    [
                      #pad(left: 4pt, top: -4pt, image("orcid.svg", width: 8pt))
                    ]
                  )
                )
              ]
            } else {
              grid(
                columns: (auto),
                rows: 2pt,
                [*#author.name*],
              )
            }
            #author.email \
            #author.affiliation
          ]
        ),
        )
      )
    )
  )

  align(center)[#date]

  // Abstract.
  pad(
    x: 3em,
    top: 1em,
    bottom: 0.4em,
    align(center)[
      #heading(
        outlined: false,
        numbering: none,
        text(0.85em, smallcaps[Abstract]),
      )
      #set par(justify: true)
      #set text(hyphenate: false, 9pt, weight: 700)

      #abstract
    ],
  )

  // Keywords
  if keywords.len() > 0 {
      [*_Keywords_* #h(0.3cm)] + keywords.map(str).join(" · ")
  }
  // Main body.
  set par(justify: true, first-line-indent: 1em)

  [#body]
}

#let arxiv-appendices(body) = {
  
  counter(heading).update(0)
  counter("appendices").update(1)
  
  set heading(
    numbering: (..nums) => {
      let vals = nums.pos()
      let value = "ABCDEFGHIJ".at(vals.at(0) - 1)
      if vals.len() == 1 {
        return "APPENDIX " + value
      }
      else {
        return value + "." + nums.pos().slice(1).map(str).join(".")
      }
    }
  );
  body
}