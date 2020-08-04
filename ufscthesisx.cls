%% setup/ufscthesisx.sty
%%
%% Copyright 2017 Evandro Coan
%% Copyright 2012-2016 by abnTeX2 group at https://www.abntex.net.br/
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% The Current Maintainer of this work is the Evandro Coan.
%%
%% The last Maintainer of this work was the abnTeX2 team, led
%% by Lauro César Araujo. Further information are available on
%% https://www.abntex.net.br/
%%
%% This work consists of the file `abntex2-ufsc.sty` renamed as follows:
%% Renamed the `abntex2.cls, v-1.9.6 laurocesar` to `setup/ufscthesisx.sty`
%%

% Define versão necessária do LaTeX
\NeedsTeXFormat{LaTeX2e}

% https://tex.stackexchange.com/questions/83484/missing-number-treated-as-zero-what-is-wrong-in-here
\errorcontextlines 10000

\makeatletter





%----------------------------------------------------------------------------------------
%   PACKAGES AND OTHER DOCUMENT CONFIGURATIONS BEFORE LOADING abntex2
%----------------------------------------------------------------------------------------

% For web links and paths with \path{..} and \url{https://www.python.org/downloads/}
% ftp://tug.ctan.org/pub/tex-archive/macros/latex/contrib/hyperref/doc/options.pdf
% https://tex.stackexchange.com/questions/3033/forcing-linebreaks-in-url
% https://tex.stackexchange.com/questions/124049/applying-options-to-already-loaded-package
\PassOptionsToPackage{hyphens}{url}

% Use its macro adjustwidth* to extend tables out of outer text border.
% https://tex.stackexchange.com/questions/366155/how-to-write-a-table-a-little-larger-than-the-paragraphs-with-centered-columns
\PassOptionsToPackage{strict}{changepage}

% Linked footnotes are not supported inside environment `tabularx', because they
% uses the optional argument of \footnotetext
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
\PassOptionsToPackage{hyperfootnotes=false}{hyperref}

% The class `abntex2` loads the `enumitem` package with options.
% With the package option shortlabels you can use an enumerate-like syntax, where A, a, I, i and 1
% stand for \Alph*, \alph*, \Roman*, \roman* and \arabic*. This is intended mainly as a sort of
% compatibility mode with the enumerate package, and therefore the following special rule applies:
% if the very first option (at any level) is not recognized as a valid key, then it will be
% considered a label with the enumerate-like syntax.
% https://tex.stackexchange.com/questions/119919/no-spacing-between-enumerated-items-with-usepackageenumerate
\PassOptionsToPackage{shortlabels}{enumitem}

% Fixes `pdfTeX warning (ext4): destination with the same identifier (name{figure.1.1}) has been
% already used, duplicate ignored`.
%
% The `abntex2` package loads the `hyperref` package, however there are several packages which are
% required to be loaded after and before `hyperref`.
%
% https://tex.stackexchange.com/questions/1863/which-packages-should-be-loaded-after-hyperref-instead-of-before
% https://tex.stackexchange.com/questions/50846/hyperref-is-loaded-by-the-class-and-i-need-to-load-packages-that-are-supposed-t
% https://tex.stackexchange.com/questions/51094/using-beforepackage-to-load-a-package-before-hyperref-does-not-work
\RequirePackage{scrlfile}
\AfterClass{memoir}
{
  \RequirePackage{float}
}

% The class `abntex2` loads the package `enumitem`, but `paralist` must be loaded before it
% https://tex.stackexchange.com/questions/162799/compilation-error-when-including-enumitem-and-paralist-packages
\AfterClass{memoir}
{
  % How to make horizontal lists?
  % https://tex.stackexchange.com/questions/146306/how-to-make-horizontal-lists
  \RequirePackage{paralist}
}

% https://tex.stackexchange.com/questions/6529/newline-linebreak-in-message
% https://tex.stackexchange.com/questions/383054/biblatex-error-incompatible-backref-package
% https://tex.stackexchange.com/questions/115828/backreferencing-in-classicthesis-package-does-not-work
% https://tex.stackexchange.com/questions/390349/why-my-biblatex-document-is-not-accepting-utf-8-on-the-bibliography
% https://tex.stackexchange.com/questions/55478/how-to-print-out-to-log-without-affecting-anything-else-lua-print-equiv
% https://tex.stackexchange.com/questions/483570/how-to-detect-whether-passoptionstopackage-was-already-called
\ifcsname opt@biblatex.sty\endcsname
  \message{Have options been passed for biblatex? YES!^^J}
\else
  \message{Have options been passed for biblatex? NO!^^J}
  \PassOptionsToPackage{style=abnt,backend=biber,repeatfields=true,backref=true,citecounter=true}{biblatex}
\fi

\AfterClass{memoir}
{
  \RequirePackage{biblatex}
}

% Package longtable must be put before hyperref and arydshln, hyperref after arydshln generates an error
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
\AfterClass{memoir}
{
  \RequirePackage{longtable}
}

% https://tex.stackexchange.com/questions/391993/how-to-silence-memoir-class-warning-against-the-use-of-caption-package
\RequirePackage{silence}
\WarningFilter*{memoir}{You are using the caption package with the memoir class}

% https://tex.stackexchange.com/questions/402676/can-i-silence-a-warning-which-is-coming-from-a-file-like-bigfoot-sty
\WarningFilter*{hyperref}{Option `hyperfootnotes' has already been used}











% Prove acesso a classe 'ufscthesisx'
\ProvidesClass{setup/ufscthesisx}[2016/11/15 1.0.0 setup/ufscthesisx]

% How can I properly resolve relative paths in `\usepackage`?
% https://tex.stackexchange.com/questions/123999/how-can-i-properly-resolve-relative-paths-in-usepackage
%
% Commenting this allow to use this as a relative package, with no warnings.
% \ProvidesPackage{ufscthesisx}[2017/08/28 v0.0.1 Evandro]

%
% Repassa todos os parâmetros a classe abntex2,
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{setup/abntex2}%
}

% https://en.wikibooks.org/wiki/LaTeX/Creating_Packages
% https://tex.stackexchange.com/questions/61487/processoptions-and-processkeyvaloptions
% https://tex.stackexchange.com/questions/12933/new-options-and-loaded-class-options-bug
% Now we'll execute any options passed in
\ProcessOptions\relax
\LoadClass{setup/abntex2}

% https://github.com/evandrocoan/ufscthesisx-light/runs/915876094?check_suite_focus=true#step:5:658
\RequirePackage{ifthen} % https://tex.stackexchange.com/questions/13866/why-is-the-ifthen-package-obsolete
\RequirePackage{ifplatform}
\RequirePackage{shellesc}
\RequirePackage{xstring}

% https://tex.stackexchange.com/questions/380799/warning-when-adding-package-minted
\StrSubstitute{\jobname}{ }{_}[\mintedjobname]
\StrSubstitute{\mintedjobname}{*}{_}[\mintedjobname]
\StrSubstitute{\mintedjobname}{"}{}[\mintedjobname]
\StrSubstitute{\mintedjobname}{'}{_}[\mintedjobname]

\ifwindows
  \providecommand{\DeleteFile}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\IfFileExists{#2}{\ShellEscape{del #2}}{}}%
    {\IfFileExists{#1/#2}{%
    \StrSubstitute{#1}{/}{\@backslashchar}[\mintedwindir]
    \ShellEscape{del \mintedwindir\@backslashchar #2}}{}}}
\else
  \providecommand{\DeleteFile}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\IfFileExists{#2}{\ShellEscape{rm #2}}{}}%
    {\IfFileExists{#1/#2}{\ShellEscape{rm #1/#2}}{}}}
\fi

\newboolean{AppMotherFuckerExists}
\newread\mintedappexistsfile

\newcommand{\TestAppMotherfuckerExists}[1]{
  \ifwindows
  \DeleteFile{\mintedjobname.aex}
  \ShellEscape{@echo off
    for \string^\@percentchar i in (#1.exe #1.bat #1.cmd)
    do set > \mintedjobname.aex <nul: /p
    x=\string^\@percentchar \string~$PATH:i>> \mintedjobname.aex}
  %$ <- balance syntax highlighting
  \immediate\openin\mintedappexistsfile\mintedjobname.aex
  \expandafter\def\expandafter\@tmp@cr\expandafter{\the\endlinechar}
  \endlinechar=-1\relax
  \readline\mintedappexistsfile to \mintedapppathifexists
  \endlinechar=\@tmp@cr
  \ifthenelse{\equal{\mintedapppathifexists}{}}
   {\AppMotherFuckerExistsfalse}
   {\AppMotherFuckerExiststrue}
  \immediate\closein\mintedappexistsfile
  \DeleteFile{\mintedjobname.aex}
  \else
  \ShellEscape{which #1 > /dev/null 2>&1 && touch \mintedjobname.aex}
  \IfFileExists{\mintedjobname.aex}
    {\AppMotherFuckerExiststrue
    \DeleteFile{\mintedjobname.aex}}
    {\AppMotherFuckerExistsfalse}
  \fi
}

\TestAppMotherfuckerExists{pygmentize}

\ifAppMotherFuckerExists
  % https://tex.stackexchange.com/questions/110292/testing-for-a-documentclass-option
  % https://tex.stackexchange.com/questions/514711/package-minted-warning-unexpected-value-for-option-chapterminted-is-ignored
  \@ifclasswith{setup/ufscthesisx}{chapter=TITLE}{
  \begingroup
  \def\x#1chapter=TITLE,#2\@nil{%
    \endgroup\def\@classoptionslist{#1#2}%
  }\expandafter\x\@classoptionslist\@nil
  }{}

  \@ifclasswith{setup/ufscthesisx}{section=TITLE}{
  \begingroup
  \def\x#1section=TITLE,#2\@nil{%
    \endgroup\def\@classoptionslist{#1#2}%
  }\expandafter\x\@classoptionslist\@nil
  }
\else
  \PackageWarning{minted}{You must have `pygmentize' installed to use the minted package}
  % \PackageError{minted}{You must have `pygmentize' installed to use the minted package}{Minted Error}
\fi








% Custom list throw LaTeX Error: Command \mycustomfiction already defined?
% https://tex.stackexchange.com/questions/388489/custom-list-throw-latex-error-command-mycustomfiction-already-defined
\RequirePackage{morewrites}

% Package csquotes Warning: Load 'inputenc' before 'csquotes'
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Indent the first section paragraphs
% https://tex.stackexchange.com/questions/39227/no-indent-in-the-first-paragraph-in-a-section
\RequirePackage{indentfirst}

% Is it possible to keep my translation together with original text?
% https://tex.stackexchange.com/questions/5076/is-it-possible-to-keep-my-translation-together-with-original-text
\RequirePackage{comment}

% Please tutor the usage of patchcmd and xpatch
% https://tex.stackexchange.com/questions/152773/please-tutor-the-usage-of-patchcmd-and-xpatch
\RequirePackage{xpatch}

% Why the environment ttfamily is hyphenated, but macro ttfamily is not hyphenating?
% https://tex.stackexchange.com/questions/387678/why-the-environment-ttfamily-is-hyphenated-but-macro-ttfamily-is-not-hyphenatin
\RequirePackage{letltxmacro}

% Theorem packages: which to use, which conflict?
% https://tex.stackexchange.com/questions/5599/theorem-packages-which-to-use-which-conflict
\RequirePackage{amsthm}

% Why is the ifthen package obsolete? (It is used by the abntex2 class)
% https://tex.stackexchange.com/questions/13866/why-is-the-ifthen-package-obsolete
\RequirePackage{ifthen}

% How to make section name uppercase in ToC?
% https://tex.stackexchange.com/questions/156916/how-to-make-section-name-uppercase-in-toc
\RequirePackage{textcase}

% https://tex.stackexchange.com/questions/482886/how-to-add-babel-captions-to-newfloat-package-environments
\RequirePackage{newfloat}
\RequirePackage{caption}

% How to auto adjust my last table column width, and why is there Underfull \vbox badness on this table?
% https://tex.stackexchange.com/questions/387238/how-to-auto-adjust-my-last-table-column-width-and-why-is-there-underfull-vbox/387251
%
% Why ltablex package breaks the changepage package?
% https://tex.stackexchange.com/questions/404339/why-ltablex-package-breaks-the-changepage-package
\RequirePackage{ltablex}\keepXColumns



% CONFIGURAÇÕES DE PACOTES
\newcommand{\ifnotempty}[2]{\ifthenelse{\not\equal{#1}{}}{#2}{}}
\newcommand{\ifnotdefined}[3]{\ifdefined #1 #3 \else #2 \fi}

% Comandos de dados - programa
\providecommand{\imprimirprograma}{}
\newcommand{\programa}[1]{\renewcommand{\imprimirprograma}{#1}}

\providecommand{\imprimirformacao}{}
\newcommand{\formacao}[1]{\renewcommand{\imprimirformacao}{#1}}

\providecommand{\imprimirarea}{}
\newcommand{\area}[1]{\renewcommand{\imprimirarea}{#1}}

\providecommand{\imprimirbiblioteca}{}
\newcommand{\biblioteca}[1]{\renewcommand{\imprimirbiblioteca}{#1}}

\providecommand{\imprimirinstituicaosigla}{}
\newcommand{\instituicaosigla}[1]{\renewcommand{\imprimirinstituicaosigla}{#1}}

\providecommand{\imprimirano}{}
\newcommand{\ano}[1]{\renewcommand{\imprimirano}{#1}}

\newcommand{\covername}{Capa}

% Comandos de dados - Coordenador
\newcommand{\coordenadorname}{Coordenador}
\providecommand{\imprimircoordenadorRotulo}{}
\providecommand{\imprimircoordenador}{}
\newcommand{\coordenador}[2][\coordenadorname]%
  {\renewcommand{\imprimircoordenadorRotulo}{#1}%
   \renewcommand{\imprimircoordenador}{#2}}

% inclui subtitulo na capa, folha de rosto e ficha catalografica
% https://github.com/lrsantos11/abntex2-ufsc/commit/fd30245353dcc49e193d281c78104afe54df9fe7
%
% Cria o comando \subtitulo. A norma define que o TITULO deve ser em caixa alta
% negrito, mas o subtitulo deve ser em caixa baixa.
\providecommand{\imprimirsubtitulo}{}
\newcommand{\subtitulo}[1]{\renewcommand{\imprimirsubtitulo}{#1}}

\newcounter{ufscthesisx@assuntos}
\providecommand{\listaassuntos}{}
\providecommand{\imprimirassuntos}
{%
  \setcounter{ufscthesisx@assuntos}{1}
  \@for\assunto:={\listaassuntos}\do
  {%
    \arabic{ufscthesisx@assuntos}.\assunto. %
    \addtocounter{ufscthesisx@assuntos}{1}
  }
}
\newcommand{\assuntos}[1]{\renewcommand{\listaassuntos}{#1}}

\providecommand{\imprimircentro}{}
\newcommand{\centro}[1]{\renewcommand{\imprimircentro}{#1}}

\providecommand{\imprimircampus}{}
\newcommand{\campus}[1]{\renewcommand{\imprimircampus}{#1}}


\newtheorem{axioma}{Axioma}[chapter]
\newtheorem{postulado}{Postulado}[chapter]
\newtheorem{teorema}{Teorema}[chapter]
\newtheorem{conjectura}{Conjectura}[chapter]
\newtheorem{corolario}[teorema]{Corol\'ario}
\newtheorem{lema}[teorema]{Lema}
\newtheorem{proposicao}[teorema]{Proposi\c{c}\~ao}


% Commonly used in definitions, conditions, problems and examples.
\theoremstyle{definition}
\newtheorem{definicao}{Defini\c{c}\~ao}[chapter]
\newtheorem{exemplo}{Exemplo}[section]
\newtheorem{exercicio}{Exerc\'icio}[section]
\newtheorem{condicao}{Condi\c{c}\~ao}[chapter]


\theoremstyle{remark}
\newtheorem{observacao}{Observa\c{c}\~ao}

\renewcommand{\qedsymbol}{$\blacksquare$}



% Margens
% https://tex.stackexchange.com/questions/378119/how-to-set-margins-in-memoir-class
\setlrmarginsandblock{3cm}{2cm}{*}
\setulmarginsandblock{3cm}{2cm}{*}
\checkandfixthelayout

% Fontes dos títulos e seções
% Tamanho da fonte padrão do 'ABNTEX'
% https://tex.stackexchange.com/questions/460835/set-font-size-and-line-spacing
% Set the default font size as 12pt with 1.5cm spacing between lines, 12/2 = 6, 12+6 = 18, i.e., one half spacing
% \renewcommand{\normalsize}{\fontsize{12pt}{16pt}\selectfont}
% \renewcommand{\normalsize}{\fontsize{12.0pt}{18.0pt}\selectfont}

% Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% https://tex.stackexchange.com/questions/18931/memoir-class-with-subcaption-and-hyperref-packages
\DeclareCaptionFont{small}{\fontsize{10pt}{12pt}\selectfont}
\renewcommand{\footnotesize}{\fontsize{10pt}{12pt}\selectfont}

% Set caption font size in memoir
% https://tex.stackexchange.com/questions/58943/set-caption-font-size-in-memoir
% https://tex.stackexchange.com/questions/103566/controlling-the-spacing-between-lines-with-fontsize-selectfont
\newcommand{\ufsccaptionsize}{\fontsize{10pt}{12pt}\selectfont}

% https://latex.org/forum/viewtopic.php?t=22437
% https://tex.stackexchange.com/questions/346411/how-does-footnotesep-work-anyway
% https://tex.stackexchange.com/questions/133008/make-footnotesep-same-as-line-spacing-using-custom-thesis-class
% https://tex.stackexchange.com/questions/514592/how-can-i-see-the-line-spacing-between-lines
% https://tex.stackexchange.com/questions/514682/how-to-get-the-normalsize-or-small-font-baselineskip-size
\setlength{\footnotesep}{\f@baselineskip}

% https://tex.stackexchange.com/questions/327843/how-to-put-figure-caption-on-top
\captionnamefont{\ufsccaptionsize}
\captiontitlefont{\ufsccaptionsize}

% Paragraph size is given by
% Default value for UFSC 1.5cm
\setlength{\parindent}{1.5cm}

% Package setspace must be put before hyperref
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
% https://tex.stackexchange.com/questions/270557/undefined-control-sequence-on-onehalfspacing
% https://tex.stackexchange.com/questions/374401/setting-text-in-onehalfspacing-footnotes-singlespacing-with-memoir
\@ifclassloaded{memoir}{}{
  % \SingleSpacing
  \OnehalfSpacing
  % \DoubleSpacing
}

% Set the UFSC epigrafe font size
% Changing font size in an example environment
% https://tex.stackexchange.com/questions/123528/changing-font-size-in-an-example-environment
\expandafter\def\expandafter\epigrafe\expandafter{\epigrafe\ufsccaptionsize}

% Selects a roman (i.e., serifed) font family
% \renewcommand{\rmdefault}{cmr}
% https://tex.stackexchange.com/questions/517223/renewcommand-familydefault-sfdefault-is-causing-%e2%86%92-to-throw-package-textcomp
\renewcommand{\familydefault}{\sfdefault}

% Fontes padroes de part, chapter, section, subsection e subsubsection
\renewcommand{\ABNTEXfontereduzida}{\fontsize{10pt}{12pt}\selectfont}

\renewcommand{\ABNTEXchapterfont}{\sffamily\fontseries{bx}\fontshape{n}\selectfont}
\renewcommand{\ABNTEXchapterfontsize}{\normalsize\selectfont}
\renewcommand{\ABNTEXpartfont}{\sffamily\fontseries{bx}\fontshape{n}\selectfont}
\renewcommand{\ABNTEXpartfontsize}{\Huge\selectfont}
\renewcommand{\ABNTEXsectionfont}{\sffamily\fontseries{m}\fontshape{n}\selectfont}
\renewcommand{\ABNTEXsectionfontsize}{\normalsize\selectfont}
\renewcommand{\ABNTEXsubsectionfont}{\sffamily\fontseries{b}\fontshape{n}\selectfont}
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize\selectfont}
\renewcommand{\ABNTEXsubsubsectionfont}{\sffamily\fontseries{m}\fontshape{n}\selectfont}
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize\selectfont}
\renewcommand{\ABNTEXsubsubsubsectionfont}{\sffamily\fontseries{m}\fontshape{it}\selectfont}
\renewcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize\selectfont}

% Tamanho da fonte para a epígrafe UFSC
\expandafter\def\expandafter\epigrafe\expandafter{\epigrafe\ABNTEXfontereduzida}

% Comando que simula a finalizacao de uma parte no bookmark e
% adiciona espaco de \part no sumario
\renewcommand{\phantompart}
{%
  \bookmarksetup{startatroot}%
  \phantomsection%
  \addtocontents{toc}{\vspace{0em}}
}

% TOC Spacing in Memoir
% https://tex.stackexchange.com/questions/60317/toc-spacing-in-memoir
\setlength{\cftbeforechapterskip}{12pt}


% Fontes das entradas do sumario
% https://tex.stackexchange.com/questions/399828/how-to-make-the-table-of-contents-section-title-upper-case-without-messing-with
% https://tex.stackexchange.com/questions/156916/how-to-make-section-name-uppercase-in-toc
\let\oldcontentsline\contentsline
\def\contentsline#1#2{%
  \expandafter\ifx\csname l@#1\endcsname\l@section
  \expandafter\@firstoftwo
  \else
  \expandafter\@secondoftwo
  \fi
  {%
  \oldcontentsline{#1}{\MakeTextUppercase{#2}}%
  }{%
  \oldcontentsline{#1}{#2}%
  }%
}


% No caso de Sumario (TOC) UFSC
%
% Memoir has another mechanism for the job: \cftsetindents{‹kind›}{indent}{numwidth}. Here kind is
% chapter, section, or whatever; the indent specifies the ‘margin’ before the entry starts; and the
% width is of the box into which the number is typeset (so needs to be wide enough for the largest
% number, with the necessary spacing to separate it from what comes after it in the line.
% http://www.tex.ac.uk/FAQ-tocloftwrong.html
%
% memoir: indentation of unnumbered sections in table of contents
% https://tex.stackexchange.com/questions/264668/memoir-indentation-of-unnumbered-sections-in-table-of-contents
%
% Memoir ToC: indent the second line by number+space width in the previous line OR set standard
% https://tex.stackexchange.com/questions/394227/memoir-toc-indent-the-second-line-by-numberspace

% `\cftlastnumwidth` and these `\cftsetindents` are defined by the abntex2 class,
% obeying the `ABNTEXsumario-abnt-6027-2012`. \newlength{\cftlastnumwidth}
\setlength{\cftlastnumwidth}{\cftsubsubsectionnumwidth}
\addtolength{\cftlastnumwidth}{1em}

% http://www.tex.ac.uk/FAQ-tocloftwrong.html
% Use \setlength\cftsectionnumwidth{4em} to override all these values
\cftsetindents{part}         {0em}{\cftlastnumwidth}
\cftsetindents{chapter}      {0em}{\cftlastnumwidth}
\cftsetindents{section}      {0em}{\cftlastnumwidth}
\cftsetindents{subsection}   {0em}{\cftlastnumwidth}
\cftsetindents{subsubsection}{0em}{\cftlastnumwidth}
\cftsetindents{paragraph}    {0em}{\cftlastnumwidth}
\cftsetindents{subparagraph} {0em}{\cftlastnumwidth}

\newlength{\cftnumberboxnumberwidth}
\setlength{\cftnumberboxnumberwidth}{2em}
\renewcommand{\tocprintchapter}
{%
  \addtocontents{toc}{\cftsetindents{chapter}{0em}{\cftlastnumwidth}}
}
%
\renewcommand{\tocinnonumchapter}
{%
  \addtocontents{toc}{\cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}}%
  \cftinserthook{toc}{A}
}
\renewcommand{\tocprintchapternonum}
{%
  \addtocontents{toc}{\cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}}
}
%
\renewcommand{\tocpartapendices}
{%
  \addtocontents{toc}{\cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}}
  \cftinserthook{toc}{A}
}
%
\renewcommand{\tocpartanexos}
{%
  \addtocontents{toc}{\cftsetindents{chapter}{\cftlastnumwidth}{\cftnumberboxnumberwidth}}
  \cftinserthook{toc}{A}
}

\renewcommand{\cftpartfont}{\ABNTEXpartfont}
\renewcommand{\cftpartpagefont}{\cftpartfont}

\renewcommand{\cftchapterfont}{\ABNTEXchapterfont}
\renewcommand{\cftchapterpagefont}{\cftchapterfont}

\renewcommand{\cftsectionfont}{\ABNTEXsectionfont}
\renewcommand{\cftsectionpagefont}{\cftsectionfont}

\renewcommand{\cftsubsectionfont}{\ABNTEXsubsectionfont}
\renewcommand{\cftsubsectionpagefont}{\cftsubsectionfont}

\renewcommand{\cftsubsubsectionfont}{\ABNTEXsubsubsectionfont}
\renewcommand{\cftsubsubsectionpagefont}{\cftsubsubsectionfont}

\renewcommand{\cftparagraphfont}{\ABNTEXsubsubsubsectionfont}
\renewcommand{\cftparagraphpagefont}{\cftparagraphfont}

% Ajusta entrada Referencias
\renewcommand{\bibsection}
{%
  \chapter*{\bibname}
  \bibmark
  \ifnobibintoc\else
  \phantomsection
  \addcontentsline{toc}{chapter}{\uppercase{\bibname}}
  \fi
  \prebibhook
}


% Espaçamento depois do título
\setlength{\afterchapskip}{0.38cm}

% Controle do espaçamento entre um parágrafo e outro. Tente também \onelineskip
\setlength{\parskip}{0.0cm}

% O tamanho do parágrafo é dado por
\setlength{\parindent}{1.0cm}

% Recuo citação
\setlength{\ABNTEXcitacaorecuo}{3cm} %4, mas abntex2 está somando 1cm

% Comando para inverter sobrenome e nome
\newcommand{\ufscthesisx@inverter}[1]
{%
  \StrBehind{#1}{{}},
  \StrBefore{#1}{{}}
}

% Comandos auxiliares
% https://tex.stackexchange.com/questions/514592/how-can-i-see-the-line-spacing-between-lines
\newcommand{\showfont}
{%
  (\foreignlanguage{english}
  {%
    encoding: \f@encoding{},
    family: \f@family{},
    series: \f@series{},
    shape: \f@shape{},
    size: \f@size{},
    baseline: \f@baselineskip{},
    linespread: \f@linespread{},
    linespacing: \the\baselineskip{}%
  })%
}

% Comandos auxiliares
\newcommand{\justshowfont}
{%
  (\foreignlanguage{english}
  {%
    \f@encoding{},
    \f@family{},
    \f@series{},
    \f@shape{},
    \f@size{},
    \f@baselineskip{},%
    \f@linespread{},
    \the\baselineskip{}%
  })%
}

%Numeração dos floats por capítulo
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}


% Macros for Cross-reference
\newcommand{\figref}[1]{Figura~\ref{#1}}   % Cross-reference of figures
\newcommand{\tabref}[1]{Tabela~\ref{#1}}    % Cross-reference of tables
\newcommand{\eqnref}[1]{\eqref{#1}}      % Cross-reference of equations
\newcommand{\secref}[1]{Seção~\ref{#1}}  % Cross-reference of equations
\newcommand{\defref}[1]{Definição~\ref{#1}} %


\renewenvironment{resumo}[1][\resumoname]
{%
  % Fixed double bookmark entries as `\pretextualchapter` bellow is already calling `\PRIVATEbookmarkthis`
  % \PRIVATEbookmarkthis{#1}
  % \renewcommand{\abstractnamefont}{\chaptitlefont}
  % \renewcommand{\abstractname}{\ABNTEXchapterupperifneeded{#1}}
  \pretextualchapter{#1}
}
{%
  \PRIVATEclearpageifneeded
}

% Fix the resumo environment, which does not accept paragraphs on ufscthesisx
%
% Changing font size in an example environment
% https://tex.stackexchange.com/questions/123528/changing-font-size-in-an-example-environment
%
% How to disable automatic indentation on new paragraphs?
% https://tex.stackexchange.com/questions/14375/how-to-disable-automatic-indentation-on-new-paragraphs
%
% How to disable paragraphs inside my environment with \let\par\relax?
% https://tex.stackexchange.com/questions/388369/how-to-disable-paragraphs-inside-my-environment-with-let-par-relax
\xapptocmd{\resumo}{\setlength{\parindent}{0pt}\SingleSpacing\let\parOriginal\par\let\par\relax}{}{}
\xpretocmd{\endresumo}{\endgraf}{}{}

% \imprimirpalavraschave{Palavras-chaves}{latex. abntex. editoração de texto.}
\newcommand{\imprimirpalavraschave}[2]{%
  \@ifundefined{parOriginal}{}{\parOriginal}\vspace{\onelineskip}\textbf{#1}: #2
}

% Create a list of things like (\usepackage{paralist})
%   \palavraschaveufsc{englishkeywordslist}{keyword 1}
%   \palavraschaveufsc{englishkeywordslist}{keyword 2}
%   \begin{inparaitem}[]\englishkeywordslist\end{inparaitem}
%   \begin{inparaenum}\englishkeywordslist\end{inparaenum}
%
% https://tex.stackexchange.com/questions/61811/how-to-define-inparaenum-in-the-preamble
% https://tex.stackexchange.com/questions/468862/lonely-item-perhaps-a-missing-list-environment-missing-package
% https://tex.stackexchange.com/questions/188476/how-do-you-define-one-macro-with-arguments-inside-another
% https://tex.stackexchange.com/questions/191266/defining-macros-with-arguments
% https://tex.stackexchange.com/questions/65780/macro-defining-macro
% https://tex.stackexchange.com/questions/20456/removing-a-backslash-when-passing-arguments-to-newcommand
\newcommand{\palavraschaveufsc}[2]{%
  \@ifundefined{#1}{%
    \message{^^JNotice palavraschaveufsc: #1 is undefined with '#2'^^J}
    \expandafter\newcommand\csname#1\endcsname{}
  }{\message{^^JNotice palavraschaveufsc: #1 is defined with '#2'^^J}}
  {\expandafter\g@addto@macro\csname#1\endcsname{\item #2. }}

  \@ifundefined{#1comvirgula}{%
    \message{^^JNotice palavraschaveufsc: #1 is undefined with '#2'^^J}
    \expandafter\newcommand\csname#1comvirgula\endcsname{}
  }{\message{^^JNotice palavraschaveufsc: #1 is defined with '#2'^^J}}
  {\expandafter\g@addto@macro\csname#1comvirgula\endcsname{\item #2, }}

  \@ifundefined{#1semitem}{%
    \message{^^JNotice palavraschaveufsc: #1 is undefined with '#2'^^J}
    \expandafter\newcommand\csname#1semitem\endcsname{}
  }{\message{^^JNotice palavraschaveufsc: #1 is defined with '#2'^^J}}
  {\expandafter\g@addto@macro\csname#1semitem\endcsname{#2. }}
}

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Configura layout
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

% ------------------------------------------------------------------------
%% criar um novo estilo incluindo logos da UFSC
% ------------------------------------------------------------------------

% Configura layout para elementos textuais, redefining the ABNT command `\textual`.
% Delete his to restore the ABNT default behavior.
\renewcommand{\textual}
{%
  % Estilo original do Abntex2
  \pagestyle{abntheadings}

  % Remove a numeração das páginas no início dos capítulos.
  % ABNT default value `{chapter}{abntchapfirst}`
  \aliaspagestyle{chapter}{empty}

  \nouppercaseheads
  \bookmarksetup{startatroot}
}


% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% Comandos e ambientes de editoracao APENDICES e ANEXOS
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% ---
% Imprime uma pagina de divisao no estilo parte
\renewcommand{\partpage}
{%
  % \phantomsection
  % \addcontentsline{toc}{part}{\appendixtocname}
  \appendixpage*
}


% ---
% Impressão da Capa
\renewcommand{\imprimircapa}
{%
  \begin{capa}%

    \center
    {%
      % https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions
      \includegraphics[width=1.84cm,keepaspectratio]{setup/UFSC_sigla_fundo_claro.png}

      % https://tex.stackexchange.com/questions/103566/controlling-the-spacing-between-lines-with-fontsize-selectfont
      {\OnehalfSpacing
        \MakeTextUppercase{\imprimirinstituicao}\par
        \MakeTextUppercase{\imprimircampus}\par
        \MakeTextUppercase{\imprimirprograma}\par
      }
    }

    \vfill

    {\imprimirautor}

    \vfill
    {%
    \center
      {\ABNTEXchapterfont\MakeUppercase{\imprimirtitulo}}%
      \ifnotempty{\imprimirsubtitulo}{{\ABNTEXchapterfont:} \par \imprimirsubtitulo}
    }
    \vfill

    {%
      \imprimirlocal\par
      \imprimirano\par
    }
    \vspace*{1cm}
  \end{capa}
}
% ---


% Conteúdo padrao da Folha de Rosto
%
% Underfull \hbox (badness 10000) message
% https://tex.stackexchange.com/questions/199635/underfull-hbox-badness-10000-message
%
% Underfull \hbox (badness …) in paragraph at lines x-y
% https://tex.stackexchange.com/questions/356110/underfull-hbox-badness-in-paragraph-at-lines-x-y
%
% How to add an empty line between paragraphs?
% https://tex.stackexchange.com/questions/135134/how-to-add-an-empty-line-between-paragraphs
\renewcommand{\folhaderostocontent}
{%
  \begin{center}
    {\imprimirautor}

    \vspace*{\fill}\vspace*{\fill}
    \begin{center}

      {\ABNTEXchapterfont\MakeUppercase{\imprimirtitulo}}
      \abntex@ifnotempty{\imprimirsubtitulo}{{\ABNTEXchapterfont\!:} \\ \imprimirsubtitulo}

    \end{center}
    \vspace*{\fill}

    \abntex@ifnotempty{\imprimirpreambulo}
    {%
      \hspace{\textwidth}
      \begin{adjustwidth*}{8cm}{}%8.5

        \SingleSpacing
        {\ufsccaptionsize\imprimirpreambulo}

        {
          \ufsccaptionsize\textbf{\imprimirorientadorRotulo:}~\imprimirorientador\par
          \abntex@ifnotempty{\imprimircoorientador}
          {
            {\textbf{\imprimircoorientadorRotulo:}~\imprimircoorientador}%
          }
        }

      \end{adjustwidth*}
    }

    \vspace*{\fill}
    {%
      \imprimirlocal\par
      \imprimirano\par
    }

  \end{center}
}

% If document class is equal to something then do not use package
% https://tex.stackexchange.com/questions/46223/if-document-class-is-equal-to-something-then-do-not-use-package
\@ifclassloaded{setup/abntex2}
{
  % Package hyperref Warning: Token not allowed in a PDF string?
  % https://tex.stackexchange.com/questions/384885/package-hyperref-warning-token-not-allowed-in-a-pdf-string
  \pdfstringdefDisableCommands{\let\uppercase\relax}
}{}


% Backward compatibility with `abntex2cite` package `\citeonline` command with the new `biblatex` package
% https://tex.stackexchange.com/questions/655/what-is-the-difference-between-def-and-newcommand
\let\citeonline\textcite

% https://tex.stackexchange.com/questions/123104/inline-citations-with-only-author-title-and-year
\DeclareCiteCommand{\citeauthortitleyear}
  {\boolfalse{citetracker}%
   \boolfalse{pagetracker}%
   \usebibmacro{prenote}}
  {\ifciteindex
   {\indexnames{labelname}%
    \indexfield{indextitle}}
   {}%
   \printfield{labeltitle}%
   \setunit{\addcomma\space}%
   \printtext[bibhyperref]{%
     \printnames{labelname}%
     \space%
     (\printfield{year})%
     }%
  }
  {\multicitedelim}
  {\usebibmacro{postnote}}

% https://tex.stackexchange.com/questions/443603/how-to-appear-subsubsection-in-chapter-in-my-list-of-contents
\setcounter{secnumdepth}{6}
\setcounter{tocdepth}{6}










%% README.md
%% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`



% Please tutor the usage of patchcmd and xpatch
% https://tex.stackexchange.com/questions/152773/please-tutor-the-usage-of-patchcmd-and-xpatch
\usepackage{xpatch}

% Incompatible color definition when using tikz with color package
% https://tex.stackexchange.com/questions/150369/incompatible-color-definition-when-using-tikz-with-color-package
\usepackage{xcolor}

% RGB colors in absolute values from 0 to 255 by using `RGB` tag
\definecolor{darkblue}{RGB}{26,13,178}

% RGB colors in percentage notation by using `rgb` tag
\definecolor{darkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

% Increase the space around the hyphen or dash - on the table of contents
% APÊNDICE A –- SOMETHING . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 3
%
% https://tex.stackexchange.com/questions/512916/how-to-increase-memoir-table-of-contents-spacing-between-appendix-and-its-hyphen
% https://tex.stackexchange.com/questions/49905/word-appendix-in-toc-with-memoir-class
% https://tex.stackexchange.com/questions/152773/please-tutor-the-usage-of-patchcmd-and-xpatch
% https://texfaq.org/FAQ-protect
\xpretocmd{\l@appendix}{\def\@chapapp@extrahyphenspaces{~}}
{\message{^^J^^JChapterformat patch 1 for chapternumberline could SUCCESSFULLY!^^J
% ^^J^^J^^J
}}
{\message{^^J^^JChapterformat patch 1 for chapternumberline could NOT be applied!^^J^^J^^J^^J
}}

\xpretocmd{\l@chapter}{\def\@chapapp@extrahyphenspaces{}}
{\message{^^J^^JChapterformat patch 2 for chapternumberline could SUCCESSFULLY!^^J
% ^^J^^J^^J
}}
{\message{^^J^^JChapterformat patch 2 for chapternumberline could NOT be applied!^^J^^J^^J^^J
}}

\patchcmd{\chapternumberline}{\@cftasnum}{%
  \@chapapp@extrahyphenspaces%
  \@chapapp@extrahyphenspaces%
  \@cftasnum%
  \@chapapp@extrahyphenspaces%
}
{\message{^^J^^JChapterformat patch 3 for chapternumberline could SUCCESSFULLY!^^J
% ^^J^^J^^J
}}
{\message{^^J^^JChapterformat patch 3 for chapternumberline could NOT be applied!^^J^^J^^J^^J
}}

\patchcmd{\chapternumberline}{\@cftasnumb}{%
  \@cftasnumb%
  \@chapapp@extrahyphenspaces%
}
{\message{^^J^^JChapterformat patch 4 for chapternumberline could SUCCESSFULLY!^^J
% ^^J^^J^^J
}}
{\message{^^J^^JChapterformat patch 4 for chapternumberline could NOT be applied!^^J^^J^^J^^J
}}

% https://tex.stackexchange.com/questions/512898/the-appendix-word-disappears-from-the-table-of-contents-when-using-include
% https://tex.stackexchange.com/questions/1050/whats-the-difference-between-newcommand-and-newcommand
\@ifclassloaded{setup/abntex2}{
  \renewcommand*{\cftappendixname}{\apendicename\space\space}
}{}

% Allows putting an [H] in \begin{figure} to specify the exact location of the figure
% https://tex.stackexchange.com/questions/8625/force-figure-placement-in-text
%
% Package float must be put before hyperref
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
\usepackage{float}

% bigfoot.sty:61: Package hyperref Warning: Option `hyperfootnotes' has already been used
% https://tex.stackexchange.com/questions/402652/bigfoot-sty61-package-hyperref-warning-option-hyperfootnotes-has-already-be
\@ifpackageloaded{hyperref}{\hypersetup{hyperfootnotes=false}}{\PassOptionsToPackage{hyperfootnotes=false}{hyperref}}
\usepackage{hyperref}


% \lettrine{O}{nce} upon a time...
% \lettrine[findent=2pt]{\fbox{\textbf{T}}}{ }his thesis deals with...
%
% https://tex.stackexchange.com/questions/164298/starting-a-paragraph-with-a-big-letter
\usepackage{lettrine}

% Allows in-line images such as the example fish picture
\usepackage{wrapfig}

% How to automatically force latex to not justify the text when it is not wise?
% https://tex.stackexchange.com/questions/365801/how-to-automatically-force-latex-to-not-justify-the-text-when-it-is-not-wise
\usepackage{array,ragged2e}

% Use its macro adjustwidth* to extend tables out of outer text border.
% https://tex.stackexchange.com/questions/366155/how-to-write-a-table-a-little-larger-than-the-paragraphs-with-centered-columns
%
% The `memoir` class emulates this package, so not try to load it when using `memoir`, ifpackageloaded question
% https://tex.stackexchange.com/questions/70212/ifpackageloaded-question
\@ifpackageloaded{changepage}{}{\usepackage[strict]{changepage}}

% How to make horizontal lists?
% https://tex.stackexchange.com/questions/146306/how-to-make-horizontal-lists
%
% Compilation error when including enumitem and paralist packages
% https://tex.stackexchange.com/questions/162799/compilation-error-when-including-enumitem-and-paralist-packages
\usepackage{paralist}

% Replace the `paralist` package implementation of enumerate lists
\usepackage{enumerate}

% With the package option shortlabels you can use an enumerate-like syntax, where A, a, I, i and 1
% stand for \Alph*, \alph*, \Roman*, \roman* and \arabic*. This is intended mainly as a sort of
% compatibility mode with the enumerate package, and therefore the following special rule applies:
% if the very first option (at any level) is not recognized as a valid key, then it will be
% considered a label with the enumerate-like syntax.
%
% No spacing between enumerated items with \usepackage{enumerate}
% https://tex.stackexchange.com/questions/119919/no-spacing-between-enumerated-items-with-usepackageenumerate
\usepackage[shortlabels]{enumitem}

\usepackage{tabularx}
\usepackage{multirow}



% The package supports the Text Companion fonts, which provide many text symbols (such as
% baht, bullet, copyright, musicalnote, onequarter, section, and yen), in the TS1 encoding.
%
% `LaTeX Error: Option clash for package textcomp` with the package `mathcomp`, it need to be loaded before it.
% https://tex.stackexchange.com/questions/343546/how-do-you-resolve-the-error-in-latex-option-clash-for-package-inputenc-usepa
% https://tex.stackexchange.com/questions/517223/setting-familydefault-as-sfdefault-is-causing-the-arrow-character-%e2%86%92-to-throw-p
\usepackage[full,warn]{textcomp}
\usepackage{mathcomp}

% Número da última página
\usepackage{lastpage}

% Tamanho das fontes
\usepackage{anyfontsize}

% Usa a fonte Latin Modern
\usepackage{lmodern}

% https://tex.stackexchange.com/questions/227711/blank-page-after-titlingpage
\usepackage{atbegshi}

% Selecao de codigos de fonte
% https://tex.stackexchange.com/questions/664/why-should-i-use-usepackaget1fontenc
%
% Will allow all displayable utf8 characters to be available as input
% https://tex.stackexchange.com/questions/13067/utf8x-vs-utf8-inputenc
\usepackage[T1]{fontenc}

% Codificacao do documento (conversão automática dos acentos)
\usepackage[utf8]{inputenc}

\usepackage{graphicx}

\usepackage{pdfpages}
\usepackage{rotating}

% Needs to be loaded after hyperref
% http://ctan.sharelatex.com/tex-archive/macros/latex/contrib/hyperref/README.pdf
%
% Package incompatibilty between alphalph, and hyperref with amsmath subequations
% https://tex.stackexchange.com/questions/134665/package-incompatibilty-between-alphalph-and-hyperref-with-amsmath-subequations
\usepackage{amsmath}
\let\equation\gather
\let\endequation\endgather

\usepackage{amssymb}
\usepackage{mathrsfs}
\usepackage{pdflscape}
\usepackage{epstopdf}
\usepackage{multirow}
\usepackage{listings}

% Para incluir links
\usepackage{url}

% Pacote necessário para a lista de siglas.
\usepackage{nomencl}
\usepackage{booktabs}

% A comprehensive (SI) units package
\usepackage{siunitx}
\sisetup{detect-all}
\sisetup{scientific-notation = fixed, fixed-exponent = 0, round-mode = places,round-precision = 2,output-decimal-marker = {,} }
\DeclareSIUnit \VA {VA} % apparent power

% We need to load it after `siunitx` package, otherwise it will cause to the package `bigfoot` to throw
% the error `input stack size=5000`
% https://tex.stackexchange.com/questions/403651/while-loading-fancyvrb-siunitx-and-bigfoot-i-got-input-stack-size-5000-tex-st
\usepackage{fancyvrb}

% gives you the possibility to rotate any object of an arbitrary angle.
\usepackage{rotating}

% Rotação de páginas no documento pdf.
\usepackage{pdflscape}

% Customize the look of the frame
\usepackage{mdframed}

% Pacotes adicionais, usados apenas no âmbito do Modelo Canônico do abnteX2
\usepackage{tablefootnote}
\usepackage{longtable}
\usepackage{tocloft}

% https://tex.stackexchange.com/questions/2441/how-to-add-a-forced-line-break-inside-a-table-cell
\usepackage{makecell}
\usepackage{pbox}

% LaTeX not hyphenating properly, text running off page
% https://tex.stackexchange.com/questions/28136/latex-not-hyphenating-properly-text-running-off-page
\usepackage{hyphenat}

% How to use \scalebox around my environment?
% https://tex.stackexchange.com/questions/387515/how-to-use-scalebox-around-my-environment
\usepackage{verbatimbox}

% LaTeX/Indexing
% https://www.sharelatex.com/learn/Indices
% https://en.wikibooks.org/wiki/LaTeX/Indexing
\usepackage{makeidx}
\makeindex

% Is it possible to keep my translation together with original text?
% https://tex.stackexchange.com/questions/5076/is-it-possible-to-keep-my-translation-together-with-original-text
\usepackage{comment}

% Scoping \raggedbottom to a single page
% https://tex.stackexchange.com/questions/226716/scoping-raggedbottom-to-a-single-page
\usepackage{afterpage}

% Logical String Length
% https://tex.stackexchange.com/questions/87638/logical-string-length
\usepackage{xstring}
\usepackage{xifthen}
\usepackage{ifplatform}
\usepackage{shellesc}

% abntex2
\usepackage{bookmark}
\usepackage{calc}

% cannot use \caption under minipage
% https://tex.stackexchange.com/questions/57433/cannot-use-caption-under-minipage
\usepackage{capt-of}

% Custom list throw LaTeX Error: Command \mycustomfiction already defined?
% https://tex.stackexchange.com/questions/388489/custom-list-throw-latex-error-command-mycustomfiction-already-defined
\usepackage{morewrites}

% https://tex.stackexchange.com/questions/505351/how-to-nameref-multiple-labels-simultaneously
% http://mirror.las.iastate.edu/tex-archive/macros/latex/contrib/l3kernel/expl3.pdf
\ExplSyntaxOn

% #1: variant (cref, Cref, crefs or Crefs)
% #2: reference name (label)
\cs_new_protected:Npn \user_name_cref:nn #1#2
  { \use:c { name #1 } {#2} }

\cs_generate_variant:Nn \user_name_cref:nn { xV }

% #1: boolean expression (true: disable hyperlink)
% #2: reference name (label)
\cs_new_protected:Npn \user_name_ref:nn #1#2
  { \bool_if:nTF {#1} { \nameref* } { \nameref } {#2} }

\cs_generate_variant:Nn \user_name_ref:nn { nV }

\seq_new:N \l__user_name_refs_tmpa_seq
\seq_new:N \l__user_name_refs_tmpb_seq
\int_new:N \l__user_name_refs_nbrefs_int
\tl_new:N \l__user_name_refs_firstref_tl

% #1: boolean expression (true: Does put the label name, i.e., Figure My Figure)
% #2: boolean expression (true: start with capitalized letter, as in \Cref)
% #3: boolean expression (true: disable hyperlinks)
% #4: comma list of refs
\cs_new_protected:Npn \user_name_refs:nnnn #1#2#3#4
  {
    \seq_set_from_clist:Nn \l__user_name_refs_tmpa_seq {#4}
    \int_set:Nn \l__user_name_refs_nbrefs_int
                { \seq_count:N \l__user_name_refs_tmpa_seq }
    \seq_get_left:NN \l__user_name_refs_tmpa_seq \l__user_name_refs_firstref_tl

    \bool_if:nTF {#1}
    {
      % (section, Section, sections or Sections) or (theorem, Theorem, ...) or...
      \user_name_cref:xV
        { \bool_if:nTF {#2} { C } { c }
          ref
         \int_compare:nNnTF { \l__user_name_refs_nbrefs_int } > { 1 } { s } { } }
       \l__user_name_refs_firstref_tl
      \nobreakspace
    }{}

    % Now print the references.
    \seq_clear:N \l__user_name_refs_tmpb_seq
    \seq_map_inline:Nn \l__user_name_refs_tmpa_seq
      {
        \seq_put_right:Nn \l__user_name_refs_tmpb_seq
                          { \user_name_ref:nn {#3} {##1} }
      }
    \seq_use:Nnnn \l__user_name_refs_tmpb_seq { \crefpairconjunction }
                  { \crefmiddleconjunction } { \creflastconjunction }
  }

\cs_generate_variant:Nn \user_name_refs:nnnn { nx }
\cs_generate_variant:Nn \user_name_refs:nnnn { nnxn }

\cs_new_protected:Npn \__user_name_refs:NNnn #1#2#3#4
  {
    \user_name_refs:nnxn {#1}
      {#2}
      { \IfBooleanTF {#3} { \c_true_bool } { \c_false_bool } }
      {#4}
  }

% “Start in lower case” variant.
% Does put the label name, i.e., Figure My Figure.
% With star: disable hyperlinks.
% #2: comma list of refs
\NewDocumentCommand \namerefs { s m }
  {
    \__user_name_refs:NNnn \c_true_bool \c_false_bool {#1} {#2}
  }

% “Start in upper case” variant.
% Does put the label name, i.e., Figure My Figure.
% With star: disable hyperlinks.
% #2: comma list of refs
\NewDocumentCommand \Namerefs { s m }
  {
    \__user_name_refs:NNnn \c_true_bool \c_true_bool {#1} {#2}
  }

% “Start in lower case” variant.
% Does not put the label name, i.e., My Figure.
% With star: disable hyperlinks.
% #2: comma list of refs
\NewDocumentCommand \nameRefs { s m }
  {
    \__user_name_refs:NNnn \c_false_bool \c_false_bool {#1} {#2}
  }

\ExplSyntaxOff

% https://tex.stackexchange.com/questions/62611/how-to-make-ref-references-include-the-word-figure
% https://tex.stackexchange.com/questions/121865/nameref-how-to-display-section-name-and-its-number
% https://tex.stackexchange.com/questions/95663/several-nameref-and-page-margins
% https://tex.stackexchange.com/questions/515864/how-can-i-make-hyperref-stop-thinking-there-are-undefined-references
% https://tex.stackexchange.com/questions/519577/cleveref-capitalise-option-not-working-with-babel-translations
\usepackage[nameinlink,capitalise,noabbrev]{cleveref}
\newcommand*{\typeref}[1]{\Cref{#1}}
\newcommand*{\fullref}[1]{\Cref{#1}: \nameRefs{#1}}

% https://tex.stackexchange.com/questions/329631/creating-new-captions-and-caption-counters
\def\listofquadrosname{List of Frames}
\def\quadrosname{Frame}

\DeclareFloatingEnvironment[fileext=loq,placement={!hbtp},name=\quadrosname,within=chapter,listname=\listofquadrosname]{quadro}

\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\renewcommand{\quadrosname}{Quadro}}}{}}{}
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\renewcommand{\listofquadrosname}{Lista de Quadros}}}{}}{}

% Create cleveref names for quadro environment captions
% https://github.com/abntex/abntex2/issues/176
% https://tex.stackexchange.com/questions/502367/how-to-add-babel-translations-to-cleveref-based-cross-references-to-my-custom-fl
% https://tex.stackexchange.com/questions/430498/here-is-another-example-where-cleveref-does-not-capitalize-when-it-should
\crefname{quadro}{frame}{frames}
\Crefname{quadro}{Frame}{Frames}
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\crefname{quadro}{quadro}{quadros}}}{}}{}
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\Crefname{quadro}{Quadro}{Quadros}}}{}}{}

% fix fig. being used instead of figure
% https://tex.stackexchange.com/questions/519577/cleveref-capitalise-option-not-working-with-babel-translations
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\crefname{figure}{Figura}{Figuras}}}{}}{}
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\Crefname{figure}{Figura}{Figuras}}}{}}{}

\@ifpackageloaded{babel}{\@ifpackagewith{babel}{english}{\addto\captionsenglish{\crefname{figure}{figure}{figures}}}{}}{}
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{english}{\addto\captionsenglish{\Crefname{figure}{Figure}{Figures}}}{}}{}

% Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% https://tex.stackexchange.com/questions/18931/memoir-class-with-subcaption-and-hyperref-packages
%
% \captionsetup[table]{
%   %  name=Tabela,
%   %  listformat=empty,
%   %  justification=justified,
%   %  labelsep=colon,
%   %   position=above,
%   %   skip=\onelineskip,
%   %  width=\linewidth,
%   labelfont={normalsize},
%   textfont={small},
%   font={normalsize}
% }

% Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% https://tex.stackexchange.com/questions/18931/memoir-class-with-subcaption-and-hyperref-packages
%
% \captionsetup[figure]{
%   %  name=Tabela,
%   %  listformat=empty,
%   %  justification=justified,
%   %  labelsep=colon,
%   %   position=above,
%   %   skip=\onelineskip,
%   %  width=\linewidth,
%   labelfont={normalsize},
%   textfont={small},
%   font={normalsize}
% }

% https://tex.stackexchange.com/questions/479086/styling-and-spacing-around-float-caption-for-listing
% https://tex.stackexchange.com/questions/97673/merge-items-in-list-of-floats
% https://tex.stackexchange.com/questions/23313/how-can-i-reduce-padding-after-figure
% https://tex.stackexchange.com/questions/515157/package-caption-warning-the-caption-type-was-already-set-to-quadro-on-input
\AtBeginEnvironment{quadro}{
  \captionsetup{skip=5pt,belowskip=0pt}
}

% https://tex.stackexchange.com/questions/26220/control-spacing-around-table-caption
\captionsetup[figure]{belowskip=5pt,aboveskip=5pt}

\@ifclassloaded{memoir}{%
  % https://tex.stackexchange.com/questions/176418/remove-list-of-newfloat-from-toc
  \newcommand{\AdjustForMemoir}[1]{%
  \csletcs{kept@listof#1}{listof#1}%
  \csdef{listof#1}{%
    \@ifstar
     {\csappto{newfloat@listof#1@hook}{\append@star}%
    \csuse{kept@listof#1}}%
     {\csuse{kept@listof#1}}%
  }
  }
  \def\append@star#1{#1*}
  \AdjustForMemoir{quadro}
  \newlistentry{quadro}{loq}{0}

  % https://tex.stackexchange.com/questions/514996/how-to-have-a-dynamic-cft-numwidth-i-e-accordingly-to-the-number-size
  \newlength\cftquadrooldnumwidth
  \setlength\cftquadrooldnumwidth{\cftquadronumwidth}

  % Calculate the size of the header
  % https://tex.stackexchange.com/questions/7453/what-is-the-use-of-percent-signs-at-the-end-of-lines
  \newcommand{\calculatelquadrosheader}{%
    \renewcommand\cftquadropresnum{\quadrosname~}%

    % https://tex.stackexchange.com/questions/52861/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cftquadroinitialnumwidth
    \settowidth\cftquadroinitialnumwidth{\cftquadropresnum\cftquadroaftersnum ab}%
    \setlength\cftquadronumwidth{\dimexpr\cftquadrooldnumwidth+\cftquadroinitialnumwidth}%
    \renewcommand\cftquadroaftersnum{\hfill\textendash\hfill}%
  }

  % https://tex.stackexchange.com/questions/14135/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculatelquadrosheader}

  % https://tex.stackexchange.com/questions/514996/how-to-have-a-dynamic-cft-numwidth-i-e-accordingly-to-the-number-size
  \newlength\cftfigureoldnumwidth
  \setlength\cftfigureoldnumwidth{\cftfigurenumwidth}

  % Calculate the size of the header
  % https://tex.stackexchange.com/questions/7453/what-is-the-use-of-percent-signs-at-the-end-of-lines
  % https://tex.stackexchange.com/questions/12865/list-of-figures-how-to-add-caption-label
  \newcommand{\calculatelfigureheader}{%
    % https://tex.stackexchange.com/questions/52861/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cftfigureinitialnumwidth
    \settowidth\cftfigureinitialnumwidth{\cftfigurepresnum\cftfigureaftersnum a}%
    \setlength\cftfigurenumwidth{\dimexpr\cftfigureoldnumwidth+\cftfigureinitialnumwidth}%
    \renewcommand\cftfigureaftersnum{\hfill\textendash\hfill}%
  }

  % https://tex.stackexchange.com/questions/14135/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculatelfigureheader}

  % https://tex.stackexchange.com/questions/514996/how-to-have-a-dynamic-cft-numwidth-i-e-accordingly-to-the-number-size
  \newlength\cfttableoldnumwidth
  \setlength\cfttableoldnumwidth{\cfttablenumwidth}

  % Calculate the size of the header
  % https://tex.stackexchange.com/questions/7453/what-is-the-use-of-percent-signs-at-the-end-of-lines
  \newcommand{\calculateltableheader}{%
    % https://tex.stackexchange.com/questions/52861/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cfttableinitialnumwidth
    \settowidth\cfttableinitialnumwidth{\cfttablepresnum\cfttableaftersnum a}%
    \setlength\cfttablenumwidth{\dimexpr\cfttableoldnumwidth+\cfttableinitialnumwidth}%
    \renewcommand\cfttableaftersnum{\hfill\textendash\hfill}%
  }

  % https://tex.stackexchange.com/questions/14135/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculateltableheader}

  % http://tex.stackexchange.com/questions/228936/setting-entries-of-list-of-listings-in-latex-package-listings
  % https://tex.stackexchange.com/questions/223079/you-cant-use-a-prefix-with-charfb-error-when-importing-csv-into-latex
  % https://tex.stackexchange.com/questions/485830/why-latex-does-not-tell-me-which-command-is-undefined
  \@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\renewcommand{\lstlistingname}{Código}}}{}}{}
  \@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\renewcommand{\lstlistlistingname}{Lista de Códigos}}}{}}{}

  \@ifpackageloaded{babel}{\@ifpackagewith{babel}{english}{\addto\captionsenglish{\renewcommand{\lstlistingname}{Code}}}{}}{}
  \@ifpackageloaded{babel}{\@ifpackagewith{babel}{english}{\addto\captionsenglish{\renewcommand{\lstlistlistingname}{List of Codes}}}{}}{}

  \@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\crefname{listing}{código}{códigos}}}{}}{}
  \@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{\Crefname{listing}{Código}{Códigos}}}{}}{}

  \begingroup
    \let\newcounter\@gobble\let\setcounter\@gobbletwo
    \globaldefs\@ne \let\c@loldepth\@ne
    \newlistof{listings}{lol}{\lstlistlistingname}
    \newlistof{lstlistoflistings}{lol}{\lstlistlistingname}
    \newlistentry{lstlisting}{lol}{0}
  \endgroup

  % https://tex.stackexchange.com/questions/388411/why-the-empty-space-size-is-increasing-each-call
  \newlength\cftlstlistingoldnumwidth
  \setlength\cftlstlistingoldnumwidth{\cftlstlistingnumwidth}

  % Calculate the size of the header
  % https://tex.stackexchange.com/questions/7453/what-is-the-use-of-percent-signs-at-the-end-of-lines
  \newcommand{\calculatelstlistingsheader}{%
    \renewcommand\cftlstlistingpresnum{\lstlistingname~}%

    % https://tex.stackexchange.com/questions/52861/what-is-the-plain-tex-equivalent-of-settowidth
    \newlength\cftlstlistinginitialnumwidth
    \settowidth\cftlstlistinginitialnumwidth{\cftlstlistingpresnum\cftlstlistingaftersnum ab}%
    \setlength\cftlstlistingnumwidth{\dimexpr\cftlstlistingoldnumwidth+\cftlstlistinginitialnumwidth+2pt}%
    \renewcommand\cftlstlistingaftersnum{\hfill\textendash\hfill}%
  }

  % https://tex.stackexchange.com/questions/14135/how-to-automatically-add-text-immediately-after-begindocument
  \AtBeginDocument{\calculatelstlistingsheader}
}{}

% https://tex.stackexchange.com/questions/234398/list-of-figures-and-tables-when-there-are-no-figures-or-tables
% https://tex.stackexchange.com/questions/515759/why-pdfbookmark-keeps-adding-to-the-pdf-bookmarks-while-addcontentslinetoc-d
% https://tex.stackexchange.com/questions/515815/how-to-stop-newsavebox-giving-me-bad-boxes-warnings-or-how-to-use-better-names
% https://tex.stackexchange.com/questions/515811/how-memoir-prints-the-titles-of-the-content-pages
\newcommand{\whenlistisnotempty}[3]{
  \setbox0\vbox{#2}%
  \typeout{The height of the list '#1' is '\the\ht0'}%
  \ifdim\ht0>35pt%
    #3%
    \unvbox0%
  \fi%
}


\ifAppMotherFuckerExists
  % https://tex.stackexchange.com/questions/57353/how-to-get-caption-above-listing-with-minted
  % https://tex.stackexchange.com/questions/339931/latex-minted-package-using-custom-output-directory-build
  % https://tex.stackexchange.com/questions/223079/you-cant-use-a-prefix-with-charfb-error-when-importing-csv-into-latex
  \usepackage[newfloat,chapter,outputdir=latexcache]{minted}

  % https://tex.stackexchange.com/questions/35546/minted-setstretch-and-font-size
  % https://tex.stackexchange.com/questions/484788/how-to-change-overall-font-size-of-minted
  \setminted{fontsize=\small,fontfamily=zi4,linenos=true,numberblanklines=true,breaklines=true,breakanywhere=true}

  % https://stackoverflow.com/questions/3245007/how-to-change-the-font-size-of-line-numbers-using-the-minted-latex-package
  \renewcommand\theFancyVerbLine{\normalsize\color{gray}\arabic{FancyVerbLine}}

  % https://tex.stackexchange.com/questions/320185/adjust-vertical-spacing-between-caption-and-listing-in-koma-scrartcl
  % https://tex.stackexchange.com/questions/514835/how-to-replace-a-command-argument-as-2-with-something-else
  % https://tex.stackexchange.com/questions/514715/how-to-fix-minted-and-listings-hyphen-alignment-on-my-list-of-codes
  % https://tex.stackexchange.com/questions/269491/mixing-minted-with-lstlisting
  % https://tex.stackexchange.com/questions/26220/control-spacing-around-table-caption
  % https://tex.stackexchange.com/questions/515220/how-to-set-minted-listing-table-of-contents-numwidth/
  % https://tex.stackexchange.com/questions/27645/customizing-the-list-of-listings-generated-by-lstlistoflistings
  % https://tex.stackexchange.com/questions/228936/setting-entries-of-list-of-listings-in-latex-package-listings
  \newenvironment{code}{
  \captionsetup{type=lstlisting,skip=0pt,position=top}
  \setlength{\abovecaptionskip}{0pt}
  \setlength{\belowcaptionskip}{10pt}
  \setlength{\parskip}{0pt}
  }{}

  % https://tex.stackexchange.com/questions/14166/red-box-drawn-around-question-mark-operator-in-minted-erlang-code
  \AtBeginEnvironment{code}{\renewcommand{\fcolorbox}[4][]{#4}}
\else\fi


% Memoir class conflict with datetime
% https://tex.stackexchange.com/questions/162353/memoir-class-conflict-with-datetime
% https://tex.stackexchange.com/questions/49071/difference-between-let-foo-relax-and-def-foo-for-disabling
\let\ordinal\relax
\usepackage{datetime}

% % 'export' allows adjustbox keys in \includegraphics
% https://tex.stackexchange.com/questions/86350/includegraphics-maximum-width
\usepackage[export]{adjustbox}

% ufscthesis start, https://github.com/UFSC/ufscthesisx/issues/19
\RequirePackage{helvet}

% https://tex.stackexchange.com/questions/28019/continuous-numbering-of-figures-and-tables
% https://tex.stackexchange.com/questions/28333/continuous-v-per-chapter-section-numbering-of-figures-tables-and-other-docume
\usepackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{quadro}{chapter}
\counterwithout{equation}{chapter}

% https://tex.stackexchange.com/questions/45338/chngcntr-counterwithout-not-working
% https://tex.stackexchange.com/questions/316230/number-listings-the-same-way-as-figures-and-tables
\AtBeginDocument{\counterwithout{lstlisting}{chapter}}

% https://tex.stackexchange.com/questions/557099/class-memoir-error-listing-is-not-a-counter
\ifAppMotherFuckerExists
  \AtBeginDocument{\counterwithout{listing}{chapter}}
\else\fi

% Permite tamanhos arbitrários para fontes Computer Modern (math warning)
\RequirePackage{fix-cm}

% Package xkeyval Error: <key> undefined in families `blx@lbx'.
% https://github.com/plk/biblatex/issues/628
\NewBibliographyString{sineloco}
\NewBibliographyString{sinenomine}
\NewBibliographyString{andothers}
\NewBibliographyString{in}

\DefineBibliographyStrings{brazil}{%
  sineloco     = {\mkbibemph{S\adddot l\adddot}},
  sinenomine   = {\mkbibemph{s\adddot n\adddot}},
  andothers    = {\mkbibemph{et\addabbrvspace al\adddot}},
  in           = {\mkbibemph{In:}}
}

% ---
% Posiciona figuras e tabelas no topo da página quando adicionadas sozinhas
% em um página em branco. Ver https://github.com/abntex/abntex2/issues/170
% ---
\setlength{\@fptop}{5pt} % Set distance from top of page to first float

% https://tex.stackexchange.com/questions/163479/glossaries-conflict-with-memoir
\let\printglossary\relax
\let\theglossary\relax
\let\endtheglossary\relax

\RequirePackage[%
  subentrycounter,
  seeautonumberlist,
  nonumberlist,
  nogroupskip,
  nomain,
  shortcuts,   % criação de atalhos
  acronym,  % criação de acrônimos
  translate=babel, % Faz o papel de \providetranslation
  nopostdot  % Não é colocado ponto ao final da entrada
  ]{glossaries}

% Só dá entrada na lista. Ainda não funciona com o limarka
% Retira o espaço do pacote glossaries
\renewcommand{\glossarypreamble}{\vspace{-0.2cm}}

\providecommand{\imprimirnivel}{}
\newcommand{\nivel}[1]{\renewcommand{\imprimirnivel}{#1}}

% Criação de estilo
\newglossarystyle{mylong1}{% modificado de https://tex.stackexchange.com/a/166209/151962
  \setglossarystyle{long}%
  \renewenvironment{theglossary}%
  {\begin{longtable}[l]{@{}p{\dimexpr 3.0cm-\tabcolsep}p{0.78\hsize}}}% <-- change the value here
  {\end{longtable}}%
}

% Só um pequeno récuo em relação ao primeiro
\newglossarystyle{mylong2}{% modificado de https://tex.stackexchange.com/a/166209/151962
  \setglossarystyle{long}%
  \renewenvironment{theglossary}%
  {\begin{longtable}[l]{@{}p{\dimexpr 2.0cm-\tabcolsep}p{0.86\hsize}}}% <-- change the value here
  {\end{longtable}}%
}

% Só dá entrada na lista. Ainda não funciona com o limarka
\newcommand{\siglalista}[2]{\newacronym{#1}{#1}{#2}}

% https://tex.stackexchange.com/questions/426010/printnoidxglossaries-vs-printglossaries
\newglossary{simbolos}{simbolos}{sbl}{simbolos}

% Só dá entrada na lista. Ainda não funciona com o limarka
% https://tex.stackexchange.com/questions/426010/printnoidxglossaries-vs-printglossaries
\newcommand{\simbololista}[3]{\newglossaryentry{#1}{%
  type=simbolos,
  name=#2,
  description=#3}}

% imprime lista de siglas ordenado alfabeticamente
% https://tex.stackexchange.com/questions/426010/printnoidxglossaries-vs-printglossaries
\newcommand{\imprimirlistadesiglas}{%
  \pdfbookmark[0]{\listadesiglasname}{acn}
  \printnoidxglossary[
  style=mylong1,
  type=acronym,
  sort=letter,
  title={\listadesiglasname\vspace{-0.2cm}}
  ]
  \cleardoublepage
}

% imprime lista de símbolos na ordem em que aparece no texto
% https://tex.stackexchange.com/questions/426010/printnoidxglossaries-vs-printglossaries
\newcommand{\imprimirlistadesimbolos}{%
  \pdfbookmark[0]{\listadesimbolosname}{sbl}
  \printnoidxglossary[
  style=mylong2,
  type=simbolos,
  sort=use,
  title={\listadesimbolosname}
  ]
  \cleardoublepage
}

% imprime glossário
% https://tex.stackexchange.com/questions/426010/printnoidxglossaries-vs-printglossaries
\newcommand{\imprimirglossario}{
  \cleardoublepage
  \pdfbookmark[0]{\glossaryname}{glo}
  \printnoidxglossary[
  type=main,
  sort=use,
  title={\glossaryname}
  ]
}
% ufscthesis end, https://github.com/UFSC/ufscthesisx/issues/19


% Package csquotes Warning: Load 'inputenc' before 'csquotes'
% Package biblatex Warning: 'babel/polyglossia' detected but 'csquotes' missing
% https://tex.stackexchange.com/questions/229638/package-biblatex-warning-babel-polyglossia-detected-but-csquotes-missing
\usepackage{csquotes}

% Indent the first section paragraphs
% https://tex.stackexchange.com/questions/39227/no-indent-in-the-first-paragraph-in-a-section
\usepackage{indentfirst}

% Why the environment ttfamily is hyphenated, but macro ttfamily is not hyphenating?
% https://tex.stackexchange.com/questions/387678/why-the-environment-ttfamily-is-hyphenated-but-macro-ttfamily-is-not-hyphenatin
\usepackage{letltxmacro}

% Theorem packages: which to use, which conflict?
% https://tex.stackexchange.com/questions/5599/theorem-packages-which-to-use-which-conflict
\usepackage{amsthm}

% Why is the ifthen package obsolete? (It is used by the abntex2 class)
% https://tex.stackexchange.com/questions/13866/why-is-the-ifthen-package-obsolete
\usepackage{ifthen}

% How to make section name uppercase in ToC?
% https://tex.stackexchange.com/questions/156916/how-to-make-section-name-uppercase-in-toc
\usepackage{textcase}

% The class memoir already provides these functionalities: Caption package and Memoir
% https://groups.google.com/forum/#!topic/comp.text.tex/RzpI2ATMev0
% https://tex.stackexchange.com/questions/18931/memoir-class-with-subcaption-and-hyperref-packages
% \usepackage{subfig}
% \usepackage{etoolbox}
%
% How to create my own caption type with \DeclareCaptionType on memoir class?
% https://tex.stackexchange.com/questions/391901/how-to-create-my-own-caption-type-with-declarecaptiontype-on-memoir-class
\usepackage{caption}

% The package `layouts` causes the: Warning: layout scale set to 0.5 on input line
% https://tex.stackexchange.com/questions/299372/warning-layout-scale-set-to-0-5-on-input-line
% \usepackage{layouts}

% Always use it as should improve full justification
% https://tex.stackexchange.com/questions/10377/texttt-overfull-hbox-problem
% https://tex.stackexchange.com/questions/66052/should-i-load-microtype-with-pdflatex
\usepackage[factor=1100,stretch=10,shrink=10]{microtype}

% https://tex.stackexchange.com/questions/482886/how-to-add-babel-captions-to-newfloat-package-environments
\usepackage{newfloat}

% How to auto adjust my last table column width, and why is there Underfull \vbox badness on this table?
% https://tex.stackexchange.com/questions/387238/how-to-auto-adjust-my-last-table-column-width-and-why-is-there-underfull-vbox/387251
%
% Why ltablex package breaks the changepage package?
% https://tex.stackexchange.com/questions/404339/why-ltablex-package-breaks-the-changepage-package
\usepackage{ltablex}\keepXColumns

% Para incluir links com characteres especiais como # em URLs em `\footnote`
% https://tex.stackexchange.com/questions/12855/getting-those-signs-in-the-footnote
% https://tex.stackexchange.com/questions/299348/animate-gives-errors-when-i-also-use-bigfoot-or-cprotect
%
% Adding this will cause the warning``bigfoot.sty:61: Package hyperref Warning:
% Option `hyperfootnotes' has 1`hyperfootnotes' has already been used
% https://tex.stackexchange.com/questions/402652/bigfoot-sty61-package-hyperref-warning-option-hyperfootnotes-has-already-be
\let\truehypersetup\hypersetup
\renewcommand\hypersetup[1]{}
\usepackage{bigfoot}
\let\hypersetup\truehypersetup

% While loading fancyvrb, siunitx and bigfoot, I got input stack size=5000, TeX STOPPED: fatal errors occurred
% https://tex.stackexchange.com/questions/403651/while-loading-fancyvrb-siunitx-and-bigfoot-i-got-input-stack-size-5000-tex-st
\xpatchcmd{\FN@allmarks}{266}{256}{}{}















%% README.md
%% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`



%
% Settings
%

% Basic settings for hyperref package
\hypersetup{colorlinks,linkcolor=darkblue,citecolor=darkgreen}



% https://tex.stackexchange.com/questions/511589/how-to-fix-useshorthands-defineshorthand-usage-on-bookmark-entries
\def\HyPsd@LetUnexpandableSpace#1{%
  \if\noexpand~\noexpand#1%
  \else
  \expandafter\@firstofone
  \fi{\expandafter\futurelet\expandafter#1\expandafter\@gobble\space\relax}}



% How could the `\everypar` justification statement be used?
% https://tex.stackexchange.com/questions/365818/how-could-the-everypar-justification-statement-be-used
\newbox\linebox \newbox\snapbox
\def\eatlines
{%
  \setbox\linebox\lastbox % check the last line
  \ifvoid\linebox
  \else % if it’s not empty
    \unskip\unpenalty % take whatever is
    {\eatlines} % above it;
    \setbox\snapbox\hbox{\unhcopy\linebox}
    \ifdim\wd\snapbox<.98\wd\linebox
      \box\snapbox % take the one or the other,
    \else \box\linebox \fi
  \fi
}



% How could the `\everypar` justification statement be used?
% https://tex.stackexchange.com/questions/365818/how-could-the-everypar-justification-statement-be-used
\everypar=
{%
  \setbox0=\lastbox \par%
  \vbox\bgroup \everypar={}\def\par{\endgraf\eatlines\egroup}%
}

% Creates a new environment which can be used as:
%
% \begin{foo}
%   Text...
%
%   Text ...
% \end{foo}
%
% https://tex.stackexchange.com/questions/62333/push-long-words-in-a-new-line
\newenvironment{foo}
{%
  \par%
  \hyphenpenalty=10000%
  \exhyphenpenalty=10000%
}
{\par}



% Some text \brkurl{http://www.example.com/this/directory/here}
%
% How to break long URLs using common hyphenation but adding a line feed indicator?
% https://tex.stackexchange.com/questions/69824/how-to-break-long-urls-using-common-hyphenation-but
\def\addurlspace#1
{%
  \ifx\relax#1%
  \else%
  \ifx/#1\space\fi%
  \ifx.#1\space\fi%
  #1%
  \ifx/#1\space\fi%
  \ifx.#1\space\fi%
  \expandafter\addurlspace%
  \fi%
}

\@namedef{OT1-zwidthchar}{255}
\@namedef{T1-zwidthchar}{"17}

\def\brkurl#1
{%
  \edef\savedhchar{\the\hyphenchar\font}%
  \global\setbox1\hbox{}%
  \setbox0=\vbox
  {%
    \hsize=2pt\rightskip=0pt plus 1fill%
    \hfuzz\maxdimen%
    \tracinglostchars0%
    \overfullrule0pt%
    \hyphenchar\font=\csname \f@encoding-zwidthchar\endcsname%
    \noindent \hskip0pt \addurlspace #1\relax%
    \par%
    \loop%
    \setbox4 \lastbox%
    \ifvoid4 \else%
    \global\setbox1\hbox%
    {%
      \unhbox4\unskip\unskip\discretionary{\hbox{\rlap{$\leftarrow$}}}{}{}\unhbox1%
    }%
    \unskip%
    \unskip%
    \unpenalty%
    \unskip%
    \repeat%
  }%
  \unhbox1%
  \hyphenchar\font\savedhchar%
  \relax%
}



% Change background color for text block
% https://tex.stackexchange.com/questions/238294/change-background-color-for-text-block
\usepackage{framed}
\usepackage[most]{tcolorbox}
\definecolor{shadecolor}{RGB}{219, 229, 241}
\newtcolorbox{bluebox}
{%
  colback=shadecolor,
  grow to right by=8mm,
  grow to left by=8mm,
  boxrule=0pt,
  boxsep=0pt,
  unbreakable,
}



% Make first row of table all bold
%
% Usage:
% 1. Add `B` on the borders and `^` before each column definition.
% 2. `\rowstyle{\bfseries}` before the row you want to bold.
%
% Example:
% \begin{tabularx}{\linewidth}
% {|
%     *1{                 >{\RaggedRight\arraybackslash\hsize=1.1\hsize }BX       |} % Riscos
%     *3{@{\hspace{3.0pt}}>{\Centering\arraybackslash                   }^p{0.9cm}|} % Probabilidade, Impacto, Prioridade
%     *2{                 >{\RaggedRight\arraybackslash\hsize=0.95\hsize}^X       |} % Resposta, Prevenção
% }
%
% \hline
%
% \rowstyle{\bfseries}
% Riscos  & 1 & 2 & 3 & Estratégia de resposta & Ações de prevenção \\ \hline
%
%
% https://tex.stackexchange.com/questions/4811/make-first-row-of-table-all-bold
\usepackage{array}
\newcolumntype{B}{>{\global\let\currentrowstyle\relax}}
\newcolumntype{^}{>{\currentrowstyle}}
\newcommand{\rowstyle}[1]
{%
  \gdef\currentrowstyle{#1}#1\ignorespaces
}


% https://tex.stackexchange.com/questions/485834/why-abntex2-class-is-inserting-a-new-line-after-the-chapter-title
% https://tex.stackexchange.com/questions/367859/how-to-automatically-put-a-go-to-summary-go-back-on-each-section
% https://tex.stackexchange.com/questions/388045/how-can-the-go-to-summary-be-fixed-so-the-sectionsomesome-more
% https://tex.stackexchange.com/questions/399635/what-is-the-equivalent-to-sectionformat-on-memoir-class-for-chapterformat
% https://tex.stackexchange.com/questions/485857/why-xapptocmd-is-reducing-the-vertical-space-between-partname-and-parttile
\definecolor{ultramarine}{RGB}{0,32,96}
\RequirePackage{xpatch}

% https://tex.stackexchange.com/questions/113147/patching-arguments-inside-a-macro
\tracingpatches

\RequirePackage{amssymb}
\RequirePackage{hyperref}
\newcommand{\goToSummaryText}{{%
  \small\mdseries
  \hyperlink{summary}{\textcolor{ultramarine}{$\leftleftarrows$}}
  {$|$}
  \Acrobatmenu{GoBack}{\textcolor{ultramarine}{$\leftarrow$}}
}}

\newif\ifismemoirloaded\ismemoirloadedfalse
\newif\ifisabntexloaded\isabntexloadedfalse
\@ifclassloaded{memoir}{%
  \ismemoirloadedtrue%
}{}
\@ifclassloaded{setup/abntex2}{%
  \isabntexloadedtrue%
}{}

\newcommand{\addGoToSummary}
{%
  \@ifundefined{printparttitle}{\message{printparttitle patch for addGoToSummary could NOT
        be applied because there is no printparttitle command available!^^J}}{%
    \let\oldAddGoToprintparttitle\printparttitle
    \xapptocmd{\printparttitle}{~\protect\goToSummaryText}{}{}
  }
  \@ifundefined{Sectionformat}{\message{Sectionformat patch for addGoToSummary could NOT
        be applied because there is no Sectionformat command available!^^J}}{%
    \let\oldAddGoToSectionformat\Sectionformat
    \xapptocmd{\Sectionformat}{~\protect\goToSummaryText}{}{}
  }

  \ifismemoirloaded
    \ifisabntexloaded
      \let\oldAddGoToABNTEXchapterupperifneeded\ABNTEXchapterupperifneeded
      \xapptocmd{\ABNTEXchapterupperifneeded}{~\protect\goToSummaryText}{}{}
    \else
      \let\oldAddGoToprintchaptertitle\printchaptertitle
      \xapptocmd{\printchaptertitle}{~\protect\goToSummaryText}{}{}
    \fi
  \else
    \@ifundefined{Chapterformat}{\message{Chapterformat patch for addGoToSummary could NOT
          be applied because there is no Chapterformat command available!^^J}}{%
      \let\oldAddGoToChapterformat\Chapterformat
      \xapptocmd{\Chapterformat}{~\protect\goToSummaryText}{}{}
    }
  \fi
}

\newcommand{\removeGoToSummary}
{%
  \@ifundefined{oldAddGoToprintparttitle}{}{\let\printparttitle\oldAddGoToprintparttitle}
  \@ifundefined{oldAddGoToSectionformat}{}{\let\Sectionformat\oldAddGoToSectionformat}

  \ifismemoirloaded
    \ifisabntexloaded
      \@ifundefined{oldAddGoToABNTEXchapterupperifneeded}{}{\let\ABNTEXchapterupperifneeded\oldAddGoToABNTEXchapterupperifneeded}
    \else
      \@ifundefined{oldAddGoToprintchaptertitle}{}{\let\printchaptertitle\oldAddGoToprintchaptertitle}
    \fi
  \else
    \@ifundefined{oldAddGoToChapterformat}{}{\let\Chapterformat\oldAddGoToChapterformat}
  \fi
}

\let\oldAddGoTotableofcontents\tableofcontents
% Insert internal document link
\renewcommand{\tableofcontents}{%
  \hypertarget{summary}%
  \oldAddGoTotableofcontents%
}



%
% New commands
%

% Allow to push long words on new lines when they do not fit entirely on the current line.
% https://tex.stackexchange.com/questions/62333/push-long-words-in-a-new-line
\newcommand\lword[1]{\leavevmode\nobreak\hskip0pt plus\linewidth\penalty50\hskip0pt plus-\linewidth\nobreak{#1}}
\newcommand\lurl[1]{\leavevmode\nobreak\hskip0pt plus\linewidth\penalty50\hskip0pt plus-\linewidth\nobreak{\url{#1}}}


% For the new command \latex
% https://tex.stackexchange.com/questions/31091/space-after-latex-commands
\usepackage{xspace}

% Write the word LaTeX nicely.
\newcommand{\latex}{\LaTeX\xspace}

% Create a bold title all in upper case.
\newcommand{\Title}[1]{\textbf{\MakeUppercase{#1}}}



% How to create my own list of things
% https://tex.stackexchange.com/questions/61086/how-to-create-my-own-list-of-things
\newcommand{\mytextpreliminarylistname}{Short Table of Contents}
\newlistof{textpreliminarycontents}{tpc}{\mytextpreliminarylistname}

% Resetting counter
% https://tex.stackexchange.com/questions/66604/resetting-counter
%
% Custom list throw LaTeX Error: Command \mycustomfiction already defined?
% https://tex.stackexchange.com/questions/388489/custom-list-throw-latex-error-command-mycustomfiction-already-defined
\newlistentry{textpreliminarycounter}{tpc}{0}

% Continuing Page Numbering (Roman to Arabic)
% https://tex.stackexchange.com/questions/56131/continuing-page-numbering-roman-to-arabic
\renewcommand{\thetextpreliminarycounter}{\arabic{textpreliminarycounter}}

% Reset section numbering between unnumbered chapters
% https://tex.stackexchange.com/questions/71162/reset-section-numbering-between-unnumbered-chapters
\newcommand{\addtotextpreliminarycontent}[1]
{%
  \refstepcounter{textpreliminarycounter}%
  \addcontentsline{tpc}{textpreliminarycounter}{\protect\numberline{\thetextpreliminarycounter}#1}\par%
}



% Unable to link to inserted pages with pdfpages
% Solution from http://tex.stackexchange.com/questions/25105/unable-to-link-to-inserted-pages-with-pdfpages
\newcounter{includepdfpage}
\newcounter{currentpagecounter}

\newcommand{\addlabelstoallincludedpages}[1]
{%
  \refstepcounter{includepdfpage}%
  \stepcounter{currentpagecounter}%
  \label{#1.\thecurrentpagecounter}%
}
\newcommand{\modifiedincludepdf}[4]
{%
  \setcounter{currentpagecounter}{0}%
  \includepdf[pages=#1,pagecommand=\addlabelstoallincludedpages{#2},scale=#4]{#3}%
}



% \MakeUppercase in \section and \chapter with hyperref cause trouble
% https://tex.stackexchange.com/questions/199374/makeuppercase-in-section-and-chapter-with-hyperref-cause-trouble
\newcommand{\HyperrefUppercase}[1]{\texorpdfstring{\MakeTextUppercase{#1}}{#1}}



% Example about hyphenation with ttfamily font
% https://tex.stackexchange.com/questions/386665/example-about-hyphenation-with-ttfamily-font
%
% Why the environment ttfamily is hyphenated, but macro ttfamily is not hyphenating?
% https://tex.stackexchange.com/questions/387678/why-the-environment-ttfamily-is-hyphenated-but-macro-ttfamily-is-not-hyphenatin
\LetLtxMacro\origttfamily\ttfamily
\DeclareRobustCommand*{\ttfamily}
{%
  \origttfamily
  \hyphenchar\font=`\-\relax
  \fontdimen3\font=.25em\relax
  \fontdimen4\font=.13em\relax
  \fontdimen7\font=.167em\relax
}

\DeclareRobustCommand\vttfamily
{%
  \not@math@alphabet\vttfamily\relax
  \fontfamily{cmvtt}% cmvtt (Computer Modern) or lmvtt (Latin Modern)
  \selectfont
}
\DeclareTextFontCommand{\textvtt}{\vttfamily}



% Logical String Length
% https://tex.stackexchange.com/questions/87638/logical-string-length
\newcommand{\includeonlyfilelist}[0]{}
\newcommand{\addtoincludeonly}[1]
{%
  \StrLen{\includeonlyfilelist}[\includeonlyfilelistlen]

  % How to concatenate strings into a single command?
  % https://tex.stackexchange.com/questions/74707/how-to-concatenate-strings-into-a
  \ifnum\includeonlyfilelistlen>0
    \g@addto@macro\includeonlyfilelist{,#1}
  \else
    \g@addto@macro\includeonlyfilelist{#1}
  \fi
}
\newcommand{\doincludeonly}[0]
{%
  \StrLen{\includeonlyfilelist}[\includeonlyfilelistlen]
  \ifnum\includeonlyfilelistlen>0
    \includeonly{\includeonlyfilelist}
  \else
  \fi
}













%% README.md
%% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`



% Bad Boxes settings

% Underfull \hbox in bibliography
% https://tex.stackexchange.com/questions/10924/underfull-hbox-in-bibliography
\apptocmd{\thebibliography}{\raggedright}{}{}

% Underfull \hbox (badness 10000) has occurred while \output is active
% https://tex.stackexchange.com/questions/367369/underfull-hbox-badness-10000-has-occurred-while-output-is-active
%
% how to suppress “Underfull \vbox (badness 10000) … while \output is active”?
% https://tex.stackexchange.com/questions/62296/how-to-suppress-underfull-vbox-badness-10000-while-output-is-active
\def\@textbottom{\vskip \z@ \@plus 7pt}
\let\@texttop\relax

% Why Latex is hyphenating some words automatically, but others dont? hyphenmins{22} %left=2, right=2
% https://tex.stackexchange.com/questions/387076/why-latex-is-hyphenating-some-words-automatically-but-others-dont
\@ifpackagewith{babel}{brazil}{  \def\brazilhyphenmins{11} }{}
\@ifpackagewith{babel}{english}{ \def\englishhyphenmins{11} }{}
\@ifpackagewith{babel}{french}{  \def\frenchhyphenmins{11} }{}

\@ifpackageloaded{url}
{
  % Bad formatting using URLs in bibtex
  % https://tex.stackexchange.com/questions/22888/bad-formatting-using-urls-in-bibtex
  \usepackage{etoolbox}

  % How to avoid overfull error with url package?
  % See also the `\usepackage{url}` declarationon the file `basic.tex`.
  % Set this to 2mu or 3mu if URL start troubling again.
  % https://tex.stackexchange.com/questions/261776/how-to-avoid-overfull-error-with-url-package
  \Urlmuskip=0mu plus 1mu

  % How to fix URL overfull & underfull on emumeration?
  % https://tex.stackexchange.com/questions/366803/how-to-fix-url-overfull-underfull-on-emumeration
  %
  % Forcing linebreaks in \url
  % https://tex.stackexchange.com/questions/3033/forcing-linebreaks-in-url/10401
  \g@addto@macro{\UrlBreaks}{\UrlOrds}

  % How to fix this url bad box for stackoverflow link?
  % https://tex.stackexchange.com/questions/384427/how-to-fix-this-url-bad-box-for-stackoverflow-link
  \g@addto@macro{\UrlBreaks}
  {%
    \do\a\do\b\do\c\do\d\do\e\do\f\do\g%
    \do\h\do\i\do\j\do\k\do\l\do\m\do\n%
    \do\o\do\p\do\q\do\r\do\s\do\t\do\u%
    \do\v\do\w\do\x\do\y\do\z%
    \do\A\do\B\do\C\do\D\do\E\do\F\do\G%
    \do\H\do\I\do\J\do\K\do\L\do\M\do\N%
    \do\O\do\P\do\Q\do\R\do\S\do\T\do\U%
    \do\V\do\W\do\X\do\Y\do\Z%
    \do\/\do\_\do\-%
  }
}{}













%% README.md
%% Copyright 2017 Evandro Coan
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is M. Y. Name.
%
% This work consists of the files:
% 1. `README.md`,
% 2. `basic.tex`,
% 3. `commands.tex`,
% 4. `commands_list.tex`
% 5. `programming.tex`
% 6. `badboxes.tex`



% Writing code in latex document. Usage: \begin & \end {lstlisting}
% http://stackoverflow.com/questions/3175105/writing-code-in-latex-document
\usepackage{listings}

% How to insert code with accents with listings?
% https://tex.stackexchange.com/questions/30512/how-to-insert-code-with-accents-with-listings
\usepackage{listingsutf8}

% set the font family for lstlisting
% https://tex.stackexchange.com/questions/33685/set-the-font-family-for-lstlisting
\usepackage{courier}

% https://tex.stackexchange.com/questions/34357/setting-up-specific-font-for-use-in-listings
% https://tex.stackexchange.com/questions/32275/setting-font-for-a-minted-environment-in-a-beamer-frame
\usepackage[varqu]{zi4}

% Latex: Listings with monospace fonts
% https://stackoverflow.com/questions/2913141/latex-listings-with-monospace-fonts
% https://tex.stackexchange.com/questions/145416/how-to-have-straight-single-quotes-in-lstlistings
% https://tex.stackexchange.com/questions/252443/double-quote-charater-with-listings-create-problem
\lstset{frame=,
  language=Python,% default language
  upquote=true,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  basicstyle={\small\fontfamily{zi4}\selectfont},
  numbers=left,
  numberstyle=\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{darkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=4,
  morestring=[b]',
  morestring=[b]",
  literate = {---}{{\ProcessThreeDashes}}3
       {>}{{\textcolor{red}\textgreater}}1
       {|}{{\textcolor{red}\textbar}}1
       {\ -\ }{{\mdseries\ -\ }}3,
  inputencoding=utf8, % http://stackoverflow.com/questions/1116266/listings-in-latex-with-utf-8-or-at-least-german-umlauts
  extendedchars=true, % https://tex.stackexchange.com/questions/24528/having-problems-with-listings-and-utf-8-can-it-be-fixed
  literate=%
  {£}{{\pounds}}1
  {ß}{{\ss}}1
  {à}{{\`a}}1
  {À}{{\`A}}1
  {à}{{\`{a}}}1
  {á}{{\'a}}1
  {Á}{{\'A}}1
  {á}{{\'{a}}}1
  {Á}{{\'{A}}}1
  {â}{{\^a}}1
  {Â}{{\^A}}1
  {â}{{\^{a}}}1
  {Â}{{\^{A}}}1
  {ã}{{\~a}}1
  {Ã}{{\~A}}1
  {ã}{{\~{a}}}1
  {Ã}{{\~{A}}}1
  {ä}{{\"a}}1
  {Ä}{{\"A}}1
  {å}{{\r a}}1
  {Å}{{\r A}}1
  {æ}{{\ae}}1
  {Æ}{{\AE}}1
  {ç}{{\c c}}1
  {Ç}{{\c C}}1
  {ç}{{\c{c}}}1
  {Ç}{{\c{C}}}1
  {È}{{\'E}}1
  {è}{{\`e}}1
  {è}{{\`{e}}}1
  {é}{{\'e}}1
  {É}{{\'E}}1
  {é}{{\'{e}}}1
  {É}{{\'{E}}}1
  {ê}{{\^e}}1
  {Ê}{{\^E}}1
  {ê}{{\^{e}}}1
  {Ê}{{\^{E}}}1
  {ë}{{\"e}}1
  {Ë}{{\"E}}1
  {ë}{{\¨{e}}}1
  {ì}{{\`i}}1
  {Ì}{{\`I}}1
  {í}{{\'i}}1
  {Í}{{\'I}}1
  {í}{{\'{i}}}1
  {Í}{{\~{Í}}}1
  {î}{{\^i}}1
  {Î}{{\^I}}1
  {î}{{\^{i}}}1
  {Î}{{\^{I}}}1
  {ï}{{\"i}}1
  {Ï}{{\"I}}1
  {ò}{{\`o}}1
  {Ò}{{\`O}}1
  {ó}{{\'o}}1
  {Ó}{{\'O}}1
  {ó}{{\'{o}}}1
  {Ó}{{\'{O}}}1
  {ô}{{\^o}}1
  {Ô}{{\^O}}1
  {ô}{{\^{o}}}1
  {Ô}{{\^{O}}}1
  {õ}{{\~o}}1
  {Õ}{{\~O}}1
  {õ}{{\~{o}}}1
  {Õ}{{\~{O}}}1
  {ö}{{\"o}}1
  {Ö}{{\"O}}1
  {ø}{{\o}}1
  {ù}{{\`u}}1
  {Ù}{{\`U}}1
  {ù}{{\`{u}}}1
  {ú}{{\'u}}1
  {Ú}{{\'U}}1
  {ú}{{\'{u}}}1
  {û}{{\^u}}1
  {Û}{{\^U}}1
  {û}{{\^{u}}}1
  {ü}{{\"u}}1
  {Ü}{{\"U}}1
  {ő}{{\H{o}}}1
  {Ő}{{\H{O}}}1
  {œ}{{\oe}}1
  {Œ}{{\OE}}1
  {ű}{{\H{u}}}1
  {Ű}{{\H{U}}}1
  {€}{{\EUR}}1
}

% Defining `lstset` parameters for multiple languages & How can I highlight YAML code in a pretty way with listings?
%
% Usage \begin{lstlisting}[style=yaml_style] ... \end{lstlisting}
%
% https://tex.stackexchange.com/questions/45711/defining-lstset-parameters-for-multiple-languages
% https://tex.stackexchange.com/questions/152829/how-can-i-highlight-yaml-code-in-a-pretty-way-with-listings
\newcommand\YAMLcolonstyle{\color{red}\mdseries}
\newcommand\YAMLkeystyle{\color{black}\bfseries}
\newcommand\YAMLvaluestyle{\color{blue}\mdseries}
\newcommand\ProcessThreeDashes{\llap{\color{cyan}\mdseries-{-}-}}

\lstdefinestyle{yaml_style}{
  frame=,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  numbers=left,
  numberstyle=\color{gray},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=2,
  keywords={true,false,null,y,n},
  keywordstyle=\color{darkgray},
  basicstyle={\small\fontfamily{zi4}\selectfont\YAMLkeystyle}, % assuming a key comes first
  sensitive=false,
  comment=[l]{\#},
  comment=[l]{\/\/},
  morecomment=[s]{/*}{*/},
  commentstyle=\color{purple}\fontfamily{zi4}\selectfont,
  stringstyle=\YAMLvaluestyle\fontfamily{zi4}\selectfont,
  moredelim=[l][\color{orange}]{\&},
  moredelim=[l][\color{magenta}]{*},
  moredelim=**[il][\YAMLcolonstyle{:}\YAMLvaluestyle]{:} % switch to value style at :
}

\lstdefinestyle{ufscthesisx_style}{
  aboveskip=3mm,
  belowskip=3mm,
  backgroundcolor=\color{white},   % choose the background color; you must add \usepackage{color} or \usepackage{xcolor}
  basicstyle={\small\fontfamily{zi4}\selectfont},    % the size of the fonts that are used for the code
  breakatwhitespace=true,          % sets if automatic breaks should only happen at whitespace
  breaklines=true,                 % sets automatic line breaking
  captionpos=t,                    % sets the caption-position to bottom
  commentstyle=\color{mygreen},    % comment style
  columns=flexible,
  deletekeywords={...},            % if you want to delete keywords from the given language
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
  frame=tb,                        % adds a frame around the code
  keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
  keywordstyle=\color{blue},       % keyword style
  language=Matlab,                 % the language of the code
  morekeywords={*,...},            % if you want to add more keywords to the set
  numbers=none,                    % where to put the line-numbers; possible values are (none, left, right)
  numbersep=5pt,                   % how far the line-numbers are from the code
  numberstyle=\tiny\color{mygray}, % the style that is used for the line-numbers
  rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
  showstringspaces=false,          % underline spaces within strings only
  showtabs=false,                  % show tabs within strings adding particular underscores
  stepnumber=2,                    % the step between two line-numbers. If it's 1, each line will be numbered
  stringstyle=\color{mymauve},     % string literal style
  tabsize=3,                       % sets default tabsize to 3 spaces
  texcl=true,                      % Permite o uso de acentuação no código
  title=\lstname                   % show the filename of files included with \lstinputlisting; also try caption instead of title
}

% https://tex.stackexchange.com/questions/83882/how-to-highlight-python-syntax-in-latex-listings-lstinputlistings-command
\definecolor{gray}{gray}{0.5}
\colorlet{commentcolour}{green!50!black}

\colorlet{stringcolour}{red!60!black}
\colorlet{keywordcolour}{magenta!90!black}
\colorlet{exceptioncolour}{yellow!50!red}
\colorlet{commandcolour}{blue!60!black}
\colorlet{numpycolour}{blue!60!green}
\colorlet{literatecolour}{magenta!90!black}
\colorlet{promptcolour}{green!50!black}
\colorlet{specmethodcolour}{violet}

\newcommand*{\literatecolour}{\textcolor{literatecolour}}

\newcommand*{\pythonprompt}{\textcolor{promptcolour}{{>}{>}{>}}}

\lstdefinestyle{python_style}{
  %keepspaces=true,
  language=python,
  showtabs=true,
  tab=,
  tabsize=4,
  basicstyle=\small\fontfamily{zi4}\selectfont,
  stringstyle=\color{stringcolour},
  showstringspaces=false,
  alsoletter={1234567890},
  otherkeywords={\%, \}, \{, \&, \|},
  keywordstyle=\color{keywordcolour}\bfseries,
  emph={and,break,class,continue,def,yield,del,elif ,else,%
  except,exec,finally,for,from,global,if,import,in,%
  lambda,not,or,pass,print,raise,return,try,while,assert,with},
  emphstyle=\color{blue}\bfseries,
  emph={[2]True, False, None},
  emphstyle=[2]\color{keywordcolour},
  emph={[3]object,type,isinstance,copy,deepcopy,zip,enumerate,reversed,list,set,len,dict,tuple,xrange,append,execfile,real,imag,reduce,str,repr},
  emphstyle=[3]\color{commandcolour},
  emph={Exception,NameError,IndexError,SyntaxError,TypeError,ValueError,OverflowError,ZeroDivisionError},
  emphstyle=\color{exceptioncolour}\bfseries,
  %upquote=true,
  morecomment=[s]{"""}{"""},
  commentstyle=\color{commentcolour}\slshape,
  %emph={[4]1, 2, 3, 4, 5, 6, 7, 8, 9, 0},
  emph={[4]ode, fsolve, sqrt, exp, sin, cos,arctan, arctan2, arccos, pi,  array, norm, solve, dot, arange, isscalar, max, sum, flatten, shape, reshape, find, any, all, abs, plot, linspace, legend, quad, polyval,polyfit, hstack, concatenate,vstack,column_stack,empty,zeros,ones,rand,vander,grid,pcolor,eig,eigs,eigvals,svd,qr,tan,det,logspace,roll,min,mean,cumsum,cumprod,diff,vectorize,lstsq,cla,eye,xlabel,ylabel,squeeze},
  emphstyle=[4]\color{numpycolour},
  emph={[5]__init__,__add__,__mul__,__div__,__sub__,__call__,__getitem__,__setitem__,__eq__,__ne__,__nonzero__,__rmul__,__radd__,__repr__,__str__,__get__,__truediv__,__pow__,__name__,__future__,__all__},
  emphstyle=[5]\color{specmethodcolour},
  emph={[6]assert,yield},
  emphstyle=[6]\color{keywordcolour}\bfseries,
  emph={[7]range},
  emphstyle={[7]\color{keywordcolour}\bfseries},
  % emph={[7]self},
  % emphstyle=[7]\bfseries,
  literate=*%
  {:}{{\literatecolour:}}{1}%
  {=}{{\literatecolour=}}{1}%
  {-}{{\literatecolour-}}{1}%
  {+}{{\literatecolour+}}{1}%
  {*}{{\literatecolour*}}{1}%
  {**}{{\literatecolour{**}}}2%
  {/}{{\literatecolour/}}{1}%
  {//}{{\literatecolour{//}}}2%
  {!}{{\literatecolour!}}{1}%
  %{(}{{\literatecolour(}}{1}%
  %{)}{{\literatecolour)}}{1}%
  {[}{{\literatecolour[}}{1}%
  {]}{{\literatecolour]}}{1}%
  {<}{{\literatecolour<}}{1}%
  {>}{{\literatecolour>}}{1}%
  {>>>}{\pythonprompt}{3}%
  ,%
  %aboveskip=.5ex,
  frame=,
  %frameround=tttt,
  %framesep=.3ex,
  rulecolor=\color{black!40},
  %framexleftmargin=\framemargin,
  %framextopmargin=.1ex,
  %framexbottommargin=.1ex,
  %framexrightmargin=\framemargin,
  %framexleftmargin=1mm, framextopmargin=1mm, frame=shadowbox, rulesepcolor=\color{blue},#1
  %frame=tb,
  % backgroundcolor=\color{white},
  % breakindent=.5\textwidth,frame=single,breaklines=true%
}

% https://tex.stackexchange.com/questions/99500/listings-code-style-for-html5-css-html-javascript
\lstdefinestyle{HTML5}{
    language=html,
    sensitive=true,
    alsoletter={<>=-},
    otherkeywords={
    % HTML tags
    <, </, >,
    </a, <a, </a>,
    </abbr, <abbr, </abbr>,
    </address, <address, </address>,
    </area, <area, </area>,
    </area, <area, </area>,
    </article, <article, </article>,
    </aside, <aside, </aside>,
    </audio, <audio, </audio>,
    </audio, <audio, </audio>,
    </b, <b, </b>,
    </base, <base, </base>,
    </bdi, <bdi, </bdi>,
    </bdo, <bdo, </bdo>,
    </blockquote, <blockquote, </blockquote>,
    </body, <body, </body>,
    </br, <br, </br>,
    </button, <button, </button>,
    </canvas, <canvas, </canvas>,
    </caption, <caption, </caption>,
    </cite, <cite, </cite>,
    </code, <code, </code>,
    </col, <col, </col>,
    </colgroup, <colgroup, </colgroup>,
    </data, <data, </data>,
    </datalist, <datalist, </datalist>,
    </dd, <dd, </dd>,
    </del, <del, </del>,
    </details, <details, </details>,
    </dfn, <dfn, </dfn>,
    </div, <div, </div>,
    </dl, <dl, </dl>,
    </dt, <dt, </dt>,
    </em, <em, </em>,
    </embed, <embed, </embed>,
    </fieldset, <fieldset, </fieldset>,
    </figcaption, <figcaption, </figcaption>,
    </figure, <figure, </figure>,
    </footer, <footer, </footer>,
    </form, <form, </form>,
    </h1, <h1, </h1>,
    </h2, <h2, </h2>,
    </h3, <h3, </h3>,
    </h4, <h4, </h4>,
    </h5, <h5, </h5>,
    </h6, <h6, </h6>,
    </head, <head, </head>,
    </header, <header, </header>,
    </hr, <hr, </hr>,
    </html, <html, </html>,
    </i, <i, </i>,
    </iframe, <iframe, </iframe>,
    </img, <img, </img>,
    </input, <input, </input>,
    </ins, <ins, </ins>,
    </kbd, <kbd, </kbd>,
    </keygen, <keygen, </keygen>,
    </label, <label, </label>,
    </legend, <legend, </legend>,
    </li, <li, </li>,
    </link, <link, </link>,
    </main, <main, </main>,
    </map, <map, </map>,
    </mark, <mark, </mark>,
    </math, <math, </math>,
    </menu, <menu, </menu>,
    </menuitem, <menuitem, </menuitem>,
    </meta, <meta, </meta>,
    </meter, <meter, </meter>,
    </nav, <nav, </nav>,
    </noscript, <noscript, </noscript>,
    </object, <object, </object>,
    </ol, <ol, </ol>,
    </optgroup, <optgroup, </optgroup>,
    </option, <option, </option>,
    </output, <output, </output>,
    </p, <p, </p>,
    </param, <param, </param>,
    </pre, <pre, </pre>,
    </progress, <progress, </progress>,
    </q, <q, </q>,
    </rp, <rp, </rp>,
    </rt, <rt, </rt>,
    </ruby, <ruby, </ruby>,
    </s, <s, </s>,
    </samp, <samp, </samp>,
    </script, <script, </script>,
    </section, <section, </section>,
    </select, <select, </select>,
    </small, <small, </small>,
    </source, <source, </source>,
    </span, <span, </span>,
    </strong, <strong, </strong>,
    </style, <style, </style>,
    </summary, <summary, </summary>,
    </sup, <sup, </sup>,
    </svg, <svg, </svg>,
    </table, <table, </table>,
    </tbody, <tbody, </tbody>,
    </td, <td, </td>,
    </template, <template, </template>,
    </textarea, <textarea, </textarea>,
    </tfoot, <tfoot, </tfoot>,
    </th, <th, </th>,
    </thead, <thead, </thead>,
    </time, <time, </time>,
    </title, <title, </title>,
    </tr, <tr, </tr>,
    </track, <track, </track>,
    </u, <u, </u>,
    </ul, <ul, </ul>,
    </var, <var, </var>,
    </video, <video, </video>,
    </wbr, <wbr, </wbr>,
    />, <!
    },
    ndkeywords={
    % General
    =,
    % HTML attributes
    accept=, accept-charset=, accesskey=, action=, align=, alt=, async=, autocomplete=, autofocus=, autoplay=, autosave=, bgcolor=, border=, buffered=, challenge=, charset=, checked=, cite=, class=, code=, codebase=, color=, cols=, colspan=, content=, contenteditable=, contextmenu=, controls=, coords=, data=, datetime=, default=, defer=, dir=, dirname=, disabled=, download=, draggable=, dropzone=, enctype=, for=, form=, formaction=, headers=, height=, hidden=, high=, href=, hreflang=, http-equiv=, icon=, id=, ismap=, itemprop=, keytype=, kind=, label=, lang=, language=, list=, loop=, low=, manifest=, max=, maxlength=, media=, method=, min=, multiple=, name=, novalidate=, open=, optimum=, pattern=, ping=, placeholder=, poster=, preload=, pubdate=, radiogroup=, readonly=, rel=, required=, reversed=, rows=, rowspan=, sandbox=, scope=, scoped=, seamless=, selected=, shape=, size=, sizes=, span=, spellcheck=, src=, srcdoc=, srclang=, start=, step=, style=, summary=, tabindex=, target=, title=, type=, usemap=, value=, width=, wrap=,
    % CSS properties
    accelerator:,azimuth:,background:,background-attachment:,
    background-color:,background-image:,background-position:,
    background-position-x:,background-position-y:,background-repeat:,
    behavior:,border:,border-bottom:,border-bottom-color:,
    border-bottom-style:,border-bottom-width:,border-collapse:,
    border-color:,border-left:,border-left-color:,border-left-style:,
    border-left-width:,border-right:,border-right-color:,
    border-right-style:,border-right-width:,border-spacing:,
    border-style:,border-top:,border-top-color:,border-top-style:,
    border-top-width:,border-width:,bottom:,caption-side:,clear:,
    clip:,color:,content:,counter-increment:,counter-reset:,cue:,
    cue-after:,cue-before:,cursor:,direction:,display:,elevation:,
    empty-cells:,filter:,float:,font:,font-family:,font-size:,
    font-size-adjust:,font-stretch:,font-style:,font-variant:,
    font-weight:,height:,ime-mode:,include-source:,
    layer-background-color:,layer-background-image:,layout-flow:,
    layout-grid:,layout-grid-char:,layout-grid-char-spacing:,
    layout-grid-line:,layout-grid-mode:,layout-grid-type:,left:,
    letter-spacing:,line-break:,line-height:,list-style:,
    list-style-image:,list-style-position:,list-style-type:,margin:,
    margin-bottom:,margin-left:,margin-right:,margin-top:,
    marker-offset:,marks:,max-height:,max-width:,min-height:,
    min-width:,transition-duration:,transition-property:,
    transition-timing-function:,transform:,
    -moz-transform:,-moz-binding:,-moz-border-radius:,
    -moz-border-radius-topleft:,-moz-border-radius-topright:,
    -moz-border-radius-bottomright:,-moz-border-radius-bottomleft:,
    -moz-border-top-colors:,-moz-border-right-colors:,
    -moz-border-bottom-colors:,-moz-border-left-colors:,-moz-opacity:,
    -moz-outline:,-moz-outline-color:,-moz-outline-style:,
    -moz-outline-width:,-moz-user-focus:,-moz-user-input:,
    -moz-user-modify:,-moz-user-select:,orphans:,outline:,
    outline-color:,outline-style:,outline-width:,overflow:,
    overflow-X:,overflow-Y:,padding:,padding-bottom:,padding-left:,
    padding-right:,padding-top:,page:,page-break-after:,
    page-break-before:,page-break-inside:,pause:,pause-after:,
    pause-before:,pitch:,pitch-range:,play-during:,position:,quotes:,
    -replace:,richness:,right:,ruby-align:,ruby-overhang:,
    ruby-position:,-set-link-source:,size:,speak:,speak-header:,
    speak-numeral:,speak-punctuation:,speech-rate:,stress:,
    scrollbar-arrow-color:,scrollbar-base-color:,
    scrollbar-dark-shadow-color:,scrollbar-face-color:,
    scrollbar-highlight-color:,scrollbar-shadow-color:,
    scrollbar-3d-light-color:,scrollbar-track-color:,table-layout:,
    text-align:,text-align-last:,text-decoration:,text-indent:,
    text-justify:,text-overflow:,text-shadow:,text-transform:,
    text-autospace:,text-kashida-space:,text-underline-position:,top:,
    unicode-bidi:,-use-link-source:,vertical-align:,visibility:,
    voice-family:,volume:,white-space:,widows:,width:,word-break:,
    word-spacing:,word-wrap:,writing-mode:,z-index:,zoom:
    },
    morecomment=[s]{<!--}{-->},
    tag=[s]
}







% Ao contrario da norma abnt-6027-2012, que as figuras estejam listadas na Lista de
% Ilustrações,  a UFSC pede que as figuras estejam na Lista de Figuras.
%
% Remove the colon appended to variables by 'abntex2' because they show up on places they shouldn't
%
% https://tex.stackexchange.com/questions/485830/why-latex-does-not-tell-me-which-command-is-undefined
% https://tex.stackexchange.com/questions/482886/how-to-add-babel-captions-to-newfloat-package-environments
% https://tex.stackexchange.com/questions/482523/how-to-override-command-on-my-preamble-after-its-redefinition-by-my-class-with
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{%
  \renewcommand{\orientadorname}{Orientador}
  \renewcommand{\coorientadorname}{Coorientador}
  \renewcommand{\quadrosname}{Quadro}
  \renewcommand{\folhadeaprovacaoname}{Folha de Aprovação}
  \renewcommand{\folhaderostoname}{Folha de Rosto}
  \renewcommand{\listfigurename}{Lista de Ilustrações}
  \renewcommand{\listtablename}{Lista de Tabelas}
  \renewcommand{\listofquadrosname}{Lista de Quadros}
  \renewcommand{\listfigurename}{Lista de Figuras}
  \renewcommand{\listadesiglasname}{Lista de Abreviaturas e Siglas}
  \renewcommand{\listadesimbolosname}{Lista de Símbolos}
  \renewcommand{\tableautorefname}{Tabela}
  \renewcommand{\figureautorefname}{Figura}
  \renewcommand{\chapterautorefname}{Capítulo}
  \renewcommand{\pageautorefname}{Página}
  \renewcommand{\sectionautorefname}{Seção}
  \renewcommand{\subsectionautorefname}{Subseção}
  \renewcommand{\subsubsectionautorefname}{Subsubseção}
  \renewcommand{\paragraphautorefname}{Parágrafo}
}}{}}{}

\@ifpackageloaded{babel}{\@ifpackagewith{babel}{english}{\addto\captionsenglish{%
  \renewcommand{\covername}{Cover}
  \renewcommand{\orientadorname}{Supervisor}
  \renewcommand{\coorientadorname}{Co\hyp{}supervisor}
  \renewcommand{\folhadeaprovacaoname}{Approval}
  \renewcommand{\folhaderostoname}{Title Page}
  \renewcommand{\errataname}{Errata Sheet}
  \renewcommand{\listfigurename}{List of Illustrations}
  \renewcommand{\listtablename}{List of Tables}
  \renewcommand{\listfigurename}{List of Figures}
  \renewcommand{\listadesiglasname}{List of Abbreviations and Acronyms}
  \renewcommand{\listadesimbolosname}{List of Symbols}
  \renewcommand{\tableautorefname}{Table}
  \renewcommand{\figureautorefname}{Figure}
  \renewcommand{\chapterautorefname}{Chapter}
  \renewcommand{\pageautorefname}{Page}
  \renewcommand{\sectionautorefname}{Section}
  \renewcommand{\subsectionautorefname}{Subsection}
  \renewcommand{\subsubsectionautorefname}{Subsubsection}
  \renewcommand{\paragraphautorefname}{Paragraph}
}}{}}{}

% Muda equação para 'Equação (n)'
% https://tex.stackexchange.com/questions/153471/autoref-does-not-expand-abbreviation-automatically-at-beginning-of-line
% https://tex.stackexchange.com/questions/153496/combining-autoref-and-eqref
% https://tex.stackexchange.com/questions/62308/rename-sections-with-ngerman
% https://tex.stackexchange.com/questions/4925/custom-equations-names
% https://tex.stackexchange.com/questions/173970/add-equation-name-besides-equation-number-so-that-eqref-inserts-only-the-numbe
% https://tex.stackexchange.com/questions/128050/add-equation-name-underneath-equation-number
\@ifpackageloaded{babel}{\@ifpackagewith{babel}{english}{\addto\captionsenglish{%
  \def\equationautorefname~#1\null{%
  Equation~(#1)\null
  }
}}{}}{}

\@ifpackageloaded{babel}{\@ifpackagewith{babel}{brazil}{\addto\captionsbrazil{%
  \def\equationautorefname~#1\null{%
  Equação~(#1)\null
  }
}}{}}{}


\makeatother
