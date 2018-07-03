\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ppig}[2016/01/24 v2.0 LaTeX document class for PPIG16]

\LoadClass[11pt,a4paper]{article}

\RequirePackage{mathptmx}
\RequirePackage{helvet}
\RequirePackage{courier}
\RequirePackage[T1]{fontenc}
\RequirePackage{titlesec}
\RequirePackage{url}
\RequirePackage[numberedbib]{apacite}
\RequirePackage{caption}

% Page dimensions
\setlength{\paperwidth}{21cm}   % A4
\setlength{\paperheight}{29.7cm}% A4
\setlength{\textheight}{24.62cm} %A4 height - 2in (margins)
\setlength{\textwidth}{15.92cm}  %A4 width - 2in (margins)

% Set all other lengths defining the page to 0.
\setlength{\topmargin}{0cm}
\setlength{\oddsidemargin}{0cm}
\setlength{\headheight}{0cm}
\setlength{\headsep}{0cm}
\setlength{\hoffset}{0cm}
\setlength{\voffset}{0cm}

% Paragraphs are not indented, but have 6pt white space between them.
\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt}

% Lists only have 6pt white space between items.
\setlength{\topsep}{0pt}
\setlength{\partopsep}{0pt}
\setlength{\itemsep}{6pt}

% The space for the author's names & affiliations.
\newlength\titlebox 
\setlength\titlebox{4cm}

% No page numbers.
%\thispagestyle{empty}
%\pagestyle{empty}

\flushbottom \sloppy

% Sections
\titleformat*{\section}{\fontsize{11}{13}\bfseries\sffamily}
\titleformat*{\subsection}{\fontsize{11}{13}\sffamily}
\titleformat*{\subsubsection}{\fontsize{10}{12}\bfseries\sffamily}

%Section numbers have a period following them.
\titlelabel{\thetitle. }

% The numbers here are 6pt smaller than the ones in the Word version, as
% they account for the 6pt spacing between the paragraphs.
% This is caused by Latex considering sections as paragraphs as well,
% so the paragraph spacing defined above doesn't get replaced by the numbers
% here, but rather it's added to them.
%\titlespacing{\section}{0pt}{0pt plus 2pt minus 0pt}{-6pt plus 2pt minus 2pt}
%\titlespacing{\subsection}{0pt}{24pt plus 2pt minus 0pt}{-6pt plus 2pt minus 2pt}
%\titlespacing{\subsubsection}{0pt}{0pt plus 2pt minus 0pt}{-6pt plus 2pt minus 2pt}

\titlespacing{\section}{0pt}{\parskip}{0pt}
\titlespacing{\subsection}{0pt}{0pt}{-\parskip}
\titlespacing{\subsubsection}{0pt}{0pt}{-\parskip}

% Title
\newcommand*\titlefont{\fontsize{12}{16}\bfseries\sffamily}
\newcommand*\abstractfont{\fontsize{11}{13}\bfseries\sffamily}

% Title and authors
\def\@maketitle{\vbox to \titlebox{\hsize\textwidth
 \linewidth\hsize \vskip 0pt \centering
 {\titlefont{\@title} \par} \vskip 20pt plus 1pt minus 1pt
 {\def\And{\end{tabular}\hss \egroup \hskip 2cm plus 2fil 
           \hbox to 0pt \bgroup\hss \begin{tabular}[t]{c}\bf}
  \def\AND{\end{tabular}\hss \egroup \hfil\hfil\egroup
          \vskip 0.75cm plus 1fil minus 0.25cm
          \hbox to \linewidth\bgroup\large \hfil\hfil
          \hbox to 0pt \bgroup\hss \begin{tabular}[t]{c}\bf}
  \hbox to \linewidth\bgroup\large \hfil\hfil
          \hbox to 0pt \bgroup\hss \begin{tabular}[t]{c}\bf\@author 
          \end{tabular}\hss \egroup \hfil\hfil\egroup}
  \vskip 0.75cm plus 2fil minus 0.25cm
}}

% Abstract
\renewenvironment{abstract}%
		 {{\abstractfont{Abstract}}%
          \vspace*{-14pt}
		  \begin{list}{}%
		     {\setlength{\rightmargin}{0cm}%
		      \setlength{\leftmargin}{0cm}}%
		   \item[]\ignorespaces}%
		 {\unskip\end{list}
		 \vspace*{-6pt}}

% Captions
\DeclareCaptionLabelSeparator{dash}{ -- }
\captionsetup{margin=10pt, font=it, labelsep=dash}