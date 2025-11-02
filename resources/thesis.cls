% thesis.cls
%
% Used for writing nice looking theses.
%
% 2017-May-24 Andrew Hills (a.hills (at) sheffield.ac.uk)

% Standard class structure
\ProvidesClass{thesis}[2025/04/19 version 0.2.5 Thesis class]
\NeedsTeXFormat{LaTeX2e}
\usepackage[utf8]{inputenc}    % Codifica dei caratteri

\DeclareUnicodeCharacter{200B}{} % fix per
% ! Package inputenc Error: Unicode char ​ (U+200B)
% (inputenc)                not set up for use with LaTeX.
% …
% l.56 ...ntnoidxglossary[type=main,title=Glossario]
\usepackage{etoolbox}
\usepackage{tikz}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{patterns}
\usetikzlibrary{babel}
\usetikzlibrary{positioning, shapes, arrows.meta, calc}
\usetikzlibrary{decorations.pathreplacing}
\usepackage{tikz-3dplot}
\usetikzlibrary{intersections,calc}


\tikzset{ % cancella se non ti serve, è un rimasuglio della mia tesi per gli stili dei miei grafici 
  timeline/.style={-Latex, thick},
  tick/.style={thin},
  nodelab/.style={font=\footnotesize, anchor=north},
  brace/.style={decorate, decoration={brace, amplitude=4pt}},
  open endpoint/.style={draw, circle, fill=white, line width=0.6pt, inner sep=0pt, minimum size=4pt},
  closed endpoint/.style={circle, fill=black, inner sep=0pt, minimum size=4pt},
  region/.style={draw, rounded corners=2pt, fill=gray!20},
  traj/.style={line width=1.1pt},                       
  proj/.style={dashed, thin},                            
  taxis/.style={-Latex, thick},                
  tmark/in/.style={circle, fill=black, inner sep=1.2pt},
  tmark/out/.style={circle, draw=black, fill=white, inner sep=1.2pt}, % tick fuori
  openmark/.style={circle, draw=black, fill=white, inner sep=1.1pt},
  rombo/.style={diamond, draw=black, fill=black, minimum size=6pt, inner sep=0pt},
  note/.style={draw, fill=white, rounded corners=2pt, font=\scriptsize, inner sep=2pt}
}

\usepackage{xcolor}
\definecolor{pyBg}{RGB}{250,250,250}
\definecolor{pyFrame}{RGB}{210,210,210}
\definecolor{pyKw}{RGB}{38,78,166}
\definecolor{pyStr}{RGB}{0,128,0}
\definecolor{pyNum}{RGB}{128,0,128}
\definecolor{pyId}{RGB}{20,20,20}
\definecolor{pyEmph}{RGB}{180,30,30}



\newcommand{\condizione}[3]{%
  \par\noindent\textbf{(#1)}\,\textbf{#2}\label{#3}\par%
}

\usepackage{newtxsf} 
\usepackage{booktabs}
\usepackage{tabularx}
\usepackage{arydshln}
\usepackage{multirow}
\usepackage{enumerate}

\usepackage{graphicx}
\usepackage[percent]{overpic}  

% creo il toggle 'punct'
\newtoggle{punct}
% di default è attivo
\toggletrue{punct}


% comandi per disattivare/riattivare
\newcommand{\DisablePunct}{\togglefalse{punct}}
\newcommand{\EnablePunct}{\toggletrue{punct}}

% non supporta itemize nested
% usa \DisablePunct \EnablePunct per attivare/disattivare
\AtBeginEnvironment{itemize}{%
  \iftoggle{punct}{%
    \def\itemizepunctuation{\def\itemizepunctuation{\ifhmode\unskip\fi;}}%
    \pretocmd\item{\itemizepunctuation}{}{}%
    \pretocmd\enditemize{\ifhmode\unskip\fi.}{}{}%
  }{}%
}
\newenvironment{punctitemize}
  {%
    \itemize
    \def\itemizepunctuation{\def\itemizepunctuation{\ifhmode\unskip\fi;}}%
    \pretocmd\item{\itemizepunctuation}{}{}%
    \pretocmd\enditemize{\ifhmode\unskip\fi.}{}{}%
  }
  {%
    \enditemize
  }

% Read all declarations and pass onto article class
% \makeatletter
\newif\if@garamond
\@garamondfalse
\DeclareOption{garamond}{\@garamondtrue}
\newif\if@palatino
\@palatinofalse
\DeclareOption{palatino}{\@palatinotrue}
\newif\if@libertine
\@libertinefalse
\DeclareOption{libertine}{\@libertinetrue}
\newif\if@helvetica
\@helveticafalse
\DeclareOption{helvetica}{\@helveticatrue}
\newif\if@times
\@timesfalse
\DeclareOption{times}{\@timestrue}
\newif\if@sourcesanspro
\@sourcesansprofalse
\DeclareOption{sourcesanspro}{\@sourcesansprotrue}
\newif\if@didot
\@didotfalse
\DeclareOption{didot}{\@didottrue}
\newif\if@latinmodern
\@latinmodernfalse
\DeclareOption{latinmodern}{\@latinmoderntrue}
\newif\if@lineno
\@linenofalse
\DeclareOption{lineno}{\@linenotrue}
\newif\if@authoryear
\@authoryearfalse
\DeclareOption{authoryear}{\@authoryeartrue}
\newif\if@draftfigs
\@draftfigsfalse
\DeclareOption{draftfigs}{\@draftfigstrue}
\newif\if@smallcaptions
\@smallcaptionsfalse
\DeclareOption{smallcaptions}{\@smallcaptionstrue}
\newif\if@texglossaries
\@texglossariesfalse
\DeclareOption{texglossaries}{\@texglossariestrue}
\newif\if@unsrt
\@unsrtfalse
\DeclareOption{unsrt}{\@unsrttrue}

% \makeatother
\newcommand*{\department}[1]{\gdef\@department{#1}}
\newcommand*{\university}[1]{\gdef\@university{#1}}
\newcommand*{\dedication}[1]{\gdef\@dedication{#1}}
\dedication{}%
\global\let\@dedication\@empty

\DeclareOption*{
\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions \relax
\LoadClass{report}

\RequirePackage[a4paper,inner=4cm,outer=3cm,top=4cm,bottom=3.5cm,pdftex]{geometry}


\if@unsrt
    \bibliographystyle{resources/stylesheet/plainnaturlunsrt}
\else
    \bibliographystyle{resources/stylesheet/plainnaturl}
\fi

\if@authoryear
    \usepackage[authoryear,comma,sort&compress]{natbib}
\else
    \usepackage[square,numbers,comma,sort&compress]{natbib}
\fi
\RequirePackage{url}

\RequirePackage[italian]{babel}

% macro che restituisce “aprile 2025”, “maggio 2025”, ecc.
\newcommand{\bibmonthyear}{%
  \ifcase\month
    \or gennaio%
    \or febbraio%
    \or marzo%
    \or aprile%
    \or maggio%
    \or giugno%
    \or luglio%
    \or agosto%
    \or settembre%
    \or ottobre%
    \or novembre%
    \or dicembre%
  \fi
  \space\the\year
}


% --- Teoremi (amsthm) con guardia su \openbox e numerazione adattiva ---
\makeatletter
% Evita "Command \openbox already defined" se un altro pacchetto l'ha già messa
\@ifundefined{openbox}{}{%
  \let\openbox\relax
}
\makeatother
\RequirePackage{amsthm}

% Definizione ambienti
\makeatletter
\@ifundefined{c@chapter}{%
  % Classi senza capitoli (es. article): numerazione per SEZIONE
  \newtheorem{proposition}{Proposizione}[section]%
}{%
  % Classi con capitoli (report/book/questa classe): numerazione per CAPITOLO
  \newtheorem{proposition}{Proposizione}[chapter]%
}
\theoremstyle{remark}
\newtheorem{remark}{Osservazione}
\makeatother

% Localizzazioni
\renewcommand{\proofname}{Dimostrazione}
\renewcommand{\qedsymbol}{$\square$}


\RequirePackage{datetime}
\newdateformat{monthyear}{\monthname[\THEMONTH] \THEYEAR}


\DeclareMathOperator{\svd}{svd}
\DeclareMathOperator{\diag}{diag}
\DeclareMathOperator{\cov}{cov}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\var}{Var}

% Algorithms
% Pseudocodice (NO pacchetto 'algorithm': il float è già definito sopra)
\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}

\RequirePackage{float}
\floatstyle{ruled}
\newfloat{algorithm}{htbp}{loa}[chapter]
\floatname{algorithm}{Algorithm}


% \makeatother
\RequirePackage[T1]{fontenc}

% Spacing
\RequirePackage{setspace}
\onehalfspacing

\RequirePackage{sectsty}

\if@draftfigs
    \RequirePackage[draft]{graphicx}
\else
    \RequirePackage{graphicx}
\fi
\RequirePackage{caption}
\RequirePackage{subcaption}

\RequirePackage{longtable}
\RequirePackage{color}
\RequirePackage{colortbl}

\RequirePackage{fancyhdr}

\RequirePackage[perpage,symbol]{footmisc}

\RequirePackage{fancyvrb}

\RequirePackage{rotating}

\RequirePackage{xifthen}

\RequirePackage{appendix}

\newcommand{\R}[1]{\ensuremath{\mathbb{R}^{#1}}}
\newcommand{\E}[1]{\ensuremath{\mathbb{E}\left({#1}\right)}}
\renewcommand{\vec}[1]{{\boldsymbol{\mathbf{#1}}}}
\newcommand{\p}[2][]{\ifthenelse{\isempty{#2}}{\ifthenelse{\isempty{#1}{}{\ensuremath{\text{P\hspace{-0.15em}}\left({#1}\right)}}}}{\ifthenelse{\isempty{#1}}{\ensuremath{\text{P\hspace{-0.15em}}\left( {#2} \right)}}{\ensuremath{\text{P\hspace{-0.15em}}\left( {#1} \, | \, {#2} \right)}}}}
\newcommand{\N}[2]{\ensuremath{\mathcal{N}\hspace{-0.15em}\left( {#1}, \; {#2} \right)}}

% Table of Contents redefine
\let\stdtoc\tableofcontents
\renewcommand*\tableofcontents{{%
\renewcommand*\MakeUppercase[1]{##1}\stdtoc}}

% List of Figures redefine
\let\stdlof\listoffigures
\renewcommand*\listoffigures{{%
\renewcommand*\MakeUppercase[1]{##1}\stdlof}}

% List of Tables redefine
\let\stdlot\listoftables
\renewcommand*\listoftables{{%
\renewcommand*\MakeUppercase[1]{##1}\stdlot}}

% List of algorithms
\makeatletter
\newcommand\listofalgorithms{%
    \if@twocolumn\@empty
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{Elenco degli algoritmi}%
      \@mkboth{%
          Elenco degli algoritmi}%
         {Elenco degli algoritmi}%
    \@starttoc{loa}%
    \if@restonecol\twocolumn\fi
    }
    
% Numerazione: azzera a ogni capitolo e stampa <capitolo>.<numero>
\@addtoreset{algorithm}{chapter}
\renewcommand\thealgorithm{%
  \ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@algorithm}

% Impostazioni del float 'algorithm'
\def\fps@algorithm{tbp}
\def\ftype@algorithm{2}
\def\ext@algorithm{loa}

% NOME del float e intestazione della caption in italiano
\floatname{algorithm}{Algoritmo}
\def\fnum@algorithm{\textbf{Algoritmo}\nobreakspace\textbf{\thealgorithm}}
    
% Localizzazione di \Require / \Ensure
\algrenewcommand\algorithmicrequire{\textbf{Input:}}
\algrenewcommand\algorithmicensure{\textbf{Output:}}
% Righe aggiuntive allineate a \Require / \Ensure
\newcommand{\RequireItem}[1]{\Statex\hspace{\algorithmicindent}#1}
\newcommand{\EnsureItem}[1]{\Statex\hspace{\algorithmicindent}#1}
% Commento a fine riga (sobrio)
\algrenewcommand\algorithmiccomment[1]{\hfill$\triangleright$~\textit{#1}}
% (Opzionale) numeri di riga leggermente più piccoli
\algrenewcommand\alglinenumber[1]{\footnotesize #1}
% Supporto \autoref{...} → "Algoritmo <n>"
\providecommand*{\algorithmautorefname}{Algoritmo}

% --- Spazio verticale dopo il blocco di Output (manuale) ---
\newcommand{\EnsureEndSkip}[1][.35\baselineskip]{%
  \Statex\hspace*{0pt}\vspace{#1}%
}

% Blocchi di indentazione "muti" (non stampano testo)
\algblock{Indent}{EndIndent}
\algtext*{Indent}
\algtext*{EndIndent}


% --- Traduzioni per listings ---
\AtBeginDocument{%
  \renewcommand{\lstlistingname}{Codice}% oppure "Codice"
  \renewcommand{\lstlistlistingname}{Elenco dei codici}% oppure "Elenco dei codici"
  \captionsetup[lstlisting]{name=\lstlistingname}
}

% Change the default captions font
\if@smallcaptions
    \def\captionfont{\small}
\fi

\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \addtocontents{loa}{\protect\addvspace{10\p@}}% Algorithm added
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

\let\l@algorithm\l@figure % We want to take the style from the figure one
\makeatother

% Renew the bibliography enviroment
\makeatletter
\renewcommand\bibsection{%
  \chapter*{\bibname\@mkboth{{\bibname}}{{\bibname}}}\addcontentsline{toc}{chapter}{\bibname}}
\makeatother

\RequirePackage{boxedminipage}
\RequirePackage{listings}
\RequirePackage{minitoc}
\RequirePackage{ifpdf}
\RequirePackage{nomencl}

\usepackage{courier}
\lstset{
    basicstyle=\footnotesize\ttfamily, % Default font
    numbers=left,              % Location of line numbers
    numberstyle=\tiny,          % Style of line numbers
    % stepnumber=2,              % Margin between line numbers
    numbersep=5pt,              % Margin between line numbers and text
    tabsize=2,                  % Size of tabs
    extendedchars=true,
    breaklines=true,            % Lines will be wrapped
    keywordstyle=\color{red},
    frame=b,
    % keywordstyle=[1]\textbf,
    % keywordstyle=[2]\textbf,
    % keywordstyle=[3]\textbf,
    % keywordstyle=[4]\textbf,   \sqrt{\sqrt{}}
    stringstyle=\color{white}\ttfamily, % Color of strings
    showspaces=false,
    showtabs=false,
    xleftmargin=17pt,
    framexleftmargin=17pt,
    framexrightmargin=5pt,
    framexbottommargin=4pt,
    % backgroundcolor=\color{lightgray},
    showstringspaces=false
}
\lstloadlanguages{ % Check documentation for further languages ...
     % [Visual]Basic,
     % Pascal,
     % C,
     % C++,
     % XML,
     % HTML,
     Python
}
% \DeclareCaptionFont{blue}{\color{blue}} 

% \captionsetup[lstlisting]{singlelinecheck=false, labelfont={blue}, textfont={blue}}
\usepackage{caption}
\DeclareCaptionFont{white}{\color{white}}
\DeclareCaptionFormat{listing}{\colorbox[cmyk]{0.43, 0.35, 0.35,0.01}{\parbox{\textwidth}{\hspace{15pt}#1#2#3}}}
\captionsetup[lstlisting]{format=listing,labelfont=white,textfont=white, singlelinecheck=false, margin=0pt, font={bf,footnotesize}}

\makenomenclature

\IfFileExists{\jobname.acr}{
    \def\nompreamble{\addcontentsline{toc}{chapter}{Nomenclature}A list of the variables and notation used in this thesis is defined below. The definitions and conventions set here will be observed throughout unless otherwise stated. For a list of acronyms, please consult page~\pageref{gl:acronym}.\\}
}{
    \def\nompreamble{\addcontentsline{toc}{chapter}{Nomenclature}A list of the variables and notation used in this thesis is defined below. The definitions and conventions set here will be observed throughout unless otherwise stated.\\}
}

\RequirePackage[breaklinks]{hyperref}
\makeatletter
\hypersetup{colorlinks,linkcolor=black,filecolor=black,urlcolor=black,citecolor=black,pdftitle={PhD Thesis}}
\makeatother

\RequirePackage{makeidx}
\makeindex

\RequirePackage[acronym,toc,numberedsection=autolabel]{glossaries}
\renewcommand*{\glsautoprefix}{gl:}

% 1) Registra la chiave addizionale “glossterm”
\makeatletter
  \glsaddstoragekey{glossterm}{}{\glossterm}
\makeatother

% 2) Impostazioni glossaries (noidx o classica) e sezione non numerata
\makeatletter
  \renewcommand*{\@@glossarysecstar}{*}
  \if@texglossaries
    \makenoidxglossaries
  \else
    \makeglossaries
  \fi
\makeatother

\newacronymstyle{linkmain}{%
  \GlsUseAcrEntryDispStyle{long-short}%
  \ifglshasfield{glossterm}{\glslabel}{%
    \glsadd{\glscurrentfieldvalue}%
  }{}%
}{%
  \GlsUseAcrStyleDefs{long-short}%
}
\setacronymstyle{linkmain}

\newcommand{\newdualentry}[4]{%
  \newglossaryentry{#1@main}{%
    name        = {#2},%
    description = {#4}%
  }%
   \newacronym[%
    glossterm   = {#1@main}
  ]{#1}{#2}{#3}%
}

\makeatletter

\renewenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\indexname}%
                        {\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \footnotesize\let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}

\makeatother

\pagestyle{fancy}
\fancyfoot{}
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\fancyhead[RO,LE]{\bfseries\thepage}
\fancyhead[LO]{\bfseries\leftmark}
\fancyhead[RE]{\bfseries\rightmark}
\renewcommand{\headrulewidth}{0.3pt}

% Clear Header Style on the last empty odd page
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}
    \thispagestyle{empty}
    \newpage
    \if@twocolumn\hbox{}\newpage\fi\fi\fi}

% Redefine chapters
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#2}%
                    \else
                      \addcontentsline{toc}{chapter}{#2}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \addtocontents{loa}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
% Section:
\def\@sect#1#2#3#4#5#6[#7]#8{%
                      \ifnum #2>\c@secnumdepth
                        \let\@svsec\@empty
                      \else
                        \refstepcounter{#1}%
                        \protected@edef\@svsec{\@seccntformat{#1}\relax}%
                      \fi
                      \@tempskipa #5\relax
                      \ifdim \@tempskipa>\z@
                        \begingroup
                          #6{%
                            \@hangfrom{\hskip #3\relax\@svsec}%
                              \interlinepenalty \@M #8\@@par}%
                        \endgroup
                        \csname #1mark\endcsname{#7}%
                        \addcontentsline{toc}{#1}{%
                          \ifnum #2>\c@secnumdepth \else
                            \protect\numberline{\csname the#1\endcsname}%
                          \fi
                          #8}%
                      \else
                        \def\@svsechd{%
                          #6{\hskip #3\relax
                          \@svsec #8}%
                          \csname #1mark\endcsname{#7}%
                          \addcontentsline{toc}{#1}{%
                            \ifnum #2>\c@secnumdepth \else
                              \protect\numberline{\csname the#1\endcsname}%
                            \fi
                            #8}}%
                      \fi
                      \@xsect{#5}}


% --- NUOVI COMANDI PARAMETRICI PER \maketitle ---
\newcommand*{\titlelogoone}[1]{\gdef\@titlelogoone{#1}}
\newcommand*{\titlelogotwo}[1]{\gdef\@titlelogotwo{#1}}

\newcommand*{\degreeprogram}[1]{\gdef\@degreeprogram{#1}}
\newcommand*{\thesistype}[1]{\gdef\@thesistype{#1}}
\newcommand*{\thesistitle}[1]{\gdef\@thesistitle{#1}}

\newcommand*{\advisor}[1]{\gdef\@advisor{#1}}
\newcommand*{\candidate}[1]{\gdef\@candidate{#1}}

\newcommand*{\academicyear}[1]{\gdef\@academicyear{#1}}
\newcommand*{\graduationdate}[1]{\gdef\@graduationdate{#1}}

% valoriali di default (se non ridefiniti dall’utente)
\titlelogoone{resources/images/title/logo.png}
\titlelogotwo{resources/images/title/logo2.png}

\degreeprogram{Corso di Laurea Triennale in Esempio}
\thesistype{Tesi di Laurea Triennale}
\thesistitle{Titolo della tesi}
\advisor{Nome Relatore}
\candidate{Nome Laureando}
\academicyear{20XX/20XX}
\department{Dipartimento di Esempio}
\university{Università di Esempio}

\renewcommand{\maketitle}{%
  {
    \newgeometry{top=4cm, bottom=3.5cm, left=3.5cm, right=3.5cm} % margini simmetrici
    \begin{titlepage}
      \begin{figure}[!htb]\centering
        \includegraphics[keepaspectratio,scale=0.15]{\@titlelogoone}
      \end{figure}
      \begin{center}
        \LARGE\textsc{\@university}\\[2.5mm]
        \large\textsc{\@department}\\[2.5mm]
        \begin{figure}[!htb]\centering
          \includegraphics[keepaspectratio,scale=0.6]{\@titlelogotwo}
        \end{figure}
        \textsc{\@degreeprogram}
      \end{center}
      \vspace{2cm}
      \begin{center}
        \textsc{\@thesistype}\\[4mm]
        {\Large\bfseries \@thesistitle}
        \vspace{2cm}
      \end{center}
      \begin{minipage}[t]{0.47\textwidth}
        \large\textsc{Relatore}\\[1mm]
        \@advisor
      \end{minipage}\hfill
      \begin{minipage}[t]{0.47\textwidth}\raggedleft
        \large\textsc{Laureando}\\
        \@candidate
        \vspace{1cm}
      \end{minipage}
      \noindent\rule{\linewidth}{0.5pt}
      \begin{center}
        \large ANNO ACCADEMICO \@academicyear\\
      \end{center}
    \end{titlepage}
    \restoregeometry % ripristina i margini originali
  }
}


\newcommand{\startpreamble}[1]
    {\pagenumbering{alph}
    \setcounter{page}{0}
    \maketitle
    \newpage
    \mbox{}
    \thispagestyle{empty}
    \ifx\@dedication\@empty
        \relax
    \else
        \clearpage
        \thispagestyle{empty}
        \vspace*{\stretch{1}}
        \begin{center}
            \huge{\@dedication}
        \end{center}
        \vspace*{\stretch{2}}
    \fi
    \cleardoublepage
    \pagenumbering{roman} \setcounter{page}{1}
    \if@lineno
        \linenumbers
    \fi
    }
\def\stoppreamble
    {\cleardoublepage
    \pagenumbering{arabic}
    \setcounter{page}{1}}
\makeatother