\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{ProblemBook}[2018/01/21 v1.0 Problem Book Class]

%===============================================================================
% БАЗОВИЙ КЛАС
%===============================================================================
\LoadClass[onecolumn, twoside, 14pt]{extbook}

%===============================================================================
% ОГОЛОШЕННЯ ОПЦІЙ КЛАСУ
%===============================================================================

% Логічні змінні для опцій
\newif\ifelectronic
\newif\ifbiblatex
\newif\ifmarginversioninfo

% Опція для друкованої версії
\DeclareOption{print}{
    \PassOptionsToPackage{colorlinks=false}{hyperref}
    \PassOptionsToPackage{pdfsubject={Version for Printing}}{hyperref}
    \electronicfalse
}

% Опція для електронної версії
\DeclareOption{electronic}{
    \def\defcolor{%
        \RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
        \definecolor{malina}{rgb}{0.6,0.0,0.0}
    }
    \PassOptionsToPackage{linkcolor=malina}{hyperref}
    \PassOptionsToPackage{colorlinks=true}{hyperref}
    \PassOptionsToPackage{urlcolor=blue}{hyperref}
    \PassOptionsToPackage{citecolor=green!60!black}{hyperref}
    \PassOptionsToPackage{pdfsubject={Electronic Version}}{hyperref}
    \electronictrue
}

% Опція для інформації про версію на полях
\DeclareOption{marginversioninfo}{
    \marginversioninfotrue
}

% Опція для використання biblatex
\DeclareOption{biblatex}{
    \biblatextrue
}

% Виконання опцій
\ExecuteOptions{electronic}
\ProcessOptions\relax
\defcolor{}

%===============================================================================
% ГЕОМЕТРІЯ СТОРІНКИ
%===============================================================================
\newlength{\topspace}
\setlength{\topspace}{2cm}

\RequirePackage[%
    a4paper,%
    footskip=1cm,%
    headsep=0.3cm,%
    top=\topspace,      % поле зверху
    bottom=2cm,         % поле знизу
    left=2cm,           % поле ліворуч
    right=2cm,          % поле праворуч
]{geometry}

%===============================================================================
% НАЛАШТУВАННЯ МОВИ ТА КОМПІЛЯТОРІВ
%===============================================================================

% Визначення компілятора
\RequirePackage{ifluatex,ifxetex}
\newif\ifxetexorluatex
\ifxetex
    \xetexorluatextrue
\else
    \ifluatex
        \xetexorluatextrue
    \else
        \xetexorluatexfalse
    \fi
\fi

% Налаштування шрифтів для XeTeX/LuaTeX
\ifxetexorluatex
    \RequirePackage{fontspec}
    \setsansfont{CMU Sans Serif}           % Arial альтернатива
    \setmainfont{stix}                     % основний шрифт
    \setmonofont{CMU Typewriter Text}      % моноширинний шрифт
    \defaultfontfeatures{Ligatures={TeX}}
    \newfontfamily\Annabelle{Annabelle}
    \RequirePackage{luacolor}
\else
    % Налаштування для pdfTeX
    \RequirePackage[T2A,T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \input{glyphtounicode}
    \pdfgentounicode=1
    \RequirePackage{cmap}
    \renewcommand{\sfdefault}{fos}
    \renewcommand{\bfdefault}{b}
\fi

% Мовні налаштування
\RequirePackage[english,russian,ukrainian]{babel}

%===============================================================================
% ЛОГІЧНІ ЗМІННІ ДЛЯ СТРУКТУРИ ДОКУМЕНТУ
%===============================================================================
%\newif\ifappendix      % чи це додатки
%\newif\ifanswers       % чи це відповіді
%\newif\iftoc           % чи це зміст
%\newif\ifbibliography  % чи це бібліографія
\newif\ifintro         % чи це вступ

%===============================================================================
% ТИПОГРАФІЧНІ НАЛАШТУВАННЯ
%===============================================================================
\RequirePackage{microtype}

% Відступи та інтервали
\setlength{\parindent}{2.5em}
\def\@textbottom{\vskip \z@ \@plus 1pt}
\let\@texttop\relax

%===============================================================================
% КОЛЬОРИ ТЕМИ
%===============================================================================
\definecolor{malina}{RGB}{153,0,0}
\definecolor{themecolordark}{RGB}{0,46,100}
\definecolor{themecolorlight}{RGB}{0,100,170}
\definecolor{titlebgdark}{RGB}{0,103,102}
\definecolor{titlebglight}{RGB}{191,233,251}

%===============================================================================
% ПІДКЛЮЧЕННЯ ОСНОВНИХ ПАКЕТІВ
%===============================================================================

% --- Обробка тексту ---
\RequirePackage[overload]{textcase}
\let\MakeUppercase\MakeTextUppercase
\RequirePackage{indentfirst}

% --- Плаваючі об'єкти ---
\RequirePackage{subfig}
\renewcommand\thesubfigure{\alph{subfigure}}
\RequirePackage{wrapfig}

% --- Таблиці ---
\RequirePackage{colortbl}
\RequirePackage{makecell}
\RequirePackage{longtable}
\RequirePackage{array,ragged2e}
\setlength\arrayrulewidth{1pt}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{varwidth}
\RequirePackage{multirow}
\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}

% Нові типи колонок для таблиць
\newcolumntype{R}{>{\footnotesize}r}
\newcolumntype{L}{>{\footnotesize}l}
\newcolumntype{M}[1]{>{\begin{varwidth}[t]{#1}}l<{\end{varwidth}}}

% Допоміжні команди для таблиць
\newcommand{\centercell}[1]{\multicolumn{1}{c}{#1}}
\newcommand{\specialcell}[3][c]{%
    \begin{tabular}[#1]{@{}#2@{}}#3\end{tabular}
}

% Налаштування таблиць
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}
\setlength{\extrarowheight}{0.75ex}

% --- Підписи ---
\RequirePackage[justification=centering,labelsep=period]{caption}
\captionsetup[figure]{font=small,labelfont=small}
\captionsetup[table]{font=small,labelfont=small}

%===============================================================================
% МАТЕМАТИЧНІ ПАКЕТИ ТА КОМАНДИ
%===============================================================================

% Математичні пакети
\ifluatex
    \RequirePackage[math-style=TeX,bold-style=TeX]{unicode-math}
    \setmathfont[]{Stix Two Math}
\else
    \RequirePackage{amsfonts}
    \RequirePackage{amssymb}
\fi

\RequirePackage{esint}
\RequirePackage{nicefrac}
\let\nfrac\nicefrac
\allowdisplaybreaks

% Фізичні позначення
\AtBeginDocument{%
    \let\phi\varphi
    \let\epsilon\varepsilon
    \DeclareMathOperator{\const}{const}
    \DeclareMathOperator{\inv}{inv}
    \newcommand{\Laplasian}{\Delta}
}

% Векторні поля
\def\EMF{\mathcal{E}}
\newcommand{\vect}[1]{\symbf{#1}}
\def\Efield{\vect{E}}          % електричне поле
\def\Dfield{\vect{D}}          % електрична індукція
\def\Bfield{\vect{B}}          % магнітна індукція
\def\Hfield{\vect{H}}          % напруженість магнітного поля
\def\rot{\symbf{\nabla}\times} % ротор
\def\divg{\symbf{\nabla}\cdot} % дивергенція

% Хімічні формули
\RequirePackage{mhchem, chemfig}

% --- Списки ---
\RequirePackage[inline]{enumitem}

% --- Інші пакети ---
\RequirePackage{epigraph}
\setlength\epigraphwidth{.8\textwidth}
\setlength\epigraphrule{0pt}
\renewcommand{\textflush}{flushepinormal}

\RequirePackage{lastpage}
\RequirePackage[disable]{todonotes}
\RequirePackage{pdftexcmds}
\RequirePackage[most, many]{tcolorbox}
\RequirePackage{currfile}
\RequirePackage{xparse}

%===============================================================================
% РИСУВАННЯ TA ГРАФІКИ (TikZ/PGF)
%===============================================================================

\RequirePackage{tikz, pgfplots, tikz-3dplot}

% TikZ бібліотеки
\usetikzlibrary{decorations.text, decorations.markings}
\usetikzlibrary{intersections}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{shapes, shadows}
\usetikzlibrary{quotes,angles}
\usetikzlibrary{shapes.geometric,calc}
\usetikzlibrary{patterns}

% Шари для TikZ
\pgfdeclarelayer{bg}
\pgfsetlayers{bg,main}

% Налаштування PGFPlots
\usepgfplotslibrary{fillbetween}
\pgfplotsset{
    every axis label/.append style={font=\small},
    compat=newest,
}

% Налаштування TikZ
\tikzset{every picture/.style={font=\small}}
\tikzset{
    partial ellipse/.style args={#1:#2:#3}{
        insert path={+ (#1:#3) arc (#1:#2:#3)}
    }
}

% Патерни для заливки
\tikzstyle{ground}=[fill,pattern=north east lines,draw=none,minimum width=0.3,minimum height=0.6]

% --- Електричні кола ---
\usetikzlibrary{circuits.ee.IEC}
\tikzset{circuit ee IEC,
    every info/.style=red,
    semithick,
    every info/.style={font=\footnotesize},
    small circuit symbols,
    % Оголошення символів
    circuit declare symbol = ocontact,
    circuit declare symbol = multimeter,
    circuit declare symbol = ampermeter,
    circuit declare symbol = voltmeter,
    circuit declare symbol = galvanometer,
    circuit declare symbol = ac source,
    % Графічні стилі символів
    set ocontact graphic = {draw, fill = white, generic circle IEC, shape=circle, minimum size=1mm},
    set multimeter graphic = {draw,generic circle IEC, minimum size=5mm},
    set ampermeter graphic = {draw,generic circle IEC, minimum size=5mm,info=center:A},
    set voltmeter graphic = {draw,generic circle IEC, minimum size=5mm,info=center:V},
    set galvanometer graphic = {draw,generic circle IEC, minimum size=5mm,info=center:G},
    set ac source graphic = ac source IEC graphic,
    % AC джерело
    ac source IEC graphic/.style={
        transform shape,
        circuit symbol lines,
        circuit symbol size = width 3 height 3,
        shape=generic circle IEC,
        /pgf/generic circle IEC/before background={
            \pgfpathmoveto{\pgfpoint{-0.575pt}{0pt}}
            \pgfpathsine{\pgfpoint{0.3pt}{0.3pt}}
            \pgfpathcosine{\pgfpoint{0.3pt}{-0.3pt}}
            \pgfpathsine{\pgfpoint{0.3pt}{-0.3pt}}
            \pgfpathcosine{\pgfpoint{0.3pt}{0.3pt}}
            \pgfusepathqstroke
        }
    }
}

%===============================================================================
% ДРУК ВЕРСІЇ ДОКУМЕНТУ НА ПОЛЯХ (ОПЦІОНАЛЬНО)
%===============================================================================
\ifmarginversioninfo
    \RequirePackage[contents={},opacity=0.5,scale=1.5,color=gray]{background}
    \newcommand\Texta{\bf\large Версія від \today}    % непарна сторінка
    \newcommand\Textb{\bf\large Версія від \today}    % парна сторінка

    \AddEverypageHook{%
        \ifodd\value{page}
            \backgroundsetup{
                angle=90,
                position={-0.06\textwidth,-0.35\textheight},
                contents={\Texta}
            }%
        \else
            \backgroundsetup{
                angle=90,
                position={0.68\textwidth,-0.35\textheight},
                contents={\Textb}
            }%
        \fi
        \BgMaterial
    }
\fi

%===============================================================================
% ІНТЕРВАЛИ ТА ДОВЖИНИ
%===============================================================================
\newlength{\@spase}
\setlength{\@spase}{0.5ex}
\newlength{\length@titlemark}

% Відступи у формулах
\setlength\abovedisplayskip{1ex}
\setlength\belowdisplayskip{1ex}
\setlength\abovedisplayshortskip{1ex}
\setlength\belowdisplayshortskip{1ex}

% Відступ між написом та рисунком
\setlength{\textfloatsep}{5pt}

%===============================================================================
% ДОПОМІЖНІ КОМАНДИ ДЛЯ ПІДПИСІВ
%===============================================================================
\def\tabcaption{\def\@captype{table}\caption}
\def\figcaption{\def\@captype{figure}\caption}

%===============================================================================
% НАЛАШТУВАННЯ ТИТУЛЬНИХ СТОРІНОК
%===============================================================================

% Середовище для окремих сторінок
\newenvironment{alwayssingle}{%
    \thispagestyle{empty}
    \@restonecolfalse
    \if@twocolumn\@restonecoltrue\onecolumn
    \else\if@openright\cleardoublepage\else\clearpage\fi
    \fi
}{%
    \if@restonecol\twocolumn
    \else\newpage\thispagestyle{empty}\fi
}

% Стиль для титульної сторінки
\tcbset{%
    titlepagestyle/.style={%
        enhanced,
        colback=themecolordark,
        colframe=themecolorlight,
        arc=0pt,
        outer arc=0pt,
        leftrule=0pt,
        rightrule=0pt,
        enlarge left by=-1in-\hoffset-\oddsidemargin,
        enlarge right by=-\paperwidth+1in+\hoffset+\oddsidemargin+\textwidth,
        width=\paperwidth,
        left=1in+\hoffset+\oddsidemargin,
        right=\paperwidth-1in-\hoffset-\oddsidemargin-\textwidth,
    }%
}

% Переозначення команди \title
\ExplSyntaxOn
\RenewDocumentCommand{\title}{m}{
    \tl_gset:cn { @title } { #1 }
    \tl_gset:Nn { \realtitle } { #1 }
}
\ExplSyntaxOff

%===============================================================================
%
% РУБРИКАЦІЯ (СТРУКТУРА ДОКУМЕНТУ) - РАБОЧАЯ ВЕРСИЯ БЕЗ ФЛАГОВ
%
%===============================================================================

\RequirePackage[pagestyles, explicit]{titlesec}
\RequirePackage[dotinlabels]{titletoc}

%===============================================================================
% СИСТЕМА ТИПІВ РОЗДІЛІВ (замість флагів)
%===============================================================================

% Перечисление типов разделов
\def\@sectiontype@normal{normal}
\def\@sectiontype@toc{toc}
\def\@sectiontype@appendix{appendix}
\def\@sectiontype@answers{answers}
\def\@sectiontype@bibliography{bibliography}
\def\@sectiontype@intro{intro}

% Текущий тип раздела
\def\@current@sectiontype{\@sectiontype@normal}

% Команды для установки типа раздела
\newcommand{\setsectiontype}[1]{\def\@current@sectiontype{#1}}

% Проверка типа раздела
\newcommand{\checksectiontype}[1]{%
    \expandafter\ifx\csname @sectiontype@#1\endcsname\@current@sectiontype
        \expandafter\@firstoftwo
    \else
        \expandafter\@secondoftwo
    \fi
}

%===============================================================================
% ОПРЕДЕЛЕНИЕ НЕДОСТАЮЩИХ КОМАНД
%===============================================================================

% Проверяем и определяем недостающие команды
\providecommand{\@chapapp}{Розділ}
\providecommand{\bibname}{Література}
\providecommand{\appendixname}{Додаток}
\providecommand{\answersto}{Відповіді до розділу}

% Безопасная версия гиперссылок
\newcommand{\@safehyperlink}[2]{%
    \@ifundefined{@currentHref}{#2}{\protect\hyperlink{\@currentHref}{#2}}%
}

%===============================================================================
% ЛОГИЧЕСКИЕ ПЕРЕМЕННЫЕ ДЛЯ СОВМЕСТИМОСТИ
%===============================================================================

% Эмуляция старых флагов через систему типов
\newif\if@appendix@mode
\newif\if@answers@mode
\newif\if@toc@mode
\newif\if@intro@mode
\newif\if@bibliography@mode

% Автоматическое обновление флагов при смене типа
\def\@update@legacy@flags{%
    \@appendix@modefalse
    \@answers@modefalse
    \@toc@modefalse
    \@intro@modefalse
    \@bibliography@modefalse
    \checksectiontype{appendix}{\@appendix@modetrue}{}%
    \checksectiontype{answers}{\@answers@modetrue}{}%
    \checksectiontype{toc}{\@toc@modetrue}{}%
    \checksectiontype{intro}{\@intro@modetrue}{}%
    \checksectiontype{bibliography}{\@bibliography@modetrue}{}%
}

% Переопределяем команду установки типа с обновлением флагов
\renewcommand{\setsectiontype}[1]{%
    \def\@current@sectiontype{#1}%
    \@update@legacy@flags
}

%===============================================================================
% РОЗДІЛИ (CHAPTER)
%===============================================================================

\newcommand{\@chapnum@dot}{.}
\newlength\chapnumb
\setlength\chapnumb{4cm}

\titleformat{\chapter}[block]
{\normalfont\sffamily}{}{0pt}
{\parbox[b]{\chapnumb}{%
   \color{themecolordark}\fontsize{100}{90}\selectfont\thechapter}%
  \parbox[b]{\dimexpr\textwidth-\chapnumb\relax}{%
    \raggedleft%
    \hfill{\LARGE#1}\\
    \rule{\dimexpr\textwidth-\chapnumb\relax}{0.4pt}}}

\titleformat{name=\chapter,numberless}[block]
{\normalfont\sffamily}{}{0pt}
{\parbox[b]{\chapnumb}{%
   \mbox{}}%
  \parbox[b]{\dimexpr\textwidth-\chapnumb\relax}{%
    \raggedleft%
    \hfill{\LARGE#1}\\
    \rule{\dimexpr\textwidth-\chapnumb\relax}{0.4pt}}%
  \markboth{#1}{#1}%
}

%===============================================================================
% СЕКЦІЇ (SECTION)
%===============================================================================

% Получение маркера секции в зависимости от типа
\newcommand{\@get@section@marker}{%
    \checksectiontype{appendix}{\appendixname}{%
    \checksectiontype{answers}{\@answers@marker@text}{%
    \S}}%
}

\def\@spase{0.5em}

\let\oldsection\section
% --- разделяем звёздочную и обычную версию
\renewcommand{\section}{\@ifstar\@ssection\@nsection}

% нумерована секція
\newcommand{\@nsection}[1]{%
    \refstepcounter{section}%
    \settowidth{\@tempdima}{\@get@section@marker~\thesection}%
    \addcontentsline{toc}{section}{\@get@section@marker~\thesection.~#1}%
    \sectionmark{#1}%
	\vspace*{10\p@}%
	{\parindent \z@ \raggedright%
	\bfseries\large\@get@section@marker~\thesection.\ #1
		\par\nopagebreak
		%\vskip-1.75ex{\hskip-2cm\color{gray!60}\rule{\textwidth + 2cm}{2pt}}\nobreak
		\vskip 10\p@\nopagebreak
	}}


% звёздочная (ненумерованная)
\newcommand{\@ssection}[1]{%
    \sectionmark{#1}%
	\vspace*{10\p@}%
	{\parindent \z@ \raggedright
		\normalfont
		\interlinepenalty\@M
		\sffamily\large\bfseries  #1\par\nopagebreak
		\vskip 10\p@
	}}

%===============================================================================
% ПІДСЕКЦІЇ
%===============================================================================

% Нумеровані підсекції
\titleformat{\subsection}
    {\normalfont\normalsize\bfseries}
    {\thesubsection}
    {0.25em}
    {#1}
    []

% Ненумеровані підсекції (subsection*)
\titleformat{name=\subsection,numberless}
    {\normalfont\normalsize\bfseries\itshape}
    {}
    {0pt}
    {#1}
    []

\let\cleardoublepage\clearpage

%===============================================================================
% ДОДАТКИ
%===============================================================================

\renewcommand\appendix{\par
    \setsectiontype{appendix}%
    \gdef\thesection{\@Alph\c@section}
    \@addtoreset{table}{section}
    \renewcommand\thetable{\thesection.\@arabic\c@table}
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \renewcommand{\theequation}{\thesection.\arabic{equation}}
    \clearpage\pagestyle{main}
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \@ifundefined{chapter}{%
        \section*{Додатки}%
        \markboth{Додатки}{Додатки}%
        \addcontentsline{toc}{section}{Додатки}%
    }{%
        \chapter*{Додатки}%
        \markboth{Додатки}{Додатки}%
        \addcontentsline{toc}{chapter}{Додатки}%
    }%
    \if@restonecol\twocolumn\fi
}

%===============================================================================
% ВІДПОВІДІ
%===============================================================================

\newcommand\answers{\par
    \setsectiontype{answers}%
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \renewcommand{\thesection}{\arabic{section}}
    \renewcommand{\theequation}{\thesection.\arabic{equation}}
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \@ifundefined{chapter}{%
        \section*{Відповіді}%
        \markboth{Відповіді}{Відповіді}%
        \addcontentsline{toc}{section}{Відповіді}%
    }{%
        \chapter*{Відповіді}%
        \markboth{Відповіді}{Відповіді}%
        \addcontentsline{toc}{chapter}{Відповіді}%
    }%
    \if@restonecol\twocolumn\fi
}

% Лічільник сносок починається з кожної сторінки
\@newctr{footnote}[page]

%===============================================================================
% ЗМІСТ
%===============================================================================

\renewcommand\tableofcontents{%
    \setsectiontype{toc}%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname}\hypertarget{tocpage}{}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \setsectiontype{normal}% возвращаем к нормальному типу
}

%===============================================================================
% КОЛОНТИТУЛИ
%===============================================================================

% -------------------------
% Стиль страниц для глав (chapter pages)
% -------------------------

\def\ps@chapterpage{%
    \renewcommand{\@oddhead}{}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@oddfoot}{%
        \raisebox{0pt}[\headheight][0pt]{%
            \vbox{\hbox to\textwidth{\strut
                \small{\hfil\small\hyperlink{tocpage}{\thepage}}\hfil}}
        }%
    }
    \renewcommand{\@evenfoot}{%
        \raisebox{0pt}[\headheight][0pt]{%
            \vbox{\hbox to\textwidth{\strut
                \small{\hfil{\small\hyperlink{tocpage}{\thepage}}\hfil}}}
        }%
    }
}

%===============================================================================
% ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ДЛЯ КОЛОНТИТУЛОВ
%===============================================================================

% Получение левого маркера (для четных страниц)
\newcommand{\@get@leftmark@content}[1]{%
    \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter%
            \checksectiontype{normal}{%
                \@safehyperlink{}{\@chapapp\ \thechapter\@chapnum@dot} \ %
            }{}%
        \fi
    \fi
    #1%
}

% Получение правого маркера (для нечетных страниц)
\newcommand{\@get@rightmark@content}[1]{%
    \checksectiontype{toc}{\contentsname}{%
    \checksectiontype{bibliography}{\bibname}{%
    \checksectiontype{answers}{\answersto~#1}{%
        \ifnum \c@secnumdepth >\z@
            \@safehyperlink{}{\@get@section@marker~\thesection.}\ #1%
        \fi
    }}}%
}

% Единообразное оформление колонтитулов
\newcommand{\@make@header@box}[1]{%
    \raisebox{0pt}[\headheight][0pt]{%
        \vbox{\hbox to\textwidth{\strut\small{\hfil\small#1\hfil}}\hrule}%
    }%
}

\newcommand{\@make@footer@box}[1]{%
    \raisebox{0pt}[\headheight][0pt]{%
        \vbox{\hbox to\textwidth{\strut\small{\hfil\small#1\hfil}}}%
    }%
}

% -------------------------
% Стиль страниц для основного текста
% -------------------------

\def\ps@main{%
    \def\chaptermark##1{\markboth{\@get@leftmark@content{##1}}{##1}}%
    \def\sectionmark##1{\markright{\@get@rightmark@content{##1}}}%

    % Колонтитули
    \renewcommand{\@oddhead}{\@make@header@box{\leftmark}}%
    \renewcommand{\@evenhead}{\@make@header@box{\rightmark}}%
    \renewcommand{\@oddfoot}{\@make@footer@box{\hyperlink{tocpage}{\thepage}}}%
    \renewcommand{\@evenfoot}{\@make@footer@box{\hyperlink{tocpage}{\thepage}}}%
}


%===============================================================================
% БІБЛІОГРАФІЯ
%===============================================================================

% Налаштування інтервалів у бібліографії
\newlength{\bibitemsep}
\setlength{\bibitemsep}{.1\baselineskip plus .05\baselineskip minus .05\baselineskip}
\newlength{\bibparskip}
\setlength{\bibparskip}{0pt}

\let\oldthebibliography\thebibliography
\renewcommand\thebibliography[1]{%
    \oldthebibliography{#1}%
    \setlength{\parskip}{\bibitemsep}%
    \setlength{\itemsep}{\bibparskip}%
}

% Налаштування для biblatex або стандартної бібліографії
\ifbiblatex
    \RequirePackage[backend=biber, bibstyle=gost-numeric, babel=other, isbn=true, url=false, defernumbers=true]{biblatex}
    \newbibmacro{string+url}[1]{%
        \iffieldundef{url}{#1}{\href{\thefield{url}}{#1}}%
    }
    \DeclareFieldFormat{title}{\usebibmacro{string+url}{#1}}
    \RequirePackage{csquotes}

    \DefineBibliographyStrings{ukrainian}{%
        bibliography = {Література},
    }
    \DeclareBibliographyCategory{Textbooks}
    \DeclareBibliographyCategory{Problems}
\else
    \renewcommand{\@biblabel}[1]{#1.}
    \addto\captionsukrainian{%
        \renewcommand{\bibname}{Література}%
    }
\fi

\newcommand*{\addtocategoryNoCi}[2]{\addtocategory{#1}{#2}\nocite{#2}}

%===============================================================================
% ТЕОРЕТИЧНІ ВІДОМОСТІ (TCOLORBOX)
%===============================================================================

\newtcolorbox[auto counter]{Theory}[1][]{
    breakable,
    enhanced,
    outer arc=0pt,
    arc=0pt,
    colframe=themecolordark,
    colback=themecolordark!20,
    attach boxed title to top left,
    fontupper=\small,
    before upper={\parindent15pt},
    boxed title style={
        colback=themecolordark,
        outer arc=0pt,
        arc=0pt,
        top=3pt,
        bottom=3pt,
    },
    fonttitle=\sffamily,
    colback=white,
    rightrule=0pt,
    before=\nopagebreak,
    title=Теоретичні відомості,
    overlay unbroken and first={
        \path
        let
        \p1=(title.north east),
        \p2=(frame.north east)
        in
        node[anchor=west,font=\sffamily,color=themecolordark,text width=\x2-\x1]
        at (title.east) {#1};
    }
}

% Блок увагиRemark/Attention
\newtcolorbox{Attention}[1][]{
    enhanced,
    breakable,
    before skip=2mm,
    after skip=3mm,
    before upper={\parindent15pt},
    boxrule=0.4pt,
    left=5mm,
    right=2mm,
    top=1mm,
    bottom=1mm,
    colback=red!10,
    colframe=red!50,
    sharp corners,
    rounded corners=southeast,
    arc is angular,
    arc=3mm,
    underlay={%
        \path[fill=tcbcolback!80!black] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
        \path[draw=tcbcolframe,shorten <=-0.05mm,shorten >=-0.05mm] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
        \path[fill=themecolordark,draw=none] (interior.south west) rectangle node[text=white]{\Huge\bfseries !} ([xshift=4mm]interior.north west);
    },
    drop fuzzy shadow,
    #1
}

%===============================================================================
% ЗАДАЧІ ТА ВІДПОВІДІ
%===============================================================================

% Підключення необхідних пакетів
\RequirePackage{ntheorem}
\RequirePackage{answers}
\RequirePackage{xassoccnt}

% Лічильник загальної кількості задач
\NewTotalDocumentCounter{totalproblems}

% Стиль для задач з гіперпосиланнями
\newtheoremstyle{problemstyle}%
{%
    \hypertarget{problem:\@roman{##2}}{}%
    \ifcsname r@solution\@roman{##2}\endcsname
        \item[\theorem@headerfont\hyperlink{solution:\@roman{##2}}{##2\theorem@separator}]
    \else
        \item[\theorem@headerfont##2\theorem@separator]
    \fi
}%
{%
    \hypertarget{problem:\@roman{##2}}{}%
    \ifcsname r@solution\@roman{##2}\endcsname
        \item[\theorem@headerfont\hyperlink{solution:\@roman{##2}}{##2\theorem@separator}] (##3)
    \else
        \item[\theorem@headerfont##2\theorem@separator] (##3)
    \fi
}

% Налаштування стилю задач
\theoremstyle{problemstyle}
\theoremheaderfont{\hspace{1ex}\bfseries}
\theorembodyfont{\normalfont}
\theoremseparator{.}

% Оголошення середовища для задач
\newtheorem{problem}{}[chapter]
\DeclareAssociatedCounters{problem}{totalproblems}

% Стиль оформлення для задач та відповідей
\tcbset{
    answersolutionstyle/.style={
        enhanced jigsaw,
        colframe=cyan,
        interior hidden,
        boxrule=0pt,
        frame hidden,
        breakable,
        before skip=10pt,
        after skip=10pt,
        overlay unbroken = {
            \draw[line width=1pt, themecolorlight, rounded corners] (frame.south west) rectangle (frame.north east);
        },
        extras first={
            overlay={%
                \draw[line width=1pt, themecolorlight, rounded corners]
                    (frame.south west) -- (frame.north west) -- (frame.north east) --(frame.south east);
            },
        },
        extras last={
            overlay={%
                \draw[line width=1pt, themecolorlight, rounded corners]
                    (frame.north west) -- (frame.south west) -- (frame.south east) --(frame.north east);
            },
        },
    },
}

% Застосування стилю до середовища задач
\tcolorboxenvironment{problem}{answersolutionstyle}

% --- Генерування відповідей до задач ---

% Блок для відповідей
\newtcolorbox{answerbox}{answersolutionstyle,halign=left}

% Асоціація задач та відповідей
\Newassociation{solution}{Solution}{answer}

% Середовище для відповідей
\renewenvironment{Solution}[1]{%
    \begin{answerbox}
        \hypertarget{solution:\@roman{#1}}{%
            \hyperlink{problem:\@roman{#1}}{\bfseries#1.}\label{solution\@roman{#1}}%
        }
}{%
    \end{answerbox}
}

%===============================================================================
% HYPERREF НАЛАШТУВАННЯ
%===============================================================================

\RequirePackage[%
    bookmarks = true,
    bookmarksnumbered=true,
    unicode,
    linktocpage = true,
    hypertexnames=false,
    pdftoolbar=false,
    pdfpagelayout=TwoPageRight,
    pdfauthor={Ponomarenko S.M.},
    pdfdisplaydoctitle=true,
    pdfkeywords={Electrostatics, Magnetostatics, Electrodynamics, Current, Field},
    pdfencoding=auto
]{hyperref}

\RequirePackage[all]{hypcap}

% Патч для україномовної назви розділу для nameref
\addto\extrasukrainian{%
    \renewcommand{\chapterautorefname}{}%
}

% Налаштування заголовку PDF документу
\ifdefined\inlinetitle%
    \AtBeginDocument{\hypersetup{pdftitle={\inlinetitle}}}
\fi

%===============================================================================
% КОМАНДА МНОЖИННОГО ВКЛЮЧЕННЯ ФАЙЛІВ
%===============================================================================

% Команда для включення множинних файлів розділів
\ExplSyntaxOn
\NewDocumentCommand{\multiinclude}{ m O{} }{
    \clist_set:Nx \l_Chapters_clist{ #1 }
    \clist_map_inline:Nn \l_Chapters_clist {
        \InputIfFileExists{##1/##1#2}{}{}\par
    }
}
\ExplSyntaxOff

%===============================================================================
% ЗАВЕРШЕННЯ КЛАСУ
%===============================================================================
\endinput