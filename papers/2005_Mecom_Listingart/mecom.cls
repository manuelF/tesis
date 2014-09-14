%% 
%% This is file `wccm.cls' constructed by Ton van den Boogaard,
%% 
%% The regular article class commands still exist and may be used.
%% 10pt, 11pt and onecolumn options are disabled.
%%
%% Use the bibliography style `unsrt' (\bibliographystyle{unsrt})
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mecom}[2002/06/10 AMCA MECOM paper class]

\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

\LoadClass[12pt]{article}

\RequirePackage{calc}

%% Title

\renewcommand{\@maketitle}{%
  \newpage
  \null
  \vspace{3cm}%
  {\begin{center}%
     {\fontsize{14}{16}\selectfont \bfseries \MakeUppercase{\@title} \par}%
     \vspace{12pt}%
     {
        \lineskip .5em%
        {\setlength{\tabcolsep}{0in}
        \begin{tabular}[t]{c}%
          \bfseries \@author
        \end{tabular}\par} }%
  \end{center}}% end of \parbox
  } % end of \@maketitle

\renewenvironment{abstract}{%
      \noindent \bfseries Abstract.%
      \mdseries\itshape%
}{}

\renewenvironment{thebibliography}[1]
     {\section*{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \parsep 0pt
            \itemsep 0pt
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

\renewcommand{\thesubsection}   {\textup{\thesection.\arabic{subsection}}}
\renewcommand{\thesubsubsection}{\textup{\thesubsection .\arabic{subsubsection}}}

\renewcommand{\section}{\@startsection{section}{1}{0mm}%
                                     {-12pt}%
                                     {6pt}%
                                     {\bfseries\normalsize\MakeUppercase}}%
\renewcommand{\subsection}{\@startsection{subsection}{2}{0mm}%
                                     {-12pt}%
                                     {6pt}%
                                     {\bfseries\normalsize}}%

\setlength{\oddsidemargin}{0mm}
%\setlength{\evensidemargin}{0mm}
\setlength{\textheight}{210mm}
\setlength{\textwidth}{160mm}
\setlength{\textfloatsep}{12pt}
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\setlength{\parindent}{5mm}
\setlength{\abovecaptionskip}{6pt}
\setlength{\belowcaptionskip}{6pt}
%\setlength{\z@}{0pt}

\renewcommand{\@makecaption}[2]{%
  \vspace{\abovecaptionskip}%
  {\fontsize{10}{12}\selectfont
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi}
  \vskip\belowcaptionskip}

\def\dagged{\strut\raise 2pt\hbox{$\dag$}}
\def\stared{$^*$}

\pagestyle{empty}
