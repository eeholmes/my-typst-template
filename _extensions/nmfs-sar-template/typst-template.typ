
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates


#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.22in, y: 1.2in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
   set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    header: align(right + horizon)[
      #set text(
        font: "Roboto",
        fill: rgb("#5EB6D9"))
      ALASKA FISHERIES SCIENCE CENTER],
    // Define the background for the first page
    background: context { if(counter(page).get().at(0)== 1) {
      align(left + top)[
      #image("assets/22Fisheries SEA_T1 CornerTall.png", width: 35%)
    ]}
} 
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize,
           fill: rgb("#323C46"))
  set heading(numbering: sectionnumbering)

  if title != none {
    [#grid(columns: (35%, 1fr))[][
      #text(weight: "regular", 
            size: 1.5em, 
            font: "Roboto",
            fill: rgb("#00559B"))[#title]
    ]]
  }

  line(length: 100%, stroke: rgb("#00559B"))
  
  v(2em)

  grid(
    columns: (75%,25%),
      if abstract != none { 
    block(fill: rgb("#F1F2F3"), inset: 1em)[
    #text(font: "Roboto", size: 1.1em)[#abstract-title \ ] #abstract
    ]
  },
    // Display the authors list.
  for i in range(calc.ceil(authors.len() / 3)) {
    let end = calc.min((i + 1) * 3, authors.len())
    let is-last = authors.len() == end
    let slice = authors.slice(i * 3, end)
    set align(right)
    grid(
      columns: 1,
      rows: slice.len(),
      row-gutter: 1em,
      ..slice.map(author => align(right, {
        text(font: "Roboto", weight: "semibold", author.name)
        if "email" in author [
          \ #text(font: "Roboto", size: 0.75em, author.email)
        ]
      }))
    )

    if not is-last {
      v(16pt, weak: true)
    }
  }
  )

  v(2em, weak: true)



  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)