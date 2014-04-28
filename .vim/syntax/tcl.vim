" Vim syntax file for Tcl/tk language
" Language:	Tcl
" Maintained:	SM Smithfield <m_smithfield@yahoo.com>
" Last Change:	05/01/2007 (20:03:29)
" Filenames:    *.tcl
" Version:      0.5
" ------------------------------------------------------------------
" GetLatestVimScripts: 1603 1 :AutoInstall: syntax/tcl.vim
" ------------------------------------------------------------------

" -------------------------

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Highlight Options: restart vim, after changing these options.
" let s:tcl_highlight_namespace_bold = 1
" let s:tcl_highlight_bookends = 1
" let s:tcl_highlight_primary = 1
" let s:tcl_highlight_expressions = 1
" let s:tcl_highlight_variables = 1
" let s:tcl_highlight_secondary = 1
" let s:tcl_highlight_options = 1
" let s:tcl_highlight_lcs_are_warnings = 1
" let s:tcl_comments_ignore_nested_braces = 1
let s:tcl_highlight_all = 1

" Extended Syntax:
" let s:tcl_snit_active = 1
" let s:tcl_sqlite_active = 1
" let s:tcl_critcl_active = 1
" let s:tcl_togl_active = 1
" let s:tcl_itcl_active = 1
let s:tcl_ttk_active = 1

" one more highlight than the law allows
if exists("s:tcl_highlight_bookends")
    if !hlexists("Bold")
        hi Bold guifg=fg guibg=bg gui=bold
        if version > 700
            " on colorscheme, create Bold
            augroup tclsyntax
                au!
                au ColorScheme * hi Bold guifg=fg guibg=bg gui=bold
            augroup end
        endif
    endif
endif

" -------------------------
" Basics:
" -------------------------
" see Note in :h /\@=
syn match tclKeywordGroup contained "\([^\[{* ]\)\@<!\w\+" contains=@tclKeywords,@tkKeywords
syn region tclWord1      contained start=+[^\[*#{}"\]]\&\S+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff
syn region tclWord0      contained start=+[^*#]\&\S+ end=+\s\|$+ contains=@tclWord0Cluster skipwhite nextgroup=@tclWord1Cluster
syn region tclQuotes     contained extend keepend matchgroup=tclQuotes start=+\(\\\)\@<!"+ end=+"+ skip=+\(\\\)\@<!\\"\|\(\\\\\\\)\@<!\\"\|\\\\+ contains=@tclQuotesCluster
syn region tclBrackets   contained extend keepend matchgroup=Bold start=+\(\\\)\@<!\[+ end=+]\|$+ skip=+\\\s*$\|\(\\\)\@<!\\]+ contains=@tclCommandCluster
syn region tclBraces     contained extend keepend matchgroup=Bold start=+\(\\\)\@<!{+  end=+}+ skip=+$\|\(\\\)\@<!\\}+ contains=@tclCommandCluster,tclComment
syn region tclFoldBraces contained extend keepend fold matchgroup=Bold start=+\(\\\)\@<!{+ end=+}+ skip=+$\|\(\\\)\@<!\\}+ contains=@tclCommandCluster
syn match  tclSemiColon  contained ";\s*" skipwhite nextgroup=@tclCommandCluster
if exists("s:tcl_comments_ignore_nested_braces")
    syn region tclComment    contained extend keepend start=+^\s*\#+ms=e-1 start=+\([;{]\s*\)\@<=\#+ end="\\\s\+$\|$" skip=+\\$+ contains=tclTodo,@tclLContinue,@Spell
else
    syn region tclComment       contained extend keepend start=+^\s*\#+ms=e-1 start=+\([;{]\s*\)\@<=\#+ end="\\\s\+$\|$" skip=+\\$\|\(\\\)\@<!\\}+ end="}"me=e-1 contains=tclTodo,@tclLContinue,@Spell,tclCommentBraces
    syn region tclCommentBraces contained extend keepend matchgroup=Comment start=+\(\\\)\@<!{+  end=+}+ skip=+$\|\(\\\)\@<!\\}+ 
endif

syn region tclCommand start=+[^;]\&.+ skip=+\\$+ end=+;\|$+ contains=@tclCommandCluster

syn match tclStart "\%^\s*#!.*$"
syn region tclStart start="\%^\s*#!/bin/sh"  end="^\s*exec.*$"


" -------------------------
" Clusters:
" -------------------------
syn cluster tcltkKeywords      contains=@tclKeywords,@tkKeywords
syn cluster tclKeywords        contains=tclPrimary,tclKeyword,tclException,tclConditional,tclRepeat,tclLabel,tclMagicName,tclNamespace,hmCommand,hmEntityType,hmEntityOption
syn cluster tkKeywords         contains=tkKeyword,tkReserved,tkWidget,tkDialog
" ------------------
syn cluster tclBits            contains=tclBraces,tclBrackets,tclComment,tclExpand,@tclLContinue,tclNumber,tclQuotes,tclSpecial,tkColor,tkEvent,tclSemiColon
syn cluster tclStuff           contains=@tclBits,tclVariable,tkBindSubstGroup,tkWidgetName,tclREClassGroup
syn cluster tclWord0Cluster    contains=@tclStuff
syn cluster tclWord1Cluster    contains=tclWord1,tclSecondary,tkWidgetCreate,tclConditional,@tclStuff
syn cluster tclQuotesCluster   contains=tclSpecial,@tclLContinue,@Spell
syn cluster tclLContinue       contains=tclLContinueOk,tclLContinueError
syn cluster tclCommandCluster contains=@tcltkKeywords,tclWord0,tclComment



" -------------------------
" Tcl: Syntax
" -------------------------
syn keyword tclKeyword      contained append apply auto_execok auto_import auto_load auto_mkindex auto_qualify auto_reset cd close concat eof exit fblocked flush format gets global http incr join lappend lassign lindex linsert llength load lrange lrepeat lreplace lreverse lset namespace parray pid pkg_mkIndex proc pwd registry rename return scan set split tclLog tcl_endOfWord tcl_findLibrary tcl_startOfNextWord tcl_startOfPreviousWord tcl_wordBreakAfter tcl_wordBreakBefore tell time unknown upvar variable vwait skipwhite nextgroup=tclPred
syn keyword tclMagicName    contained argc argv argv0 auto_index auto_oldpath auto_path env errorCode errorInfo tcl_interactive tcl_libpath tcl_library tlc_patchlevel tcl_pkgPath tcl_platform tcl_precision tcl_rcFileName tcl_rcRsrcName tcl_traceCompile tcl_traceExec tcl_version
" ------------------
syn keyword tkKeyword       contained bell bind clipboard console consoleinterp event focus grid pack place tkwait winfo wm
syn keyword tkKeyword       contained bindtags destroy lower option raise send tkerror tkwait tk_bisque tk_focusNext tk_focusPrev tk_focusFollowsMouse tk_popup tk_setPalette tk_textCut tk_TextCopy tk_textPaste skipwhite nextgroup=tclPred
syn keyword tkDialog        contained chooseColor tk_chooseColor tk_chooseDirectory tk_dialog tk_getOpenFile tkDialog tk_getSaveFile tk_messageBox
syn keyword tkReserved      contained tk_library tk_strictMotif tk_version
syn keyword tkWidget        contained button canvas checkbutton entry frame image label labelframe listbox menu menubutton message panedwindow radiobutton scale scrollbar spinbox toplevel skipwhite nextgroup=tkWidgetPredicate
" TODO widgets that are NOT part of tk
syn keyword tkWidget        contained table mclistbox skipwhite nextgroup=tkWidgetPredicate

syn region tclPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff

" CONDITIONALS
syn keyword tclConditional      contained if skipwhite nextgroup=tclIfCommentStart,tclExpression,@tclStuff
syn keyword tclConditional  contained elseif skipwhite nextgroup=tclExpression,@tclStuff
syn keyword tclConditional  contained else then

" REPEAT
" syn keyword tclRepeat       contained for skipwhite nextgroup=tclForStart,@tclStuff
syn keyword tclRepeat       contained for skipwhite nextgroup=tclForStart
syn match tclForStart       contained extend "\s*{[^}]\{-}}" contains=@tclCommandCluster skipwhite nextgroup=tclExpression,@tclStuff
syn keyword tclRepeat       contained while skipwhite nextgroup=tclExpression,@tclStuff
syn keyword tclRepeat       contained foreach skipwhite nextgroup=tclPred
syn keyword tclRepeat       contained break continue
syn keyword tclLabel        contained default
syn keyword tclException    contained catch error

" EXPRESSION - that presumes to be an expression, occurs in expr, conditional, loops, etc...
syn keyword tclPrimary      contained expr skipwhite nextgroup=tclExpression
syn match  tclExpression    contained "\\" skipwhite skipnl nextgroup=tclExpression contains=tclLContinueOk
syn match  tclExpression    contained extend "\\\s\+$" contains=tclLContinueError
syn region tclExpression    contained extend start=+[^ {\\]+ skip=+\\$+ end=+}\|]\|;\|$+me=e-1 contains=tclMaths,@tclStuff
" NOTE: must include '\s*' in start, for while etc don't work w/o it, I think
" this is because matching the whitespace allows the expression to supercede
" the other regions
syn region tclExpression    contained keepend extend matchgroup=Bold start=+\s*{+ end=+}+ skip=+$\|\\}+ contains=tclMaths,@tclStuff
syn keyword tclMaths        contained abs acos asin atan atan2 bool ceil cos cosh double entier exp floor fmod hypot int isqrt log log10 max min pow rand round sin sinh sqrt srand tan tanh wide
syn keyword tclMaths        contained ne eq in ni
syn match tclMaths          contained "[()^%~<>!=+*\-|&?:/]"

" IF - permits use of if{0} {} commenting idiom
syn region tclIfComment     contained extend keepend matchgroup=Comment start=+\(\\\)\@<!{+  skip=+$\|\\}+ end=+}+ contains=tclIfComment,tclTodo,@Spell
syn match tclIfCommentStart contained extend  "\s*\(0\|{0}\)" skipwhite nextgroup=tclIfComment

" PROC - proc name hilite AND folding
syn keyword tclPrimary      contained proc skipwhite nextgroup=tclProcName
" def-script pattern
syn match tclProcDef        contained "\S\+" skipwhite nextgroup=tclFoldBraces
" type-name-args-script pattern
syn match tclProcType       contained "\S\+" skipwhite nextgroup=tclProcName
syn match tclProcName       contained "\S\+" skipwhite nextgroup=tclProcArgs
syn region tclProcArgs      contained extend keepend excludenl matchgroup=Bold start=+\(\\\)\@<!{+  skip=+$\|\\}+ end=+}+ contains=tclProcArgs skipwhite nextgroup=tclFoldBraces


" -------------------------
" Tcl: Syntax - Bits
" -------------------------
syn keyword tclTodo         contained TODO
syn match tkEvent           contained "<\S\+>"
syn match tkEvent           contained "<<.\+>>"
syn match tkColor           contained "#[0-9A-Fa-f]\{6}\|#[0-9A-Fa-f]\{3}"
syn match tclNumber         contained "\<\d\+\(u\=l\=\|lu\|f\|L\)\>"
syn match tclNumber         contained "\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match tclNumber         contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match tclNumber         contained "\<\d\+e[-+]\=\d\+[fl]\=\>"
syn match tclNumber         contained "0x[0-9a-f]\+\(u\=l\=\|lu\)\>"
syn match tclVariable       contained "\$\(\(:\{2,}\)\?\([[:alnum:]_]*::\)*\)[[:alnum:]_]*"
syn region tclVariable      contained start=+\$\(\(:\{2,}\)\?\([[:alnum:]_]*::\)*\)[[:alnum:]_]\+(+ skip=+\\)+ end=+)+ contains=@tclStuff
syn match tclVariable       contained extend "${[^}]*}"
syn match tclSpecial        contained "\\\d\d\d\=\|\\."
syn match tkWidgetName      contained "\([[:alnum:]]\)\@<!\.[[:alpha:]][[:alnum:]]*\(\.[[:alpha:]][[:alnum:]]*\)*\>"
if exists("s:tcl_highlight_lcs_are_warnings")
    syn match tclLContinueOk    contained "\\$"
else
    syn match tclLContinueOk    contained "\\$" transparent
endif
syn match tclLContinueError contained "\\\s\+$" excludenl
syn match tclExpand         contained extend "{expand}"
syn match tclExpand         contained extend "{\*}"
syn match tclREClassGroup   contained extend +\(\\\)\@<!\[^\?\[:\(\w\+\|[<>]\):]_\?]+  contains=tclREClass
syn keyword tclREClass contained alpha upper lower digit xdigit alnum print blank space punct graph cntrl 



" -------------------------
" Tcl: Syntax - Keyword Predicates
" -------------------------

" SPECIAL CASE: predicate can contain a command 
syn region tclListPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclCommandCluster
syn keyword tclPrimary contained eval list skipwhite nextgroup=tclListPred


" SPECIAL CASE: contains a command and a leve
syn region tclUplevelPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclCommandCluster
syn match tclUplevelLevel contained "\S\+" contains=@tclCommandCluster skipwhite nextgroup=tclUplevelPred
syn keyword tclPrimary contained uplevel skipwhite nextgroup=tclUplevelLevel


" SPECIAL CASE: FOLDING
syn keyword tclPrimary                        contained namespace skipwhite nextgroup=tclNamespacePred
syn keyword tclNamespaceCmds                  contained children code current delete eval exists forget inscope origin parent path qualifiers tail unknown upvar
syn region tclNamespacePred                   contained keepend fold start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceCmds,tclNamespaceEnsemble,@tclStuff
syn match tclNamespaceExportOptsGroup         contained "-\a\+" contains=tclNamespaceExportOpts
syn keyword tclNamespaceExportOpts            contained clear force command variable
syn region tclNamespaceExportPred             contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceExportOptsGroup,@tclStuff
syn keyword tclNamespaceCmds                  contained export import which skipwhite nextgroup=tclNamespaceExportPred
syn match tclNamespaceEnsembleExistsOptsGroup contained "-\a\+" contains=tclNamespaceEnsembleExistsOpts
syn keyword tclNamespaceEnsembleExistsOpts    contained map prefixes subcommands unknown command namespace
syn region tclNamespaceEnsembleExistsPred     contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceEnsembleExistsOptsGroup,@tclStuff
syn keyword tclNamespaceEnsembleCmds          contained exists create configure skipwhite nextgroup=tclNamespaceEnsembleExistsPred
syn region tclNamespaceEnsemblePred           contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclNamespaceEnsembleCmds,@tclStuff
syn keyword tclNamespaceEnsemble              contained ensemble skipwhite nextgroup=tclNamespaceEnsemblePred


syn keyword tclPrimary contained puts read skipwhite nextgroup=tclPutsPred
syn region tclPutsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclPutsOptsGroup,@tclStuff
syn match tclPutsOptsGroup contained "-\a\+" contains=tclPutsOpts
syn keyword tclPutsOpts contained nonewline

syn keyword tclPrimary contained return skipwhite nextgroup=tclReturnPred
syn region tclReturnPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclReturnOptsGroup,@tclStuff
syn match tclReturnOptsGroup contained "-\a\+" contains=tclReturnOpts
syn keyword tclReturnOpts contained code errorcode errorinfo level options

syn keyword tclPrimary contained source skipwhite nextgroup=tclSourcePred
syn region tclSourcePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSourceOptsGroup,@tclStuff
syn match tclSourceOptsGroup contained "-\a\+" contains=tclSourceOpts
syn keyword tclSourceOpts contained encoding

syn keyword tclPrimary contained after skipwhite nextgroup=tclAfterPred
syn region tclAfterPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclAfterCmds,@tclStuff
syn keyword tclAfterCmds contained cancel idle info skipwhite nextgroup=tclAfterCmdsCancelPred
syn region tclAfterCmdsCancelPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained array skipwhite nextgroup=tclArrayPred
syn region tclArrayPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclArrayCmds,@tclStuff
syn keyword tclArrayCmds contained anymore donesearch exists get nextelement set size startsearch statistics unset skipwhite nextgroup=tclArrayCmdsAnymorePred
syn region tclArrayCmdsAnymorePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclArrayCmdsNamesOptsGroup contained "-\a\+" contains=tclArrayCmdsNamesOpts
syn keyword tclArrayCmdsNamesOpts contained exact glob regexp
syn keyword tclArrayCmds contained names skipwhite nextgroup=tclArrayCmdsNamesPred
syn region tclArrayCmdsNamesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclArrayCmdsNamesOptsGroup,@tclStuff skipwhite nextgroup=tclArrayCmds

syn keyword tclPrimary contained binary skipwhite nextgroup=tclBinaryPred
syn region tclBinaryPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclBinaryCmds,@tclStuff
syn keyword tclBinaryCmds contained format scan skipwhite nextgroup=tclBinaryCmdsFormatPred
syn region tclBinaryCmdsFormatPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained encoding skipwhite nextgroup=tclEncodingPred
syn region tclEncodingPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclEncodingCmds,@tclStuff
syn keyword tclEncodingCmds contained convertfrom convertto names system skipwhite nextgroup=tclEncodingCmdsConvertfromPred
syn region tclEncodingCmdsConvertfromPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained info skipwhite nextgroup=tclInfoPred
syn region tclInfoPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInfoCmds,@tclStuff
syn keyword tclInfoCmds contained args body cmdcount commands complete default exists frame functions globals hostname level library loaded locals nameofexecutable patchlevel procs script sharedlibextension tclversion vars skipwhite nextgroup=tclInfoCmdsArgsPred
syn region tclInfoCmdsArgsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained memory skipwhite nextgroup=tclMemoryPred
syn region tclMemoryPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclMemoryCmds,@tclStuff
syn keyword tclMemoryCmds contained active break info init onexit tag trace validate skipwhite nextgroup=tclMemoryCmdsActivePred
syn region tclMemoryCmdsActivePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained update skipwhite nextgroup=tclUpdatePred
syn region tclUpdatePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclUpdateCmds,@tclStuff
syn keyword tclUpdateCmds contained idletasks skipwhite nextgroup=tclUpdateCmdsIdletasksPred
syn region tclUpdateCmdsIdletasksPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained exec skipwhite nextgroup=tclExecPred
syn region tclExecPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclExecOptsGroup,@tclStuff
syn match tclExecOptsGroup contained "-\a\+" contains=tclExecOpts
syn keyword tclExecOpts contained keepnewline ignorestderr

syn keyword tclPrimary contained glob skipwhite nextgroup=tclGlobPred
syn region tclGlobPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclGlobOptsGroup,@tclStuff
syn match tclGlobOptsGroup contained "-\a\+" contains=tclGlobOpts
syn keyword tclGlobOpts contained directory join nocomplain path tails types

syn keyword tclPrimary contained regexp skipwhite nextgroup=tclRegexpPred
syn region tclRegexpPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclRegexpOptsGroup,@tclStuff
syn match tclRegexpOptsGroup contained "-\a\+" contains=tclRegexpOpts
syn keyword tclRegexpOpts contained about expanded indicies line linestop lineanchor nocase all inline start

syn keyword tclPrimary contained regsub skipwhite nextgroup=tclRegsubPred
syn region tclRegsubPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclRegsubOptsGroup,@tclStuff
syn match tclRegsubOptsGroup contained "-\a\+" contains=tclRegsubOpts
syn keyword tclRegsubOpts contained all expanded line linestop nocase start

syn keyword tclPrimary contained switch skipwhite nextgroup=tclSwitchPred
syn region tclSwitchPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSwitchOptsGroup,@tclStuff
syn match tclSwitchOptsGroup contained "-\a\+" contains=tclSwitchOpts
syn keyword tclSwitchOpts contained exact glob regexp nocase matchvar indexvar

syn keyword tclPrimary contained unload skipwhite nextgroup=tclUnloadPred
syn region tclUnloadPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclUnloadOptsGroup,@tclStuff
syn match tclUnloadOptsGroup contained "-\a\+" contains=tclUnloadOpts
syn keyword tclUnloadOpts contained nocomplain keeplibrary

syn keyword tclPrimary contained unset skipwhite nextgroup=tclUnsetPred
syn region tclUnsetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclUnsetOptsGroup,@tclStuff
syn match tclUnsetOptsGroup contained "-\a\+" contains=tclUnsetOpts
syn keyword tclUnsetOpts contained nocomplain

syn keyword tclPrimary contained subst skipwhite nextgroup=tclSubstPred
syn region tclSubstPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSubstOptsGroup,@tclStuff
syn match tclSubstOptsGroup contained "-\a\+" contains=tclSubstOpts
syn keyword tclSubstOpts contained nocommands novariables nobackslashes

syn keyword tclPrimary contained lsearch skipwhite nextgroup=tclLsearchPred
syn region tclLsearchPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclLsearchOptsGroup,@tclStuff
syn match tclLsearchOptsGroup contained "-\a\+" contains=tclLsearchOpts
syn keyword tclLsearchOpts contained exact glob regexp sorted all inline not ascii dictionary integer nocase real decreasing increasing subindices
syn match tclLsearchOptsGroup contained "-\a\+" contains=tclLsearchOpts
syn keyword tclLsearchOpts contained start index

syn keyword tclPrimary contained lsort skipwhite nextgroup=tclLsortPred
syn region tclLsortPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclLsortOptsGroup,@tclStuff
syn match tclLsortOptsGroup contained "-\a\+" contains=tclLsortOpts
syn keyword tclLsortOpts contained ascii dictionary integer real increasing decreasing indicies nocase unique
syn match tclLsortOptsGroup contained "-\a\+" contains=tclLsortOpts
syn keyword tclLsortOpts contained command index

syn keyword tclPrimary contained fconfigure skipwhite nextgroup=tclFconfigurePred
syn region tclFconfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFconfigureOptsGroup,@tclStuff
syn match tclFconfigureOptsGroup contained "-\a\+" contains=tclFconfigureOpts
syn keyword tclFconfigureOpts contained blocking buffering buffersize encoding eofchar error
syn match tclFconfigureOptsGroup contained "-\a\+" contains=tclFconfigureOpts
syn keyword tclFconfigureOpts contained translation

syn keyword tclPrimary contained fcopy skipwhite nextgroup=tclFcopyPred
syn region tclFcopyPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFcopyOptsGroup,@tclStuff
syn match tclFcopyOptsGroup contained "-\a\+" contains=tclFcopyOpts
syn keyword tclFcopyOpts contained size command

syn keyword tclPrimary contained socket skipwhite nextgroup=tclSocketPred
syn region tclSocketPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSocketOptsGroup,@tclStuff
syn match tclSocketOptsGroup contained "-\a\+" contains=tclSocketOpts
syn keyword tclSocketOpts contained server myaddr myport async myaddr error sockname peername

syn keyword tclPrimary contained fileevent skipwhite nextgroup=tclFileeventPred
syn region tclFileeventPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileeventCmds,@tclStuff
syn keyword tclFileeventCmds contained readable writable skipwhite nextgroup=tclFileeventCmdsReadablePred
syn region tclFileeventCmdsReadablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained open skipwhite nextgroup=tclOpenPred
syn region tclOpenPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclOpenOptsGroup,@tclStuff
syn match tclOpenOptsGroup contained "-\a\+" contains=tclOpenOpts
syn keyword tclOpenOpts contained mode handshake queue timeout ttycontrol ttystatus xchar pollinterval sysbuffer lasterror

syn keyword tclPrimary contained seek skipwhite nextgroup=tclSeekPred
syn region tclSeekPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclSeekCmds,@tclStuff
syn keyword tclSeekCmds contained start current end skipwhite nextgroup=tclSeekCmdsStartPred
syn region tclSeekCmdsStartPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tclPrimary contained clock skipwhite nextgroup=tclClockPred
syn region tclClockPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclClockCmds,@tclStuff
syn keyword tclClockCmds contained microseconds milliseconds seconds skipwhite nextgroup=tclClockCmdsMicrosecondsPred
syn region tclClockCmdsMicrosecondsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclClockCmdsAddOptsGroup contained "-\a\+" contains=tclClockCmdsAddOpts
syn keyword tclClockCmdsAddOpts contained base format gmt locale timezone
syn keyword tclClockCmds contained add clicks format scan skipwhite nextgroup=tclClockCmdsAddPred
syn region tclClockCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclClockCmdsAddOptsGroup,@tclStuff skipwhite nextgroup=tclClockCmds

syn keyword tclPrimary contained dict skipwhite nextgroup=tclDictPred
syn region tclDictPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclDictCmds,@tclStuff
syn keyword tclDictCmds contained append create exists for get incr info keys lappend merge remove replace set size unset update values with skipwhite nextgroup=tclDictCmdsAppendPred
syn region tclDictCmdsAppendPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclDictCmdsFilterOptsGroup contained "-\a\+" contains=tclDictCmdsFilterOpts
syn keyword tclDictCmdsFilterOpts contained key script value
syn keyword tclDictCmds contained filter skipwhite nextgroup=tclDictCmdsFilterPred
syn region tclDictCmdsFilterPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclDictCmdsFilterOptsGroup,@tclStuff skipwhite nextgroup=tclDictCmds

syn keyword tclPrimary contained chan skipwhite nextgroup=tclChanPred
syn region tclChanPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmds,@tclStuff
syn keyword tclChanCmds contained blocked close create eof event flush gets names pending postevent seek tell truncate skipwhite nextgroup=tclChanCmdsBlockedPred
syn region tclChanCmdsBlockedPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclChanCmdsConfigureOptsGroup contained "-\a\+" contains=tclChanCmdsConfigureOpts
syn keyword tclChanCmdsConfigureOpts contained blocking buffering buffersize encoding eofchar translation
syn keyword tclChanCmds contained configure skipwhite nextgroup=tclChanCmdsConfigurePred
syn region tclChanCmdsConfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmdsConfigureOptsGroup,@tclStuff skipwhite nextgroup=tclChanCmds
syn match tclChanCmdsCopyOptsGroup contained "-\a\+" contains=tclChanCmdsCopyOpts
syn keyword tclChanCmdsCopyOpts contained size command
syn keyword tclChanCmds contained copy skipwhite nextgroup=tclChanCmdsCopyPred
syn region tclChanCmdsCopyPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmdsCopyOptsGroup,@tclStuff skipwhite nextgroup=tclChanCmds
syn match tclChanCmdsPutsOptsGroup contained "-\a\+" contains=tclChanCmdsPutsOpts
syn keyword tclChanCmdsPutsOpts contained nonewline
syn keyword tclChanCmds contained puts read skipwhite nextgroup=tclChanCmdsPutsPred
syn region tclChanCmdsPutsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclChanCmdsPutsOptsGroup,@tclStuff skipwhite nextgroup=tclChanCmds
syn keyword tclSecondary contained initialize finalize watch read write seek configure cget cgetall blocking skipwhite nextgroup=tclChanSUBInitializePred
syn region tclChanSUBInitializePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff

syn keyword tclPrimary contained file skipwhite nextgroup=tclFilePred
syn region tclFilePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileCmds,@tclStuff
syn keyword tclFileCmds contained channels dirname executable exists extension isdirectory isfile join link lstat mkdir mtime nativename normalize owned pathtype readable readlink rootname separator size split stat system tail volumes writable skipwhite nextgroup=tclFileCmdsChannelsPred
syn region tclFileCmdsChannelsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclFileCmdsAtimeOptsGroup contained "-\a\+" contains=tclFileCmdsAtimeOpts
syn keyword tclFileCmdsAtimeOpts contained time
syn keyword tclFileCmds contained atime skipwhite nextgroup=tclFileCmdsAtimePred
syn region tclFileCmdsAtimePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileCmdsAtimeOptsGroup,@tclStuff skipwhite nextgroup=tclFileCmds
syn match tclFileCmdsCopyOptsGroup contained "-\a\+" contains=tclFileCmdsCopyOpts
syn keyword tclFileCmdsCopyOpts contained force
syn keyword tclFileCmds contained copy delete rename skipwhite nextgroup=tclFileCmdsCopyPred
syn region tclFileCmdsCopyPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$\|--+ contains=tclFileCmdsCopyOptsGroup,@tclStuff skipwhite nextgroup=tclFileCmds
syn match tclFileCmdsAttributesOptsGroup contained "-\a\+" contains=tclFileCmdsAttributesOpts
syn keyword tclFileCmdsAttributesOpts contained group owner permissions readonly archive hidden longname shortname system creator rsrclength
syn keyword tclFileCmds contained attributes skipwhite nextgroup=tclFileCmdsAttributesPred
syn region tclFileCmdsAttributesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclFileCmdsAttributesOptsGroup,@tclStuff skipwhite nextgroup=tclFileCmds

syn keyword tclPrimary contained history skipwhite nextgroup=tclHistoryPred
syn region tclHistoryPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclHistoryCmds,@tclStuff
syn keyword tclHistoryCmds contained change clear event info keep nextid redo skipwhite nextgroup=tclHistoryCmdsChangePred
syn region tclHistoryCmdsChangePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclHistoryCmdsAddCmds contained exec skipwhite nextgroup=tclHistoryCmdsAddCmdsExecPred
syn region tclHistoryCmdsAddCmdsExecPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclHistoryCmds contained add skipwhite nextgroup=tclHistoryCmdsAddPred
syn region tclHistoryCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclHistoryCmdsAddCmds,@tclStuff skipwhite nextgroup=tclHistoryCmds

syn keyword tclPrimary contained package skipwhite nextgroup=tclPackagePred
syn region tclPackagePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclPackageCmds,@tclStuff
syn keyword tclPackageCmds contained forget ifneeded names provide unknown vcompare versions vsatisfies skipwhite nextgroup=tclPackageCmdsForgetPred
syn region tclPackageCmdsForgetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclPackageCmdsPresentOptsGroup contained "-\a\+" contains=tclPackageCmdsPresentOpts
syn keyword tclPackageCmdsPresentOpts contained exact
syn keyword tclPackageCmds contained present require skipwhite nextgroup=tclPackageCmdsPresentPred
syn region tclPackageCmdsPresentPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclPackageCmdsPresentOptsGroup,@tclStuff skipwhite nextgroup=tclPackageCmds


syn keyword tclPrimary contained string skipwhite nextgroup=tclStringPred
syn region tclStringPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmds,@tclStuff
syn keyword tclStringCmds contained bytelength first index last length range repeat replace reverse tolower totitle toupper trim trimleft trimright wordend wordstart skipwhite nextgroup=tclStringCmdsBytelengthPred
syn region tclStringCmdsBytelengthPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tclStringCmdsCompareOptsGroup contained "-\a\+" contains=tclStringCmdsCompareOpts
syn keyword tclStringCmdsCompareOpts contained nocase length
syn keyword tclStringCmds contained compare equal skipwhite nextgroup=tclStringCmdsComparePred
syn region tclStringCmdsComparePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsCompareOptsGroup,@tclStuff skipwhite nextgroup=tclStringCmds
syn match tclStringCmdsMapOptsGroup contained "-\a\+" contains=tclStringCmdsMapOpts
syn keyword tclStringCmdsMapOpts contained nocase
syn keyword tclStringCmds contained map match skipwhite nextgroup=tclStringCmdsMapPred
syn region tclStringCmdsMapPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsMapOptsGroup,@tclStuff skipwhite nextgroup=tclStringCmds
syn match tclStringCmdsIsClassAlnumOptsGroup contained "-\a\+" contains=tclStringCmdsIsClassAlnumOpts
syn keyword tclStringCmdsIsClassAlnumOpts contained strict failindex
syn keyword tclStringCmdsIsClass contained alnum alpha ascii boolean control digit double false graph integer list lower print punct space true upper wideinteger wordchar xdigit skipwhite nextgroup=tclStringCmdsIsClassAlnumPred
syn region tclStringCmdsIsClassAlnumPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsIsClassAlnumOptsGroup,@tclStuff skipwhite nextgroup=tclStringCmdsIsClass
syn keyword tclStringCmds contained is skipwhite nextgroup=tclStringCmdsIsPred
syn region tclStringCmdsIsPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclStringCmdsIsClass,@tclStuff skipwhite nextgroup=tclStringCmds

syn keyword tclPrimary contained trace skipwhite nextgroup=tclTracePred
syn region tclTracePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmds,@tclStuff
syn keyword tclTraceCmds contained variable vdelete vinfo skipwhite nextgroup=tclTraceCmdsVariablePred
syn region tclTraceCmdsVariablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmdsCommandCmds contained rename trace skipwhite nextgroup=tclTraceCmdsAddCmdsCommandCmdsRenamePred
syn region tclTraceCmdsAddCmdsCommandCmdsRenamePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmds contained command skipwhite nextgroup=tclTraceCmdsAddCmdsCommandPred
syn region tclTraceCmdsAddCmdsCommandPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmdsCommandCmds,@tclStuff skipwhite nextgroup=tclTraceCmdsAddCmds
syn keyword tclTraceCmds contained add remove info skipwhite nextgroup=tclTraceCmdsAddPred
syn region tclTraceCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmds,@tclStuff skipwhite nextgroup=tclTraceCmds
syn keyword tclTraceCmdsAddCmdsExecutionCmds contained enter leave enterstep leavestep skipwhite nextgroup=tclTraceCmdsAddCmdsExecutionCmdsEnterPred
syn region tclTraceCmdsAddCmdsExecutionCmdsEnterPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmds contained execution skipwhite nextgroup=tclTraceCmdsAddCmdsExecutionPred
syn region tclTraceCmdsAddCmdsExecutionPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmdsExecutionCmds,@tclStuff skipwhite nextgroup=tclTraceCmdsAddCmds
syn keyword tclTraceCmds contained add remove info skipwhite nextgroup=tclTraceCmdsAddPred
syn region tclTraceCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmds,@tclStuff skipwhite nextgroup=tclTraceCmds
syn keyword tclTraceCmdsAddCmdsVariableCmds contained array read write unset skipwhite nextgroup=tclTraceCmdsAddCmdsVariableCmdsArrayPred
syn region tclTraceCmdsAddCmdsVariableCmdsArrayPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclTraceCmdsAddCmds contained variable skipwhite nextgroup=tclTraceCmdsAddCmdsVariablePred
syn region tclTraceCmdsAddCmdsVariablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmdsVariableCmds,@tclStuff skipwhite nextgroup=tclTraceCmdsAddCmds
syn keyword tclTraceCmds contained add remove info skipwhite nextgroup=tclTraceCmdsAddPred
syn region tclTraceCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclTraceCmdsAddCmds,@tclStuff skipwhite nextgroup=tclTraceCmds

syn keyword tclPrimary contained interp skipwhite nextgroup=tclInterpPred
syn region tclInterpPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmds,@tclStuff
syn match tclInterpCmdsCreateOptsGroup contained "-\a\+" contains=tclInterpCmdsCreateOpts
syn keyword tclInterpCmdsCreateOpts contained safe
syn keyword tclInterpCmds contained create skipwhite nextgroup=tclInterpCmdsCreatePred
syn region tclInterpCmdsCreatePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmdsCreateOptsGroup,@tclStuff skipwhite nextgroup=tclInterpCmds
syn match tclInterpCmdsInvokehiddenOptsGroup contained "-\a\+" contains=tclInterpCmdsInvokehiddenOpts
syn keyword tclInterpCmdsInvokehiddenOpts contained namespace global
syn keyword tclInterpCmds contained invokehidden skipwhite nextgroup=tclInterpCmdsInvokehiddenPred
syn region tclInterpCmdsInvokehiddenPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmdsInvokehiddenOptsGroup,@tclStuff skipwhite nextgroup=tclInterpCmds
syn match tclInterpCmdsLimitOptsGroup contained "-\a\+" contains=tclInterpCmdsLimitOpts
syn keyword tclInterpCmdsLimitOpts contained command granularity milliseconds seconds value
syn keyword tclInterpCmds contained limit skipwhite nextgroup=tclInterpCmdsLimitPred
syn region tclInterpCmdsLimitPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpCmdsLimitOptsGroup,@tclStuff skipwhite nextgroup=tclInterpCmds
syn keyword tclInterpCmds contained alias aliases bgerror delete eval exists expose hide hidden issafe marktrusted recursionlimit share slaves target transfer skipwhite nextgroup=tclInterpCmdsAliasPred
syn region tclInterpCmdsAliasPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn keyword tclSecondary contained aliases alias bgerror eval expose hide hidden issafe marktrusted recursionlimit skipwhite nextgroup=tclInterpSUBAliasesPred
syn region tclInterpSUBAliasesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff
syn keyword tclSecondary contained invokehidden skipwhite nextgroup=tclInterpSUBInvokehiddenPred
syn region tclInterpSUBInvokehiddenPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpSUBInvokehiddenOptsGroup,@tclStuff
syn match tclInterpSUBInvokehiddenOptsGroup contained "-\a\+" contains=tclInterpSUBInvokehiddenOpts
syn keyword tclInterpSUBInvokehiddenOpts contained namespace global
syn keyword tclSecondary contained limit skipwhite nextgroup=tclInterpSUBLimitPred
syn region tclInterpSUBLimitPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tclInterpSUBLimitOptsGroup,@tclStuff
syn match tclInterpSUBLimitOptsGroup contained "-\a\+" contains=tclInterpSUBLimitOpts
syn keyword tclInterpSUBLimitOpts contained command granularity milliseconds seconds value

syn keyword tkKeyword contained bell skipwhite nextgroup=tkBellPred
syn region tkBellPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkBellOptsGroup,@tclStuff
syn match tkBellOptsGroup contained "-\a\+" contains=tkBellOpts
syn keyword tkBellOpts contained nice displayof

syn keyword tkKeyword contained clipboard skipwhite nextgroup=tkClipboardPred
syn region tkClipboardPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkClipboardCmds,@tclStuff
syn match tkClipboardCmdsClearOptsGroup contained "-\a\+" contains=tkClipboardCmdsClearOpts
syn keyword tkClipboardCmdsClearOpts contained displayof format type
syn keyword tkClipboardCmds contained clear append get skipwhite nextgroup=tkClipboardCmdsClearPred
syn region tkClipboardCmdsClearPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkClipboardCmdsClearOptsGroup,@tclStuff skipwhite nextgroup=tkClipboardCmds

syn keyword tkKeyword contained console consoleinterp skipwhite nextgroup=tkConsolePred
syn region tkConsolePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkConsoleCmds,@tclStuff
syn keyword tkConsoleCmds contained eval hide show title record skipwhite nextgroup=tkConsoleCmdsEvalPred
syn region tkConsoleCmdsEvalPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained focus skipwhite nextgroup=tkFocusPred
syn region tkFocusPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFocusOptsGroup,@tclStuff
syn match tkFocusOptsGroup contained "-\a\+" contains=tkFocusOpts
syn keyword tkFocusOpts contained displayof force lastfor

syn keyword tkKeyword contained tkwait skipwhite nextgroup=tkTkwaitPred
syn region tkTkwaitPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkwaitCmds,@tclStuff
syn keyword tkTkwaitCmds contained variable visibility window skipwhite nextgroup=tkTkwaitCmdsVariablePred
syn region tkTkwaitCmdsVariablePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained winfo skipwhite nextgroup=tkWinfoPred
syn region tkWinfoPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWinfoCmds,@tclStuff
syn keyword tkWinfoCmds contained containing interps pathname visualscells children class colormapfull depth exists fpixels geom[etry] height id ismapped manager name parent pixels pointerx pointerxy pointery reqheight reqwidth rgb rootx rooty screen screencells screendepth screenheight screenmmheight screenmmwidth screenvisual screenwidth server toplevel viewable visual visualid vrootheight vrootwidth vrootx vrooty width x y skipwhite nextgroup=tkWinfoCmdsContainingPred
syn region tkWinfoCmdsContainingPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkWinfoCmdsAtomOptsGroup contained "-\a\+" contains=tkWinfoCmdsAtomOpts
syn keyword tkWinfoCmdsAtomOpts contained displayof includeids
syn keyword tkWinfoCmds contained atom atomname containing interps pathname visualsavailable skipwhite nextgroup=tkWinfoCmdsAtomPred
syn region tkWinfoCmdsAtomPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWinfoCmdsAtomOptsGroup,@tclStuff skipwhite nextgroup=tkWinfoCmds

syn keyword tkKeyword contained wm skipwhite nextgroup=tkWmPred
syn region tkWmPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWmCmds,@tclStuff
syn keyword tkWmCmds contained aspect attributes attributes attributes client colormapwindows command deiconify focusmodel frame geom[etry] grid group iconbitmap iconify iconmask iconname iconphoto iconposition iconwindow maxsize minsize overrideredirect positionfrom protocol resizable sizefrom stackorder state title transient withdraw skipwhite nextgroup=tkWmCmdsAspectPred
syn region tkWmCmdsAspectPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained grab skipwhite nextgroup=tkGrabPred
syn region tkGrabPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkGrabOptsGroup,tkGrabCmds,@tclStuff
syn keyword tkGrabCmds contained current release set status skipwhite nextgroup=tkGrabOptsGroup skipwhite nextgroup=tkGrabCmdsCurrentPred
syn region tkGrabCmdsCurrentPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkGrabOptsGroup contained "-\a\+" contains=tkGrabOpts
syn keyword tkGrabOpts contained global

syn keyword tkKeyword contained font skipwhite nextgroup=tkFontPred
syn region tkFontPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFontCmds,@tclStuff
syn keyword tkFontCmds contained delete names skipwhite nextgroup=tkFontCmdsDeletePred
syn region tkFontCmdsDeletePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkFontCmdsFamiliesOptsGroup contained "-\a\+" contains=tkFontCmdsFamiliesOpts
syn keyword tkFontCmdsFamiliesOpts contained displayof
syn keyword tkFontCmds contained families measure skipwhite nextgroup=tkFontCmdsFamiliesPred
syn region tkFontCmdsFamiliesPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFontCmdsFamiliesOptsGroup,@tclStuff skipwhite nextgroup=tkFontCmds
syn match tkFontCmdsActualOptsGroup contained "-\a\+" contains=tkFontCmdsActualOpts
syn keyword tkFontCmdsActualOpts contained displayof ascent descent linespace fixed family size weight slant underline overstrike
syn keyword tkFontCmds contained actual configure create metrics skipwhite nextgroup=tkFontCmdsActualPred
syn region tkFontCmdsActualPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkFontCmdsActualOptsGroup,@tclStuff skipwhite nextgroup=tkFontCmds

syn keyword tkKeyword contained option skipwhite nextgroup=tkOptionPred
syn region tkOptionPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkOptionCmds,@tclStuff
syn keyword tkOptionCmds contained add clear get readfile skipwhite nextgroup=tkOptionCmdsAddPred
syn region tkOptionCmdsAddPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff

syn keyword tkKeyword contained grid skipwhite nextgroup=tkGridPred
syn region tkGridPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkGridOptsGroup,tkGridCmds,@tclStuff
syn keyword tkGridCmds contained anchor bbox forget info location propogate remove size slaves skipwhite nextgroup=tkGridCmdsAnchorPred
syn region tkGridCmdsAnchorPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkGridCmdsColumnconfigureOptsGroup contained "-\a\+" contains=tkGridCmdsColumnconfigureOpts
syn keyword tkGridCmdsColumnconfigureOpts contained column columnspan in ipadx ipady padx pady row rowspan sticky minsize weight uniform pad
syn keyword tkGridCmds contained columnconfigure rowconfigure configure skipwhite nextgroup=tkGridCmdsColumnconfigurePred
syn region tkGridCmdsColumnconfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkGridCmdsColumnconfigureOptsGroup,@tclStuff skipwhite nextgroup=tkGridCmds
syn match tkGridOptsGroup contained "-\a\+" contains=tkGridOpts
syn keyword tkGridOpts contained column columnspan in ipadx ipady padx pady row rowspan sticky minsize weight uniform pad

syn keyword tkKeyword contained pack skipwhite nextgroup=tkPackPred
syn region tkPackPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPackOptsGroup,tkPackCmds,@tclStuff
syn keyword tkPackCmds contained forget info propogate slaves skipwhite nextgroup=tkPackCmdsForgetPred
syn region tkPackCmdsForgetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkPackCmdsConfigureOptsGroup contained "-\a\+" contains=tkPackCmdsConfigureOpts
syn keyword tkPackCmdsConfigureOpts contained after anchor before expand fill in ipadx ipady padx pady side
syn keyword tkPackCmds contained configure skipwhite nextgroup=tkPackCmdsConfigurePred
syn region tkPackCmdsConfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPackCmdsConfigureOptsGroup,@tclStuff skipwhite nextgroup=tkPackCmds
syn match tkPackOptsGroup contained "-\a\+" contains=tkPackOpts
syn keyword tkPackOpts contained after anchor before expand fill in ipadx ipady padx pady side

syn keyword tkKeyword contained place skipwhite nextgroup=tkPlacePred
syn region tkPlacePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPlaceOptsGroup,tkPlaceCmds,@tclStuff
syn keyword tkPlaceCmds contained forget info slaves skipwhite nextgroup=tkPlaceCmdsForgetPred
syn region tkPlaceCmdsForgetPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkPlaceCmdsConfigureOptsGroup contained "-\a\+" contains=tkPlaceCmdsConfigureOpts
syn keyword tkPlaceCmdsConfigureOpts contained anchor bordermode height in relheight relwidth relx rely width x y
syn keyword tkPlaceCmds contained configure skipwhite nextgroup=tkPlaceCmdsConfigurePred
syn region tkPlaceCmdsConfigurePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPlaceCmdsConfigureOptsGroup,@tclStuff skipwhite nextgroup=tkPlaceCmds
syn match tkPlaceOptsGroup contained "-\a\+" contains=tkPlaceOpts
syn keyword tkPlaceOpts contained anchor bordermode height in relheight relwidth relx rely width x y

syn keyword tkKeyword contained tk_messageBox skipwhite nextgroup=tkTk_messageboxPred
syn region tkTk_messageboxPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTk_messageboxOptsGroup,@tclStuff
syn match tkTk_messageboxOptsGroup contained "-\a\+" contains=tkTk_messageboxOpts
syn keyword tkTk_messageboxOpts contained default detail icon message parent title type

syn keyword tkKeyword contained tk skipwhite nextgroup=tkTkPred
syn region tkTkPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmds,@tclStuff
syn keyword tkTkCmds contained appname windowingsystem skipwhite nextgroup=tkTkCmdsAppnamePred
syn region tkTkCmdsAppnamePred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=,@tclStuff
syn match tkTkCmdsScalingOptsGroup contained "-\a\+" contains=tkTkCmdsScalingOpts
syn keyword tkTkCmdsScalingOpts contained displayof
syn keyword tkTkCmds contained scaling inactive useinputmethods skipwhite nextgroup=tkTkCmdsScalingPred
syn region tkTkCmdsScalingPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmdsScalingOptsGroup,@tclStuff skipwhite nextgroup=tkTkCmds
syn match tkTkCmdsCaretCmdsWindowOptsGroup contained "-\a\+" contains=tkTkCmdsCaretCmdsWindowOpts
syn keyword tkTkCmdsCaretCmdsWindowOpts contained x y height
syn keyword tkTkCmdsCaretCmds contained window skipwhite nextgroup=tkTkCmdsCaretCmdsWindowPred
syn region tkTkCmdsCaretCmdsWindowPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmdsCaretCmdsWindowOptsGroup,@tclStuff skipwhite nextgroup=tkTkCmdsCaretCmds
syn keyword tkTkCmds contained caret skipwhite nextgroup=tkTkCmdsCaretPred
syn region tkTkCmdsCaretPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTkCmdsCaretCmds,@tclStuff skipwhite nextgroup=tkTkCmds

syn keyword tkKeyword contained send skipwhite nextgroup=tkSendPred
syn region tkSendPred contained excludenl keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkSendOptsGroup,@tclStuff
syn match tkSendOptsGroup contained "-\a\+" contains=tkSendOpts
syn keyword tkSendOpts contained async displayof


" -------------------------
" tk: Syntax - special case words
" -------------------------
syn keyword tkWidgetMenu              contained cascade separator command checkbutton radiobutton
syn keyword tclSecondary              contained activate addtag bbox canvasx canvasy clone coords curselection dchars delete delta deselect dtag entrycget entryconfigure find flash focus fraction get gettags icursor identify index insert invoke lower move moveto nearest panecget paneconfigure panes post postcascade proxy raise replace sash scale see set toggle type unpost validate xposition yposition
syn keyword tclSecondary              contained conf[igure] cget skipwhite nextgroup=tkWidgetPredicate
syn keyword tclSecondary              contained add skipwhite nextgroup=tkWidgetAddPredicate
syn region tkWidgetPredicate          contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetOptsGroup,@tclStuff
syn region tkWidgetAddPredicate       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetMenu,tkWidgetOptsGroup,@tclStuff

" these come from various widgets, their predicate spaces are a superset of everything required
syn keyword tclSecondary              contained scan skipwhite nextgroup=tkWidgetScanPredicate
syn region tkWidgetScanPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkBindSubstGroup,tkScanCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained select skipwhite nextgroup=tkWidgetSelectPredicate
syn region tkWidgetSelectPredicate    contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkSelectCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained scroll skipwhite nextgroup=tkWidgetScrollPredicate
syn region tkWidgetScrollPredicate    contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkScrollCmds,tkScrollbarElems,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained xview yview skipwhite nextgroup=tkWidgetViewPredicate
syn region tkWidgetViewPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkViewCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained edit skipwhite nextgroup=tkWidgetEditPredicate
syn region tkWidgetEditPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkEditCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained mark skipwhite nextgroup=tkWidgetMarkPredicate
syn region tkWidgetMarkPredicate      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkMarkCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained peer skipwhite nextgroup=tkWidgetPeerPredicate
syn region tkWidgetPeerPredicate      contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkPeerCmds,tkWidgetOptsGroup,@tclStuff
" terminated switches, needs keeepend
syn keyword tclSecondary              contained search skipwhite nextgroup=tkWidgetSearchPredicate
syn region tkWidgetSearchPredicate    contained excludenl keepend start=+.+ end=+}\|]\|;\|.$\|--+ contains=tkWidgetSearchOptsGroup,@tclStuff
syn match tkWidgetSearchOptsGroup     contained "-\a\+" contains=tkWidgetSearchOpts skipwhite nextgroup=tkWidgetSearchOptsGroup,tkWidgetOptsGroup,@tclStuff
syn keyword tkWidgetSearchOpts        contained forwards back[wards] exact regexp nolinestop nocase count all overlap elide
syn keyword tclSecondary              contained selection skipwhite nextgroup=tkWidgetSelectionPredicate
syn region tkWidgetSelectionPredicate contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkSelectionCmds,tkWidgetOptsGroup,@tclStuff
syn keyword tclSecondary              contained tag skipwhite nextgroup=tkWidgetTagPredicate
syn region tkWidgetTagPredicate       contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkTagCmds,tkTagOptsGroup,@tclStuff
syn keyword tclSecondary              contained window skipwhite nextgroup=tkWidgetWindowPredicate
syn region tkWidgetWindowPredicate    contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWindowCmds,tkWidgetOptsGroup,@tclStuff

syn keyword tclSecondary contained compare skipwhite nextgroup=tkWidgetComparePredicate
" syn region tkWidgetComparePredicate   contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tclStuff
" TODO compare predicate is:
" anything
" operator -> an expression
" anything

syn keyword tclSecondary contained count skipwhite nextgroup=tkWidgetCountPredicate
syn region tkWidgetCountPredicate   contained excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkCountOptsGroup,@tclStuff
syn match tkCountOptsGroup  contained "-\a\+" contains=tkCountOpts skipwhite nextgroup=tkCountOpts,@tclStuff
syn keyword tkCountOpts contained chars displaychars displayindicies displaylines indices lines xpixels ypixels update
hi link tkCountOpts tclOption


syn keyword tkEditCmds		   contained modified redo reset separator undo
syn keyword tkMarkCmds		   contained gravity names next previous set unset 
syn keyword tkPeerCmds		   contained create names
syn keyword tkScanCmds             contained mark dragto
syn keyword tkSelectCmds           contained adjust anchor clear element from includes item present range set to
syn keyword tkSelectionCmds        contained anchor clear includes set
syn keyword tkScrollCmds           contained units pages
syn keyword tkScrollbarElems       contained arrow1 arrow2 slider trough1 trough2
syn keyword tkTagCmds	           contained add bind cget config[ure] delete lower names nextrange prevrange raise ranges remove
syn match tkTagOptsGroup contained "-\a\+" contains=tkTagOpts
syn keyword tkTagOpts    contained background bgstipple borderwidth elide fgstipple font foreground justify lmargin1 lmargin2 offset overstrike relief spacing1 spacing2 spacing3 tabs tabstyle under[line] wrap
syn keyword tkViewCmds             contained moveto scroll
syn keyword tkWidgetOpts           contained accel[erator] activebackground activeborderwidth activeforeground anchor background bd bg bitmap borderwidth columnbreak command compound cursor disabledfore[ground] exportselection fg font foreground hidemargin highlightbackground highlightcolor highlightthick[ness] image indicatoron insertbackground insertborderwidth insertofftime insertontime insertwidth jump justify label menu offvalue onvalue ori[ent] padx pady relief repeatdelay repeatinterval selectbackground selectborderwidth selectcolor selectforeground selectimage setgrid state takefocus text textvar[iable] troughcolor underline value variable wraplength xscrollcommand yscrollcommand
syn keyword tkWidgetOpts           contained activerelief activestyle aspect background bigincrement buttonbackground buttoncursor buttondownrelief buttonuprelief class closeenough colormap command confine container default digits direction disabledback[ground] disabledfore[ground] elementborderwidth format from handlepad handlesize height increment indicatoron invalidcommand invcmd justify label labelanchor labelwidget length listvariable menu offrelief offvalue onvalue opaqueresize overrelief postcommand readonlybackground resolution sashcursor sashpad sashrelief sashwidth screen scrollregion selectcolor selectimage selectmode show showhandle showvalue sliderlength sliderrelief state tearoff tearoffcommand tickinterval title to tristateimage tristatevalue type use validate validatecommand value values variable vcmd visual width wrap xscrollincrement yscrollincrement
syn keyword tkWidgetOpts           contained autoseparators blockcursor endline inactiveselectionbackground maxundo spacing1 spacing2 spacing3 startline state tabs tabstyle undo wrap
syn keyword tkWindowCmds	   contained cget configure create names
syn match tkWidgetOptsGroup        contained "-\a\+" contains=tkWidgetOpts

" SPECIAL CASE: 
syn keyword tkKeyword      contained bind skipwhite nextgroup=tkBindPredicate
syn keyword tclSecondary   contained bind skipwhite nextgroup=tkBindPredicate
syn region tkBindPredicate contained keepend extend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkBindTag
syn region tkBindTag       contained start="." end="\s\|]" skipwhite nextgroup=tkBindSeq contains=@tclStuff
syn region tkBindSeq       contained start="." end="\s\|]" skipwhite nextgroup=tkBindScript contains=tkEvent
syn region tkBindScript    contained keepend extend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+                                     contains=@tclCommandCluster
syn region tkBindScript    contained keepend extend excludenl matchgroup=Bold start=+\s*\(\\\)\@<!{+  end=+}+ skip=+$\|\\$\|\\}+ contains=@tclCommandCluster
syn match tkBindSubstGroup contained "%%"
syn match tkBindSubstGroup contained "%#"
syn match tkBindSubstGroup contained "%\a\>" contains=tkBindSubst
syn keyword tkBindSubst    contained a b c d f h i k m o p s t w x y A B D E K N P R S T W X Y

" SPECIAL CASE: 
syn keyword tkKeyword           contained event skipwhite nextgroup=tkEventPredicate,@tclStuff
syn region tkEventPredicate     contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkEventCmds
syn region tkEventCmdsPredicate contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tkEventCluster
syn keyword tkEventCmds         contained add delete generate info skipwhite nextgroup=tkEventCmdsPredicate
syn match tkEventFieldsGroup    contained "-\a\+" contains=tkEventFields
syn keyword tkEventFields       contained above borderwidth button count data delta detail focus height keycode keysym mode override place root rootx rooty sendevent serial state subwindow time warp width when x y
syn keyword tkEventWhen         contained now tail head mark
syn cluster tkEventCluster contains=tkEventCmds,tkEventFieldsGroup,tkEventWhen,@tclStuff

" SPECIAL CASE: 
syn keyword tkWidget                    contained canvas skipwhite nextgroup=tkCanvasPredicate
syn region tkCanvasPredicate            contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tkCanvasCluster,@tclStuff
syn keyword tkCanvasTagOpts             contained above all below closest enclosed overlapping withtag
syn keyword tkCanvasPsOpts              contained colormap colormode file fontmap height pageanchor pageheight pagewidth pagex pagey rotate width x y
syn keyword tkCanvasItemOpts            contained activebackground activebitmap activedash activefill activeforeground activeimage activeoutline activeoutlinestipple activestipple activewidth anchor arrow arrowshape background bitmap capstyle dash dashoffset disabledbackground disabledbitmap disableddash disabledfill disabledforeground disabledimage disabledoutline disabledoutlinestipple disabledstipple disabledwidth extent fill font foreground height image joinstyle justify offset outline outlinestipple smooth splinesteps start state stipple style tag[s] text width window
syn cluster tkCanvasCluster		contains=tkCanvasItemOpts,tkCanvasTagOpts,tkWidgetOptsGroup
" the create command
syn keyword tkWidgetCreate              contained create skipwhite nextgroup=tkWidgetCreatePredicate
syn region tkWidgetCreatePredicate      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateCmds,@tclStuff
syn match tkWidgetCreateCommonOptsGroup contained "-\a\+" contains=tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateCommonOpts    contained activedash activefill activeoutline activeoutlinestipple activestipple activewidth dash dashoffset disableddash disabledfill disabledoutline disabledoutlinestipple disabledstipple disabledwidth fill offset outline outlinestipple state stipple tag[s] width
syn keyword tkWidgetCreateCmds          contained arc skipwhite nextgroup=tkWidgetCreateArcPred
syn region tkWidgetCreateArcPred        contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateArcOptsGroup,@tclStuff
syn match tkWidgetCreateArcOptsGroup    contained "-\a\+" contains=tkWidgetCreateArcOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateArcOpts       contained extent start style
syn keyword tkWidgetCreateCmds          contained bitmap skipwhite nextgroup=tkWidgetCreateBitmapPred
syn region tkWidgetCreateBitmapPred     contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateBitmapOptsGroup,@tclStuff
syn match tkWidgetCreateBitmapOptsGroup contained "-\a\+" contains=tkWidgetCreateBitmapOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateBitmapOpts    contained activebackground activebitmap activeforeground anchor background bitmap disabledbackground disabledbitmap disabledforeground foreground
syn keyword tkWidgetCreateCmds          contained image skipwhite nextgroup=tkWidgetCreateImagePred
syn region tkWidgetCreateImagePred      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateImageOptsGroup,@tclStuff
syn match tkWidgetCreateImageOptsGroup  contained "-\a\+" contains=tkWidgetCreateImageOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateImageOpts     contained anchor image activeimage disabledimage
syn keyword tkWidgetCreateCmds          contained line skipwhite nextgroup=tkWidgetCreateLinePred
syn region tkWidgetCreateLinePred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateLineOptsGroup,@tclStuff
syn match tkWidgetCreateLineOptsGroup   contained "-\a\+" contains=tkWidgetCreateLineOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateLineOpts      contained arrow arrowshape capstyle joinstyle smooth splinesteps
syn keyword tkWidgetCreateCmds          contained oval skipwhite nextgroup=tkWidgetCreateOvalPred
syn region tkWidgetCreateOvalPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateCommonOptsGroup,@tclStuff
syn keyword tkWidgetCreateCmds          contained poly[gon] skipwhite nextgroup=tkWidgetCreatePolyPred
syn region tkWidgetCreatePolyPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreatePolyOptsGroup,@tclStuff
syn match tkWidgetCreatePolyOptsGroup   contained "-\a\+" contains=tkWidgetCreatePolyOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreatePolyOpts      contained joinstyle smooth splinesteps
syn keyword tkWidgetCreateCmds          contained rect[angle] skipwhite nextgroup=tkWidgetCreateRectPred
syn region tkWidgetCreateRectPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateCommonOptsGroup,@tclStuff
syn keyword tkWidgetCreateCmds          contained text skipwhite nextgroup=tkWidgetCreateTextPred
syn region tkWidgetCreateTextPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateTextOptsGroup,@tclStuff
syn match tkWidgetCreateTextOptsGroup   contained "-\a\+" contains=tkWidgetCreateTextOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateTextOpts      contained anchor font justify text width
syn keyword tkWidgetCreateCmds          contained window skipwhite nextgroup=tkWidgetCreateWinPred
syn region tkWidgetCreateWinPred        contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateWinOptsGroup,@tclStuff
syn match tkWidgetCreateWinOptsGroup    contained "-\a\+" contains=tkWidgetCreateWinOpts,tkWidgetCreateCommonOpts
syn keyword tkWidgetCreateWinOpts       contained anchor height width window
syn keyword tclSecondary                contained itemconfig[ure] itemcget skipwhite nextgroup=tkCanvasItemConfigurePred
syn region tkCanvasItemConfigurePred    contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreateArcOpts,tkWidgetCreateBitmapOpts,tkWidgetCreateCommonOpts,tkWidgetCreateImageOpts,tkWidgetCreateLineOpts,tkWidgetCreateOvalOpts,tkWidgetCreatePolyOpts,tkWidgetCreateRectOpts,tkWidgetCreateTextOpts,tkWidgetCreateWinOpts,@tclStuff

" postscript
syn keyword tclSecondary contained postscript skipwhite nextgroup=tkCanvasPsPred
syn region tkCanvasPsPred contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkCanvasPsOptsGroup,@tclStuff
syn match tkCanvasPsOptsGroup contained "-\a\+" contains=tkCanvasPsOpts

" SPECIAL CASE: 
" , includes -  bitmap photo
syn keyword tkWidget                   contained image skipwhite nextgroup=tkWidgetImagePred
syn region tkWidgetImagePred           contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkImageCmds,tkWidgetCreate,@tclStuff
syn keyword tkImageCmds                contained delete inuse names type types 
syn keyword tkImageCmds                contained anchor height width window

" create bitmap starts in canvas, this appends
syn keyword tkWidgetCreateBitmapOpts   contained background data file foreground maskdata maskfile
syn keyword tkWidgetCreateCmds         contained photo skipwhite nextgroup=tkWidgetCreatePhotoPred
syn region tkWidgetCreatePhotoPred     contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetCreatePhotoOptsGroup,@tclStuff
syn match tkWidgetCreatePhotoOptsGroup contained "-\a\+" contains=tkWidgetCreatePhotoOpts
syn keyword tkWidgetCreatePhotoOpts    contained data format file gamma height palette width

" Syntax: from photo
syn keyword tclSecondary               contained blank
syn keyword tclSecondary               contained copy skipwhite nextgroup=tkWidgetImageCopyPred
syn region tkWidgetImageCopyPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageCopyOptsGroup,@tclStuff
syn match tkWidgetImageCopyOptsGroup   contained "-\a\+" contains=tkWidgetImageCopyOpts
syn keyword tkWidgetImageCopyOpts      contained from to shrink zoom subsample compositingrule
syn keyword tclSecondary               contained data skipwhite nextgroup=tkWidgetImageDataPred
syn region tkWidgetImageDataPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageDataOptsGroup,@tclStuff
syn match tkWidgetImageDataOptsGroup   contained "-\a\+" contains=tkWidgetImageDataOpts
syn keyword tkWidgetImageDataOpts      contained background format from grayscale
syn keyword tclSecondary               contained put skipwhite nextgroup=tkWidgetImagePutPred
syn region tkWidgetImagePutPred        contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImagePutOptsGroup,@tclStuff
syn match tkWidgetImagePutOptsGroup    contained "-\a\+" contains=tkWidgetImagePutOpts
syn keyword tkWidgetImagePutOpts       contained format to
syn keyword tclSecondary               contained read skipwhite nextgroup=tkWidgetImageReadPred
syn region tkWidgetImageReadPred       contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageReadOptsGroup,@tclStuff
syn match tkWidgetImageReadOptsGroup   contained "-\a\+" contains=tkWidgetImageReadOpts
syn keyword tkWidgetImageReadOpts      contained format from shrink to
syn keyword tclSecondary               contained redither
syn keyword tclSecondary               contained transparency skipwhite nextgroup=tkWidgetImageTransPred
syn region tkWidgetImageTransPred      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageTransOptsGroup,@tclStuff
syn match tkWidgetImageTransOptsGroup  contained "-\a\+" contains=tkWidgetImageTransOpts
syn keyword tkWidgetImageTransOpts     contained get set
syn keyword tclSecondary               contained write skipwhite nextgroup=tkWidgetImageWritePred
syn region tkWidgetImageWritePred      contained keepend start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=tkWidgetImageWriteOptsGroup,@tclStuff
syn match tkWidgetImageWriteOptsGroup  contained "-\a\+" contains=tkWidgetImageWriteOpts
syn keyword tkWidgetImageWriteOpts     contained background format from grayscale

" SPECIAL CASE: 
syn keyword tkWidget		contained text skipwhite nextgroup=tkTextPredicate
syn keyword tkKeyword		contained tk_textCopy tk_textCut tk_textPaste
syn region tkTextPredicate	contained keepend excludenl start=+.+ skip=+\\$+ end=+}\|]\|;\|$+ contains=@tkTextCluster,@tclStuff
" this is how you 'subclass' an OptsGroup
syn match tkTextWidgetOptsGroup contained "-\a\+" contains=tkTextWidgetOpts,tkWidgetOpts
syn keyword tkTextWidgetOpts    contained autoseparators blockcursor endline inactiveselectionbackground maxundo spacing1 spacing2 spacing3 startline state tabs tabstyle undo wrap
syn cluster tkTextCluster	contains=tkTextWidgetOptsGroup


" SPECIAL CASE: 
syn keyword tkWidget           contained listbox skipwhite nextgroup=tkWidgetPredicate


" HyperMesh Commands

syn keyword hmCommand		hm_arcball hm_blockerrormessages hm_blockmessages hm_blockredraw hm_callcollectorpanel
syn keyword hmCommand		hm_callhelp hm_callincludepanel hm_callspecialpanel hm_callviewpanel hm_callvispanel
syn keyword hmCommand		hm_centerview hm_circlezoom hm_collectordisplayed hm_completemenuoperation hm_disablepopup
syn keyword hmCommand		hm_editcard hm_edittextcard hm_enableitem hm_enablepopup hm_errormessage
syn keyword hmCommand		hm_exit hm_exitpanel hm_framework hm_getcommandposition hm_getcurrentmenu
syn keyword hmCommand		hm_getcurrentview hm_getfilename hm_getfloat hm_getgraphicsarea hm_getint
syn keyword hmCommand		hm_getitemnumber panelname itemnum occur; hm_getitemnumberbytag
syn keyword hmCommand		hm_getmodelcheckenttype hm_getmodelcheckresultentids hm_getpanelarea hm_getpanelitems hm_getpanelposition
syn keyword hmCommand		hm_getstring hm_getwindowarea hm_highlightentity hm_highlightlist hm_highlightmark
syn keyword hmCommand		hm_istextcard hm_listpanels hm_orientseatbelt hm_panelnamevalid hm_panview
syn keyword hmCommand		hm_redraw hm_renameitem hm_rotateview hm_scaleview hm_setcommandposition
syn keyword hmCommand		hm_setentitysubtype hm_setlinemeshpanelproc hm_setmodelcheckresultentids hm_setmodelcheckcheckstatus hm_setmodelcheckcorrectionstatus
syn keyword hmCommand		hm_setmouse hm_setpanelheight hm_setpanelposition hm_setpanelproc hm_setsystempanelproc
syn keyword hmCommand		hm_setuserprofileoption hm_togglevirtualcollector hm_usermessage hm_viewbottomside hm_viewccw
syn keyword hmCommand		hm_viewclear hm_viewcw hm_viewdown hm_viewfit hm_viewfrontside
syn keyword hmCommand		hm_viewisometric hm_viewleft hm_viewleftside hm_viewlist hm_viewprevious
syn keyword hmCommand		hm_viewrearside hm_viewreverse hm_viewright hm_viewrightside hm_viewshaded
syn keyword hmCommand		hm_viewshadedfeatures hm_viewshadedmesh hm_viewtopside hm_viewup hm_viewwireframe
syn keyword hmCommand		hm_windowtoclipboard hm_windowtofile hm_winfo hm_wm hm_zoomin
syn keyword hmCommand		hm_zoomout absoluterotatedummyjoint accepteditedsurface accepteditedsurface_with_user_tolerance acousticmeshcreate
syn keyword hmCommand		acousticmeshend acousticmeshinit acousticmeshinterface addfacestocontactsurf addfacestocontactsurfusingfacenumber
syn keyword hmCommand		add_remove_distance_manipulator add_washer_elements addincludetodisplay addshellstocontactsurf adjustnodes
syn keyword hmCommand		admasconnectivityupdatemultentselectwithvisnod admascreatemultentselectwithsets alignnode allsuppressactive allsuppressoutput
syn keyword hmCommand		alternatejointcreate alternatejointupdate altgapelement altgapelementupdate ameshclearsurface
syn keyword hmCommand		analysiscurvecreate analysiscurvecreatecomplex analysisfileset analysisfilesetwithsolverids animatecycles
syn keyword hmCommand		animatelegendsetrange animatelinear animatemodal animatetransient answer
syn keyword hmCommand		appendmark appendmarksolverdata applydisplayattributes applyresults applyresultsasloads
syn keyword hmCommand		assemblyaddmark assemblymodify assemblymodifyhierarchy assemblyremovemark assignedplot
syn keyword hmCommand		assignsystem assignsystem_option attributeupdate_entityidarray2d attributeupdate_entityidarray2d_mark attributeupdatedouble
syn keyword hmCommand		attributeupdatedoublearray attributeupdatedoublearray2d attributeupdatedoublearray2delementmark attributeupdatedoublearray2dmark attributeupdatedoublearrayelementmark
syn keyword hmCommand		attributeupdatedoublearraymark attributeupdatedoublemark attributeupdateentity attributeupdateentityidarray attributeupdateentityidarray2delementmark
syn keyword hmCommand		attributeupdateentityidarrayelementmark attributeupdateentityidarraymark attributeupdateentitymark attributeupdateint attributeupdateintarray
syn keyword hmCommand		attributeupdateintarray2d attributeupdateintarray2delementmark attributeupdateintarray2dmark attributeupdateintarrayelementmark attributeupdateintarraymark
syn keyword hmCommand		attributeupdateintmark attributeupdatesolverid attributeupdatestring attributeupdatestringarray attributeupdatestringarrayelementmark
syn keyword hmCommand		attributeupdatestringarraymark attributeupdatestringmark autocolor automesh autotopocleanup
syn keyword hmCommand		bagcreate bagdeleteall bagentityupdate bar3element bar3elementcreatewithoffsets
syn keyword hmCommand		bardirectionupdate barelement barelementcreatewithoffsets barelementupdate barelementupdatewithoffsets
syn keyword hmCommand		barelementupdatelocal baroffset baroffsetupdate baroffsetupdatelocal BCM
syn keyword hmCommand		beadboundsupdate beadparamsupdate beamsectionautoconnectshell beamsectioncreateshell beamsectioncreateshelldirect
syn keyword hmCommand		beamsectioncreatesolid beamsectioncreatesoliddirect beamsectioncreatesolidfrompoints beamsectioncreatestandardsolver beamsectionsetdatageneric
syn keyword hmCommand		beamsectionsetdataroot beamsectionsetdatashell beamsectionsetdatasolid beamsectionsetdatastandard beamsectiontranslate
syn keyword hmCommand		beamsectionupdateshellpartname bitmapanimationmode blmesh_2d blockcontrollines blockcontrolplanes
syn keyword hmCommand		blockcreate blocknodeupdate blocksetcurrent blockupdate blockvisualize
syn keyword hmCommand		blockwalladdcell blockwallcreate blockwalldelete blockwalleditrange blockwallfill
syn keyword hmCommand		blockwallfindintersect blockwallremove blockwallremovecell blockwallreset blockwallupdate
syn keyword hmCommand		bm_markpreservedcompsboundary body_split_with_morphed_lines body_split_with_points body_trim_with_templine boolean_merge_solids
syn keyword hmCommand		calculateproximityelements cardcreate carddelete carddisable carddisablebyid
syn keyword hmCommand		cardenable cardenablebyid CE_AddLinkEntities CE_AddLinkEntitiesWithRules CE_AddLinkEntitiesWithXYZs
syn keyword hmCommand		CE_ConnectorAreaCreate CE_ConnectorAreaCreateFromList CE_ConnectorAreaMapMesh CE_ConnectorAreaMesh CE_ConnectorCombine
syn keyword hmCommand		CE_ConnectorCreate CE_ConnectorCreateAndFERealizeForTrimMass CE_ConnectorCreateByList CE_ConnectorCreateByListAndRealizeWithDetails CE_ConnectorCreateByMark
syn keyword hmCommand		CE_ConnectorCreateByMarkAndRealizeWithDetails CE_ConnectorCreateWithRules CE_ConnectorGroup CE_ConnectorLineCreate CE_ConnectorLineCreateWithRules
syn keyword hmCommand		CE_ConnectorPartition CE_ConnectorRemoveDuplicates CE_ConnectorSeamCreateUsingLinelist CE_ConnectorSeamCreateUsingLines CE_ConnectorSetVectorById
syn keyword hmCommand		CE_ConnectorSetVectorByMark CE_DetailDelete CE_DetailDeleteByMark CE_DetailSetDouble CE_DetailSetDoubleByMark
syn keyword hmCommand		CE_DetailSetInt CE_DetailSetIntByMark CE_DetailSetString CE_DetailSetStringByMark CE_DetailSetTriple
syn keyword hmCommand		CE_DetailSetTripleByMark CE_DetailSetUint CE_DetailSetUintByMark CE_EditSeamAndLineDetail CE_ExportFile
syn keyword hmCommand		CE_ExportMasterConnectorsFile CE_FE_1DQuality CE_FE_3DQuality CE_FE_GlobalFlags CE_FE_RealizeWithDetails
syn keyword hmCommand		CE_FE_Register CE_FE_RegisterAdvanced CE_FE_SetCommonDetails CE_FE_SetDetails CE_FE_SetDetailsAndRealize
syn keyword hmCommand		CE_FE_SetSpecificDetail CE_FE_SetSpecificDetailById CE_GlobalSetDouble CE_GlobalSetInt CE_MarkRemoveLink
syn keyword hmCommand		CE_MarkUpdateLink CE_PreviewCombine CE_PreviewDuplicates CE_ProjectionCheck CE_ReadXmlString
syn keyword hmCommand		CE_Realize CE_RemoveLink CE_SetSpecificDetail CE_SetSpecificDetailById CE_Unrealize
syn keyword hmCommand		CE_UpdateCustomMessage CE_UpdateLink centroid1dmode cfdoutput change_distance_between_faces
syn keyword hmCommand		change_edgedensities check_symmetric_mesh check_symmetric_surfaces checkpenetration cleanuptoleranceset
syn keyword hmCommand		clearallunresolvedids clearlist clearmark clearmarkall clearunresolvedid
syn keyword hmCommand		clipboundaryelements coarsen_and_decimate_mesh2 coarsen_mesh coincidentnodepickmode coincidentpickmode
syn keyword hmCommand		collectorcreate collectorcreateonly collectorcreatesameas collectormarkmove colormapedit
syn keyword hmCommand		colormark combineelements combineplotels complexanimatemodal compositeshuffledesvarcreate
syn keyword hmCommand		compositeshuffledesvarcreatewithlaminateoption compositeshuffledesvarupdate compositeshuffledesvarupdatewithlaminateoption compositeshufflepairingconstraintupdate compositesizedesvarcreate
syn keyword hmCommand		compositesizedesvarcreatewithlaminateoption compositesizedesvarupdate compositesizedesvarupdatewithlaminateoption compositesizelaminatethicknessupdate compute_midmesh_thickness
syn keyword hmCommand		computeboundarylayerthickness configedit connect_surfaces_11 contactsurfcreatewithfaces contactsurfcreatewithfacesusingfacenumber
syn keyword hmCommand		contactsurfcreatewithshells contourplot control_sum_2 convertbeamsection convertthickness
syn keyword hmCommand		copymark copymarkgroup create_batch_file create_bead_elements create_sbelt2D
syn keyword hmCommand		create2dseatbelt createairbag createarray createbestcirclecenternode createblockwithsystem
syn keyword hmCommand		createcardmark createcenternode createcirclecenterpoint createcirclefromcenterradius createcirclefrompointplane
syn keyword hmCommand		createcirclefrompoints createcollectorforpartiallycontained createcontrolvol createdoublearray createdoublearray2d
syn keyword hmCommand		createelement createelementsbetweennodes createelementsbetweenpoints createellipsoids createellipsoidsbypoints
syn keyword hmCommand		createentityarray2d createentitypanel createfillet createfilletmidlines createinclude
syn keyword hmCommand		createintarray2d createjointelement_twonoded createlist createlistpanel createmark
syn keyword hmCommand		createmarklast createmarkpanel createmultiplespotwelds createnode createnodesandspotweldelems
syn keyword hmCommand		createnodesbetweennodelist createnodesbetweennodes createplane createpoint createpointsbetweenpoints
syn keyword hmCommand		createreferencegeometry createseatbeltlinewithmesh createsensor create_shell_mesh_features createsimpleblock
syn keyword hmCommand		createspotweld createstringarray createvector createweldelemsfromalinelist createweldsbetweencompsusingpoints
syn keyword hmCommand		createweldsbetweenelemsusingnodes createweldsbetweenelemsusingpoints currentcollector curveaddpoint curvedeletepoint
syn keyword hmCommand		curvemathexternalfilter curvemodifypointcords cuttingplanereverse decimate_mesh defaultmeshelems
syn keyword hmCommand		defaultmeshsurf defaultmeshsurf_growth defaultremeshelems defaultremeshsurf deformedshape
syn keyword hmCommand		deleteedges deletefeatures deletefile deletefillet deletemark
syn keyword hmCommand		deletemodel deletesolidswithelems dependencycheck dequationcreate dequationupdate
syn keyword hmCommand		descriptormove descriptorsetcolor descriptorsetfont descriptorsettext desvarlinkcreate
syn keyword hmCommand		desvarlinkcreatewithfunction desvarlinkupdate desvarlinkupdatewithfunction detach_fromelements detachelements
syn keyword hmCommand		detailedelements dictionaryload dictionaryreset dictionaryresetsolver dictionaryupdatebymark
syn keyword hmCommand		dictionaryupdateentry display_thickness displayall displaycollector displaycollectorsall
syn keyword hmCommand		displaycollectorsallbymark displaycollectorsbymark displaycollectorwithfilter displayelementsbyproperty displayelementsbypropertybymark
syn keyword hmCommand		displayimporterrors displayincludeonly displaynone draglinetoformsurface dragnodestoformsurface
syn keyword hmCommand		drawlistresetstyle duplicatemark dvprelcreate dvprelupdate dynamicrotatemode
syn keyword hmCommand		dynamicviewbegin dynamicviewend edgerelease edgerestore edgesmarkaddmidpoint
syn keyword hmCommand		edgesmarkrelease edgesmarkrestore edgesmarksuppress edgesmarkuntrim edgesmerge
syn keyword hmCommand		edgesuppress editmarkpanel element1dswitch element2Dalign element2Dshiftnodes
syn keyword hmCommand		element3Dalign element3Dshiftnodes elementchecksettings elementhandle elementmarksplit
syn keyword hmCommand		elementorder elementqualityoptimizeelement elementqualityoptimizenode elementqualityplacenode elementqualityredoaction
syn keyword hmCommand		elementqualitysetup elementqualityshutdown elementqualitysmoothnodes elementqualityswapedge elementqualityundoaction
syn keyword hmCommand		elementsaddelemsfixed elementsaddnodesfixed elementsettypes elementsizeset elementtestaltitudeaspect
syn keyword hmCommand		elementtestaspect elementtestcellsquish elementtestchordaldeviation elementtestconnectivity elementtestdependancy
syn keyword hmCommand		elementtestduplicates elementtestequiaskew elementtestfree1d elementtestinterangle elementtestjacobian
syn keyword hmCommand		elementtestlength elementtestrigidloops elementtestskew elementtesttetracollapse elementtestvolumeareaskew
syn keyword hmCommand		elementtestvolumetricskew elementtestwarpage elementtype elemoffset elemswarpagefix
syn keyword hmCommand		ellipsoidupdate EntityDeleteEmpty EntityDeleteUnused entityhighlighting EntityMoveUsingArray
syn keyword hmCommand		EntityPreviewEmpty EntityPreviewUnused entitysetcreate entitysetcreatelist entitysetupdate
syn keyword hmCommand		entitysetupdatelist entitysuppressactive entitysuppressoutput equationcreate equationcreatebylist
syn keyword hmCommand		equationhandle equationupdate equationupdateallconstant equationupdatealldofswts equivalence
syn keyword hmCommand		equivalence2 evaltclscript evaltclstring exponentialdisplay exportshapes
syn keyword hmCommand		exportuserdefinedshapes facedeleteduplicates facepreviewduplicates facesdelete facesmarktosurface
syn keyword hmCommand		fatiguewrite featureangleset features features_add features_move_all_opened
syn keyword hmCommand		features_remove_selected feinputinteractive feinputoffsetid feinputomitincludefiles feinputpreserveincludefiles
syn keyword hmCommand		feinputwithdata2 feoutput_select feoutputtimeinfo feoutputwithdata feoutputmergeincludefiles
syn keyword hmCommand		fetosurfs filewritecomponentgeometry fill_circular_holes fillet_surface_edges fillplot
syn keyword hmCommand		find_holes_in_3d_body findandremovethreads findattachedelementfaces findbetween findedges
syn keyword hmCommand		findfaces findflangesend findflangesinit findflangesproximityshell findflangestoposhell
syn keyword hmCommand		findholesend findholesinit findholesshell findholessolid findloops
syn keyword hmCommand		findmark findnodesbetweencomponents fix_surfaces_orientation fixedpointhandle flanges_detect
syn keyword hmCommand		freeshapedesvarcreatewithsetoption freeshapedesvarupdatewithsetoption freeshapedrawextrusionpdate freeshapegridconstraintsupdatewithsetoption freeshapeparametersupdatewithlimits
syn keyword hmCommand		freeshapeparametersupdatewithsmoothing freeshapeparametersupdatewithtransition freeshapepatternupdate freeshapesideconstraintsbarrierupdatebyblocks freeshapesidecontraintsbarrierupdatemanual
syn keyword hmCommand		freesimulation freesizedesvarcreatewithlaminateoption freesizedesvarcreatewithstackoption freesizedesvarupdatewithlaminateoption freesizedesvarupdatewithstackoption
syn keyword hmCommand		freesizelaminatethicknessupdate freesizeparametersupdatewithfatigue gapelement gapelementupdate gaugedesvarcreate
syn keyword hmCommand		gaugedesvarcreategeneralized gaugedesvarupdate geometrytoleranceset geommatchtopology geomoutputdata
syn keyword hmCommand		geomstitching geomvectorcreate geomvectorupdate GetLatitudeLineHandles getnodesinsidedomaintomark
syn keyword hmCommand		getqualitysummary getunmeshedsurfstomark graphic_label graphicfont graphicsfileblankbackground
syn keyword hmCommand		graphicsfilecolor graphicsimplificationmode graphuserwindow_byXYZandR graphuserwindow_to_XYZ groupchangetype
syn keyword hmCommand		groupcreatesameas groupdeleteunused grouppreviewunused hf_Addendum_PrepareLatitudeLine hf_Addendum_UpdateSlide
syn keyword hmCommand		hf_AddSectionHandle hf_CheckDieModuleElementsRES hf_ClearFromWorkingSection hf_ClearLLHandles hf_Create_DieCadSys
syn keyword hmCommand		hf_CreateAutomaticTL hf_CreateBinderSectionAndHandles hf_CreatePol hf_DeleteSectionHandle hf_DiePartPositioning
syn keyword hmCommand		hf_EditPol hf_FeatureFromSurfaces hf_FillDoubleAttachedPart hf_LevelElementsOnOff hf_RejectDragDeleteHandle
syn keyword hmCommand		hf_ResetDFRibs hf_RotateBinderSurf hf_ScaleBinderSurf hf_setdieline hf_setdiestampingdirection
syn keyword hmCommand		hf_setdiesymmetry hf_setformingdirection hf_setpartcomponent hf_setpartflangecomponent hf_setTLPOL
syn keyword hmCommand		hf_SlideHandleptrOnSectionPlane hf_TranslateBinderSurf hf_trim hf_trim_multi hf_TrimBinderOrAddendumWithAddDbeadDbar
syn keyword hmCommand		hf_TrimElementsOnOff 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 hiddenlinemethod hm_autocleanup hm_auto_elem_cleanup
syn keyword hmCommand		hm_failed_elements_cleanup hm_meshutils_cutelements_2points hm_meshutils_cutelements_8points hm_meshutils_cutelements_predefined hm_meshutils_cutjoints
syn keyword hmCommand		hmmeshdrag hmmeshlinedrag hmmeshskin hmmeshspin hmmeshspline
syn keyword hmCommand		hmmeshsurfacecone hmmeshsurfaceplane hmmeshsurfacesphere hmmeshsurfacetorus hmshrinkwrap
syn keyword hmCommand		iges_write_units include includesuppressactive includesuppressoutput inputsimulation
syn keyword hmCommand		interactivemeshelems interactivemeshsurf interactiveremeshelems interactiveremeshsurf interfaceadd
syn keyword hmCommand		interfaceaddsolidface interfaceall interfacebox interfacecomponent interfacecontactsurf
syn keyword hmCommand		interfacecreate interfacedefinition interfacesets intersectmark jointelement_fournoded
syn keyword hmCommand		jointelement_sixnoded jointelement_twonoded jointelement_update jpegfile jpegfilenamed
syn keyword hmCommand		laminatecreate laminateupdate lastsimulation legendcoloredit legendcolorsmooth
syn keyword hmCommand		legendlocate legendmove legendon legendsavecolors legendsetbordercolor
syn keyword hmCommand		legendsetcolor legendsetcolors legendsetfont legendsetlocate lightswitch
syn keyword hmCommand		linear1delements linearmesh linearsolids linearsolidsbynodelist linearsurfacebetweenlines
syn keyword hmCommand		linearsurfacebetweennodes linearsurfacebetweennodesandline linecombine linecombinemark linecreateatplanesintersection
syn keyword hmCommand		linecreateatsurfparams linecreateconic linecreatedragnodealongvector linecreatefromnodes linecreatefromnodesandprojecttobinder
syn keyword hmCommand		linecreatefromnodesonsurface linecreatenormal2d linecreatenormalfromgeom linecreatenormaltogeom linecreatenurbs
syn keyword hmCommand		linecreateoffsetalongcurvature linecreatespline linecreatestraight linedragelements linedraglinetoformsurface
syn keyword hmCommand		linedragnodestoformsurface lineextenddistance lineextendtoline lineextendtonode lineextendtopoint
syn keyword hmCommand		lineextendtosurf linefromsurfedgecomp linehandle linelistbypath linemarkbypath
syn keyword hmCommand		linemesh_preparedata linemesh_preparenodeslist linemesh_savedata linemesh_savedata_bar linemesh_saveparameters
syn keyword hmCommand		lineplot linereverse lines_approximate linescombine linescreatemidline
syn keyword hmCommand		linesplitatjoint linesplitatline linesplitatplane linesplitatpoint linestoelementsaddelemsfixed
syn keyword hmCommand		linessmoothtoangle linessmoothtotol loadcreate loadcreateonentity loadcreateonentity_curve
syn keyword hmCommand		loadcreateonentitywithvars loadcreatewithsystem loadcreatewithsystemonentity loadcreatewithsystemonentitywithvars loadhandle
syn keyword hmCommand		loadlabel loadsettypes loadsize loadstepscreate loadstepscreatesameas
syn keyword hmCommand		loadstepsupdate loadstepsupdateattributesfromidlist loadsupdate loadsupdatecurve loadtype
syn keyword hmCommand		map_symmetric_mesh maploadtomesh mark_preserved_edges markcombineelements markdifference
syn keyword hmCommand		markercreate markersupdate markintersection markintersectplane markmovetoinclude
syn keyword hmCommand		marknodenudge marknotintersection markprojectnormallytoline markprojectnormallytosurface markprojecttoline
syn keyword hmCommand		markprojecttosurface marksmoothelements marksmoothsolids marksuppressactive marksuppressoutput
syn keyword hmCommand		marktousermark maskall maskentitiesincollector maskentitymark masknotshown
syn keyword hmCommand		maskreverse maskreverseall masselement masselementupdate masselementwithvar
syn keyword hmCommand		materialupdate mbjointcreate mbjointupdate mbplanecreate mbplanecreatewithcoords
syn keyword hmCommand		menufilterdisable menufilterenable menufilterset menufont mergefile
syn keyword hmCommand		meshdragelements meshline_create_from_plot_elements meshline_create_from_points meshline_delete meshline_display_scaffold
syn keyword hmCommand		meshline_end meshline_initialize meshline_mark_entity_inside_class meshline_mask_class_element meshline_reject
syn keyword hmCommand		meshline_set_approximate_tol_factor meshline_update_surface meshmode meshspinelements meshtopologyadjust
syn keyword hmCommand		messagefilefilter messagefileset metadatamarkdate metadatamarkdouble metadatamarkdoublearray
syn keyword hmCommand		metadatamarkentityidtype metadatamarkentityidtypearray metadatamarkint metadatamarkintarray metadatamarkremove
syn keyword hmCommand		metadatamarkstring metadatamarkstringarray midsurface_accept_edge_target midsurface_accept_edge_target_by_number midsurface_accept_point_target
syn keyword hmCommand		midsurface_combine_all_targets midsurface_edit_base_surfaces midsurface_extract_10 midsurface_offset_by_targets_11 midsurface_remove_edge_target
syn keyword hmCommand		midsurface_remove_edge_target_by_number midsurface_remove_edit_bodies midsurface_remove_new_target midsurface_remove_target midsurface_show_for_edit
syn keyword hmCommand		midsurfaceextract minmaxtitlemove minmaxtitlesetcolor minmaxtitlesetfont mixedpropertywarning
syn keyword hmCommand		mode ModifySectionHandle morphalteranglevec morphalterdistancevec morphaltercurvectr
syn keyword hmCommand		morphapplyfesolver morphapplylargedomains morphbeziershape morphbiasstyle morphbiasupdate
syn keyword hmCommand		morphbiasupdatemulti morphbiasupdateretroactive morphcombineedges morphcombinemorphvolumes morphconnstodoms
syn keyword hmCommand		morphconstraintapply morphconstraintcreateangle morphconstraintcreatearcrad morphconstraintcreateavm morphconstraintcreateedge
syn keyword hmCommand		morphconstraintcreateelems morphconstraintcreateeq morphconstraintcreatefc morphconstraintcreatelength morphconstraintcreateline
syn keyword hmCommand		morphconstraintcreateplane morphconstraintcreatesmooth morphconstraintcreatesurf morphconstraintcreatevec morphconstraintsetcolor
syn keyword hmCommand		morphconstraintupdateangle morphconstraintupdatearcrad morphconstraintupdateavm morphconstraintupdateedge morphconstraintupdateelems
syn keyword hmCommand		morphconstraintupdateeq morphconstraintupdatefc morphconstraintupdatelength morphconstraintupdateline morphconstraintupdateplane
syn keyword hmCommand		morphconstraintupdatesmooth morphconstraintupdatesurf morphconstraintupdatevec morphconvertmv morphcreatedomaindc
syn keyword hmCommand		morphcreatedomainedge morphcreatedomainglobalnodes morphcreatemodelshape morphcreatetempline morphdeleteall
syn keyword hmCommand		morphdeletehandlesanddomains morphdeletemvedgenodes morphdisplayconstraints morphdisplayconstraintvector morphdisplaydependencies
syn keyword hmCommand		morphdisplaysymmetries morphdoshape morphentitydelete morphfitfaces morphhandlecreatenodes
syn keyword hmCommand		morphhandlecreatenodesnodom morphhandlecreatexyz morphhandlepertnormal morphhandlepertxyz morphhandleprojectentity
syn keyword hmCommand		morphhandleprojectline morphhandleprojectplane morphhandlerotate morphhandlescalexyz morphhandleupdatemulti
syn keyword hmCommand		morphhandleupdatesingle morphhypermorph morphhypermorphnormal morphhypermorphvector morphhyperpreview
syn keyword hmCommand		morphhyperpreviewbezier morphinterpolatesurf morphkringmanual morphlistupdate morphloaddata
syn keyword hmCommand		morphloadmvols morphloadshape morphmanageedgemark morphmanagefacemark morphmanualapply
syn keyword hmCommand		morphmanualinit morphmanualrestore morphmapdifference morphmapdifferencesurf morphmapedgestoequation
syn keyword hmCommand		morphmapedgestoline morphmapedgestonodes morphmapedgestoplane morphmaplinestolines morphmapedgestosurface
syn keyword hmCommand		morphmapedgestotatic morphmapnormaloffset morphmaprecalc morphmapsections morphmaptoequationvec
syn keyword hmCommand		morphmaptolinenodes morphmaptolinevec morphmaptonodesnodes morphmaptonodesvec morphmaptoplanevec
syn keyword hmCommand		morphmaptosurfacevec morphmaptotacitvec morphmaptshp morphmaptshpedge morphnodesequa
syn keyword hmCommand		morphnodesline morphnodesmesh morphnodesnodes morphnodesnormal morphnodesplane
syn keyword hmCommand		morphnodesrotate morphnodesshape morphnodessurf morphnodestranslate morphnodesvector
syn keyword hmCommand		morphorganizedomain morphorganizedomainsplit morphpartition morphpositionshapemark morphrecalcmvhandles
syn keyword hmCommand		morphreflectshapemark morphremeshedges morphremoveconstraint morphrenamehandle morphreparam
syn keyword hmCommand		morphrotatetrue morphsavedata morphsavemvols morphsaveshape morphsculptmesh2
syn keyword hmCommand		morphsculptmeshfea morphsetactive morphshapeapply morphshapeapplynodes morphshapecreatecolor
syn keyword hmCommand		morphshapecreatecolorsystem morphshapecreatelist morphshapecreateorthogonal morphshapecreateorthogonalbound morphshapelinkedapply
syn keyword hmCommand		morphshapelinkedpush morphshapeupdatecolor morphshrinkmvols morphsmooth morphsplitmorphvolumes
syn keyword hmCommand		morphstoredomains morphstoremorphvolumes morphsubdivide morphsurfaces morphsymmetrycreateaxis
syn keyword hmCommand		morphsymmetryrefresh morphsymmetryupdateaxis morphsymmetryupdatebyd morphtranslateshapemark morphupdatedatabase
syn keyword hmCommand		morphupdatedisplay morphupdatedomainmethod morphupdatedomains morphupdateenbymvol morphupdateendcondition
syn keyword hmCommand		morphupdatemodelcheck morphupdatemvedgenodes morphupdatemvnodes morphupdatemvols morphupdateparameter
syn keyword hmCommand		morphupdateparameterstring morphupdateshapes morphvolumeconnect morphvolumecreate morphvolumecreateflex
syn keyword hmCommand		morphvolumecreatenodes morphvolumecreateplus morphvolumedeleteempty morphvolumeequivalence morphvolumereflect
syn keyword hmCommand		morphwritenodes move_clipping_sphere_to_XYZ_and_fit movecuttingplane moveinclude moveincludecontents
syn keyword hmCommand		movemark movemarkgroup multi_surfs_lines_merge multibody_cogupdate multibody_sysupdate
syn keyword hmCommand		multibodycreate nameview nodeaddtempmark nodecleartempmark nodecreateatintersection
syn keyword hmCommand		nodecreateonlines nodecreateatlineparams nodecreateatplanesintersection nodecreateatsurfparams nodecreateatvectorplaneintersection
syn keyword hmCommand		nodecreatebetweennodes nodelistbypath nodelistbypath2 nodemarkaddtempmark nodemarkbypath
syn keyword hmCommand		nodemarkcleartempmark nodemodify nodeplaceatxyz nodesandelesclear nodesassociatetogeometry
syn keyword hmCommand		nodetoelementgapscreate nonstructuralmasscreate nonstructuralmasscreateall nonstructuralmassupdate nonstructuralmassupdateall
syn keyword hmCommand		normalsadjust normalsadjustbynodes normalsdisplay normalsoff normalsreverse
syn keyword hmCommand		numbers numbersclear numbersmark offset_surfaces_and_modify offset_surfaces_display_offset
syn keyword hmCommand		opticonstraintcreate opticonstraintupdate opticontrolcreate opticontrolupdate opticontrolupdateeslparameters
syn keyword hmCommand		opticontrolupdateoptimizationparameters optidobjrefcreate optidobjrefupdate optidscreencreate optidscreenupdate
syn keyword hmCommand		optiminmaxcreate optimized_elements_remesh2 optimized_mesh optimsmooth optiobjectivecreate
syn keyword hmCommand		optiobjectiveupdate optiresponsecreate optiresponseexcludeelements optiresponsesetequationdata1 optiresponsesetequationdata2
syn keyword hmCommand		optiresponseupdate optiresponseupdatenormalacceleration optiresponseupdatenormaldisplacement optiresponseupdatenormalvelocity optiresponseupdaterandpsid
syn keyword hmCommand		orderchangetofirst orderchangetosecond orient_normals_outside_solid ossmooth_geometry ossmooth_reanalysis
syn keyword hmCommand		ossmooth2 outputblockscreate outputblocksupdate penetrationcheck penetrationcheckend
syn keyword hmCommand		PenetrationCheckSummary penetrationchecktwo penetrationdisplay penetrationrecheck permutemark
syn keyword hmCommand		perturbationshapecreate perturbationshapeupdate picktoleranceset plot plotaxisnodes
syn keyword hmCommand		plotinfotitlemove plotinfotitlesetcolor plotinfotitlesetfont plotinfotitlesettext plotnodelist
syn keyword hmCommand		plottitlemove plottitlesetcolor plottitlesetfont plottitlesettext plycreate
syn keyword hmCommand		plyrealization plythicknessfactor plyupdate pointmodify positiondummy
syn keyword hmCommand		positionmark prepare_solid_holes_for_meshing pressures pressuresonentity pressuresonentity_curve
syn keyword hmCommand		processflange projectmarktoplane projectpointstoedges projectsystem propagate_welds
syn keyword hmCommand		propagatesplithexas propertyupdate propertyupdateentity qismoothconstrained qismoothfixfailed
syn keyword hmCommand		quatrotate quit rbe3 rbe3update rbe3updatealldofs
syn keyword hmCommand		rbe3updateallwts rbe3updatedofs rbe3updatewts readbatchparamsfile readfile
syn keyword hmCommand		readqualitycriteria refineelementsbydeviation refineelementsbysize reflectmark reflectmarkwithoption
syn keyword hmCommand		rejectmark rejectmesh relativerotatedummyjoint remap remove_solid_holes
syn keyword hmCommand		removeview removeelemsfromcontactsurf removefilletbetweennodes removeinclude removeincludefromdisplay
syn keyword hmCommand		removetempcleanupfile renamecollector renamecollectorbyid renamefile renameviewmask
syn keyword hmCommand		renumber renumberall renumbersolverid renumbersolveridall reorderinclude
syn keyword hmCommand		reparammark replacenodes rescanunresolvedids reset_elemsize_criteria reset_qa_calculator
syn keyword hmCommand		reset_qa_calculator_from_file resetcuttingplanesbase resize restoreviewmask resultcolortypemode
syn keyword hmCommand		retainmarkselections reversecontactsurfnormals reviewclearall reviewclearbyid reviewmaterialorientation
syn keyword hmCommand		reviewmaterialorientation_option reviewclearbymark reviewreferencegeometry reviewsystem rigid
syn keyword hmCommand		rigidlink rigidlinkbycollector rigidlinkinodecalandcreate rigidlinkupdate rigidlinkupdatebycollector
syn keyword hmCommand		rigidlinkupdatecalcinodebycollector rigidlinkwithset rigidlinkwithset_twonodes rigidscombine rigidsupdate
syn keyword hmCommand		rigidsupdate_setattach rigidwall_geometry rigidwall_motion_update rigidwallsize rlinkcalcinodeandcreateforcollector
syn keyword hmCommand		rod rodupdate rotate rotateabout rotatedummy
syn keyword hmCommand		rotatemark rotationangleset savefailednodesvectors savefailedsurfstomark saveviewmask
syn keyword hmCommand		scalemark scalemarkwithsystem screencopy screendump screenfile
syn keyword hmCommand		secondorderfix2 selfstitchcombine separate_fillets separate_holes_in_3d_body_new set_default_quality_criteria
syn keyword hmCommand		set_meshedgeparams set_meshfaceparams set_midsurface_z_offset set_preserved_edges setbackgroundcolors
syn keyword hmCommand		setbackgroundgradient setcleanupglobalflags setcolor setcomponentdisplayattributes setcomptopologydisplay
syn keyword hmCommand		setcurrentinclude setcuttingplaneactive setcuttingplanecolor setcuttingplanesbase setcuttingplanethickness
syn keyword hmCommand		setcuttingplanethicknesson setdisplayattributes setdisplaycolor setedgedensitylink setelementcheckmethod
syn keyword hmCommand		setelementcolormode setelementinternaledgesmode setfacetfactor setgeomrefinelevel setgeomtopologydisplay
syn keyword hmCommand		setglobalply setglobalply_option sethvlaunchflag setisosurfaceparameters setlightsource
syn keyword hmCommand		setmacrofile setmarkdisplayattributes setmarktopologydisplay setmenustate setmeshlinecolor
syn keyword hmCommand		setnormalsdisplaytype setperformancenormalmode setply setply_option setreviewbyid
syn keyword hmCommand		setreviewbymark setreviewbyname setreviewcolormode setreviewmode setreviewtransparentmode
syn keyword hmCommand		setsolver setspecularity setsphereclip setsurfacenormalsdisplaytype setsystem
syn keyword hmCommand		settopologydisplay settopologydisplayall settopologydisplaymode settopologydisplaytype settransparency
syn keyword hmCommand		settrimcuttingplanes setusefeatures setviewangles shapeboundsupdate shapevarcreate
syn keyword hmCommand		shapevarupdate shapevarcreate_twonode shapevarcreate_xproduct shapevarupdate_twonode shapevarupdate_xproduct
syn keyword hmCommand		shelloffset show_new_edge_target show_new_edge_target_by_number show_new_target showcompositelayers
syn keyword hmCommand		showglobalaxes showgeomlinedir shpdesvarcreate shpdesvarupdate shrink
syn keyword hmCommand		shrinkwrapmesh slivertetrafix simulationsetangle simulationtitleon sizedesvarcreate
syn keyword hmCommand		sizedesvsarupdate smoothelements solid_extrude_from_surfs solid_facesfind solid_fixedptsmaker
syn keyword hmCommand		solid_fixedptssuppresor solid_offset_from_surfs solid_prepare_entitylst solid_prepare_nodeline solid_untrim
syn keyword hmCommand		solidblock solidcone solidcreatedragsurfalongline solidcreateruled solidcreatespinsurfwithoffsetangle
syn keyword hmCommand		solidmap_begin solidmap_end solidmap_equivalence solidmap_prepare_usrdataptr solidmap_solids_begin
syn keyword hmCommand		solidmap_solids_begin2 solidmap_solids_end solidmap_solids_set_density solidmap_solids_set_elemsize solidmap_solids_set_face_params
syn keyword hmCommand		solidmap_solids_set_mapface solidmesh12lines solidmesh9lines solidmeshwithsurfaces solids_create_from_surfaces
syn keyword hmCommand		solverconvert sort_midsurfaces sphgenerate sphereclipautofit sphereclipcenter
syn keyword hmCommand		sphereclipradius splinesurface splitelements splitelementswith1D splitsolidelements
syn keyword hmCommand		spring springsupdate stackdisplay stackreverse storeAMelemstodatabase
syn keyword hmCommand		summary superelementset surface_rmesh surfaceaddnodesfixed surfaceaddpoint
syn keyword hmCommand		surfaceaddpointsfixed surfacecone surfaceconefull surfacecopyedges surfacecreatedraglinealongline
syn keyword hmCommand		surfacecreatedraglinealongnormal surfacecreatedraglinealongvector surfacecreatedragnodesalongline surfacecreatenurbs surfacecreatespinlinewithoffsetangle
syn keyword hmCommand		surfacecreatespinnodeswithoffsetangle surfacedisplaynormals surfacefilletremove surfaceintersectmark surfacemark_duplicate_check
syn keyword hmCommand		surfacemark_find_organize_symmetry surfacemarkaddnodesfixed surfacemarkchangesurfacelines surfacemarkclipwithline surfacemarkclipwithlines
syn keyword hmCommand		surfacemarkfeatures surfacemarkmerge surfacemarkremoveallpinholes surfacemarkremovelinefillets surfacemarkremovepinholes
syn keyword hmCommand		surfacemarksplitwithline surfacemarksplitwithlines surfacemarksplitwithnodes surfacemarksplitwithplane surfacemarksplitwithsurface
syn keyword hmCommand		surfacemarkuntrim surfacemode surfaceplane surfaceprimitivefromlines surfaceprimitivefrompoints
syn keyword hmCommand		surfacereversenormals surfaceskin surfacespherefromfournodes surfacespherefromthreepoints surfacespherefull
syn keyword hmCommand		surfacesplinefillholes surfacesplinefrommesh surfacesplinefrompoints surfacesplineonlinesloop surfacesplineonnodesloop
syn keyword hmCommand		surfacesplitwithcoords surfacesplitwithline surfacesplitwithplane surfacesplitwithsurface surfacetorus
syn keyword hmCommand		surfacetorusfromthreepoints surfacetorusfull surfaceuvlines surfisonlinecreate surfmark_trim_by_surfmark
syn keyword hmCommand		systemcommand systemcreate systemcreate3nodes systemdeleteunused systemorthobound
syn keyword hmCommand		systempreviewunused systemsetanalysis systemsetreference systemsize tableaddcolumn
syn keyword hmCommand		tableaddrow tablecreate tabledeletecolumn tabledeleterow tableexport
syn keyword hmCommand		tableinsertcolumn tableinsertrow tablepopulate tableupdatecell tableupdatecolumn
syn keyword hmCommand		tableupdatelabels tableupdaterow tagcreate tagdisplay tagtextdisplaymode
syn keyword hmCommand		tagupdate tagupdatedescription tagupdateentity tangentbetweenlines tangentbetweennodeandline
syn keyword hmCommand		templatefileset tetmesh tetmesh_create_size_ctrl tetmesh_set_input time
syn keyword hmCommand		titlecreate titledraw titlemodify titlepop titlepush
syn keyword hmCommand		titlesetcurrent toggleincludefromdisplay toleranceset topographydesvarcreate topographydesvarupdate
syn keyword hmCommand		topographypatternvaluesupdate topography_reanalysis topologydesvarcreate topologydesvarupdate topologydrawupdate
syn keyword hmCommand		topologydrawupdatewithnoholeandstamp topologyextrusionupdate topologyparametersupdatewithfatigue topologyparametersupdatewithmingap transformmark
syn keyword hmCommand		translatemark translatemarkwithsystem transparencymark transparencyvalue trim_by_offset_edges
syn keyword hmCommand		trim_elements2 trim_elems_by_circular_hole trueview unmaskall unmaskentitiesincollector
syn keyword hmCommand		unmaskentitymark unmaskshown unsmoothelements UpdateBinderSections updateblocks
syn keyword hmCommand		updatecolor updatefree1delements updateinclude updateincludedata updateLatitudeLineDrag
syn keyword hmCommand		updatereferencegeometry updatesimpleblock usercheck vectorcreate vectorcreate_twonode
syn keyword hmCommand		vectorcreate_xproduct vectordrawoptions vectorhandle vectorlabel vectorplot
syn keyword hmCommand		vectorsoff vectorupdate vectorupdate_twonode vectorupdate_xproduct vertexrelease
syn keyword hmCommand		verticescombine verticesmarksuppress verticesrelease view view_restoreprevious
syn keyword hmCommand		viewset visualizemode walldisplay weld wind_tunnel_mesh
syn keyword hmCommand		window writecurrentqualitycriteria writefile writeh3d writeh3dtofile
syn keyword hmCommand		writeh3dwithorienttofile writequalitycriteria writequalitysummary xyplotchangemode xyplotcoloroverride
syn keyword hmCommand		xyplotcreate xyplotcreateandsize xyplotcreatecomplex xyplotcurvecreate xyplotcurvemodify
syn keyword hmCommand		xyplotcurvepermute xyplotdraw xyplotexpand xyplotfindcurves xyplotmodify
syn keyword hmCommand		xyplotonecurvemath xyplotorganize xyplotpage xyplotpop xyplotpush
syn keyword hmCommand		xyplotreadcurve xyplotregisterexternalreader xyplotregisterimporttemplate xyplotsetcurrent xyplotsetcurve
syn keyword hmCommand		xyplotsetcurves xyplotsetsecondcurve xyplotstack xyplottwocurvemath xyplotwindow
syn keyword hmCommand		xyplotzoomout zoomfactorset hf_getautotippingangles hf_getdrawbeadforce hm_allentitiesinfo
syn keyword hmCommand		hm_answernext hm_appendmark hm_assemlist hm_attributearray2dcols hm_attributearray2drows
syn keyword hmCommand		hm_attributearray2dvalue hm_attributearraylength hm_attributearrayvalue hm_attributebehavior hm_attributeentityid
syn keyword hmCommand		hm_attributeentitytype hm_attributeentitytypename hm_attributeidentifier hm_attributeidfromname hm_attributeindexarray2dcols
syn keyword hmCommand		hm_attributeindexarray2drows hm_attributeindexarray2dvalue hm_attributeindexarraylength hm_attributeindexarrayvalue hm_attributeindexbehavior
syn keyword hmCommand		hm_attributeindexentityid hm_attributeindexentitytype hm_attributeindexentitytypename hm_attributeindexidentifier hm_attributeindexmax
syn keyword hmCommand		hm_attributeindexsolver hm_attributeindexstatus hm_attributeindextype hm_attributeindextypename hm_attributeindexvalue
syn keyword hmCommand		hm_attributelist hm_attributelistall hm_attributemax hm_attributenamefromid hm_attributereferencecount
syn keyword hmCommand		hm_attributesolverarrayvalues hm_attributestatus hm_attributetype hm_attributetypename hm_attributevalue
syn keyword hmCommand		hm_bag_getconfigfromgenericname hm_bag_getentitylistall hm_bag_getentitylistmax hm_bag_getentitytypes hm_bag_getgenericnamefromconfig
syn keyword hmCommand		hm_bag_getsupportedconfiglist hm_baglist hm_baglist_byconfig hm_buffercommandfile hm_ce_alldetailsget
syn keyword hmCommand		hm_ce_checklinkentities hm_ce_checkprojection hm_ce_close_mcf hm_ce_datalist hm_ce_detailget
syn keyword hmCommand		hm_ce_errorreport hm_ce_fe_config hm_ce_fedata hm_ce_findduplicates hm_ce_getallfe
syn keyword hmCommand		hm_ce_getcords hm_ce_getfe hm_ce_getfeprojtrip hm_ce_gethmholes hm_ce_getlinkentities
syn keyword hmCommand		hm_ce_getlinkentityinfo hm_ce_getlinkinfo hm_ce_getnumoffeprojinfo hm_ce_getprojcompid hm_ce_getprojectiondata
syn keyword hmCommand		hm_ce_getprojfe hm_ce_getprojfesize hm_ce_getprojnodeid hm_ce_gettestpoints hm_ce_getthickness
syn keyword hmCommand		hm_ce_globalget hm_ce_info hm_ce_mesh_imprint_option_get hm_ce_mesh_imprint_option_set hm_ce_numlinkentities
syn keyword hmCommand		hm_ce_organize hm_ce_projecthexaface hm_ce_read_mcf hm_ce_setfeorientaxis hm_ce_state
syn keyword hmCommand		hm_ce_type hm_ce_xmlstringget hm_checkmark hm_commandfilestate hm_controlcardattributedefined
syn keyword hmCommand		hm_count hm_createmark hm_curve_getnumberofpoints hm_curve_getpointcords hm_defaultstatus
syn keyword hmCommand		hm_defined hm_dlinkgetdesvarcoeffs hm_dvprelgetdesvarcoeffs hm_dvprelgetdesvars hm_elemlist
syn keyword hmCommand		hm_entity_setvector hm_entitycanselectby hm_entitygettype hm_entityincollector hm_entityinfo
syn keyword hmCommand		hm_entitylist hm_entitymaxid hm_entitymaxsolverid hm_fe_getconfigfile hm_fe_getdiameter
syn keyword hmCommand		hm_fe_getdvstfile hm_fe_setconfigfile hm_fe_setdvstfile hm_findcirclefromthreepoints hm_findclosestpointonline
syn keyword hmCommand		hm_findclosestpointonsurface hm_findtangentpointoncircle hm_get2delemchecktestval hm_getabsoluterotationvector hm_getaddendumid
syn keyword hmCommand		hm_getadjfacesfromface hm_getadjsurfacesfromsurface hm_getangle hm_getareaofsurface hm_getaverageelemsize
syn keyword hmCommand		hm_getbackgroundgradient hm_getbestcirclecenter hm_getbinderid hm_getboundingbox hm_getcardimagename
syn keyword hmCommand		hm_getcardimagenamemark hm_getcardimageoptions hm_getcardmark hm_getcentroidofsolids hm_getcleanupglobalflags
syn keyword hmCommand		hm_getcleanuptol hm_getclosestnode hm_getclosestpointsbetweenlinesurface hm_getclosestpointsbetweentwolines hm_getcog
syn keyword hmCommand		hm_getcollectorname hm_getconfigtypecountincol hm_getconfigtypeincol hm_getcontrolcardattribute hm_getcoordinates
syn keyword hmCommand		hm_getcoordinatesfromnearestsurface hm_getcoordinatesofpointsonline hm_getcrossreferencedentities hm_getcrossreferencedentitiesmark hm_getdeleteelementsmode
syn keyword hmCommand		hm_getdiameterfromfile hm_getdiedisplayattribute hm_getdiepartid hm_getdiepartshape hm_getdisplaycolor
syn keyword hmCommand		hm_getdistance hm_getdistancefromnearestline hm_getdistancefromnearestsurface hm_getdrawbarid hm_getdrawbeadattribute
syn keyword hmCommand		hm_getdrawbeadid hm_getduplicateelements hm_getedgesfromvertex hm_getelemcheckbounds hm_getelemcheckelems
syn keyword hmCommand		hm_getelementcheckmethod hm_getelementchecksettings hm_getelemchecksummary3d hm_getelemcheckvalues hm_getelementsize
syn keyword hmCommand		hm_getelementsqualityinfo hm_getentityarray hm_getentitybasename hm_getentitycardimagedictionary hm_getentityname
syn keyword hmCommand		hm_getentitytype hm_getentitytypes hm_getentitytypedictionary hm_getentityvalue hm_getfacesbyarea
syn keyword hmCommand		hm_getfacesbyedgelength hm_getfacesfromedge hm_getfacesfromsurface hm_getfacesfromvertex hm_getfilletfaces
syn keyword hmCommand		hm_getfilletfacesbyprofile hm_getfilletfacesfrommark hm_getFLid hm_getgeometrynodes hm_getguientityname
syn keyword hmCommand		hm_getidpools hm_getidpoolsforidrange hm_getincludechildren hm_getincludeid hm_getincludeisolationentitiesmark
syn keyword hmCommand		hm_getincludename hm_getincludes hm_getinputoffsetid hm_getinternalid hm_getlinearclenpoint
syn keyword hmCommand		hm_getlineendpoint hm_getlinelineangle hm_getlinepointsatdistance hm_getlinestartpoint hm_getlinetgendpoint
syn keyword hmCommand		hm_getlinetgstartpoint hm_getlinetype hm_getlist hm_getllsid hm_getloadoption
syn keyword hmCommand		hm_getmark hm_getmarkall hm_getmarkarray hm_getmarkentitytypes hm_getmarkfromtable
syn keyword hmCommand		hm_getmarkvalue hm_getmass hm_getmeshedgeparams hm_getmeshfaceparams hm_getmeshlinecolor
syn keyword hmCommand		hm_getmeshvolumesinfo hm_getmoi hm_getmoiofsolid hm_getmydocumentsdir hm_getnearestssectionid
syn keyword hmCommand		hm_getnodalthickness hm_getnodegeometry hm_getnodessharedbyothercomps hm_getnodetol hm_getoffset
syn keyword hmCommand		hm_getoffsetZ0 hm_getoption hm_getplanarfaces hm_getPOLid hm_getprincipalaxes
syn keyword hmCommand		hm_getprojceid hm_getqualitycriteriastatus hm_getreferencedentities hm_getreferencedentitiesmark hm_getribsid
syn keyword hmCommand		hm_getsolidmappablestate hm_getsolidsfromsurface hm_getsolver hm_getsolvercards hm_getsolverid
syn keyword hmCommand		hm_getsurfaceedges hm_getsurfacefromface hm_getsurfacenormal hm_getsurfacesbyarea hm_getsurfacesbyedgelength
syn keyword hmCommand		hm_getsurfacesfromedge hm_getsurfacesfromsolid hm_getsurfacesfromvertex hm_getsurfacesurfaceangle hm_getsurfacethicknessvalues
syn keyword hmCommand		hm_getsystemoption hm_gettablecelldata hm_gettablecolumndata hm_gettablecolumnlabel hm_gettablecolumnsize
syn keyword hmCommand		hm_gettablecolumntype hm_gettablerowdata hm_getthickness hm_getTLid hm_gettopologyoption
syn keyword hmCommand		hm_gettracksid hm_gettrimmedbinderid hm_getusermark hm_getuvbounds hm_getuvcoordinates
syn keyword hmCommand		hm_getuvvectors hm_getvectoroption hm_getverticesfromedge hm_getvolumeofsolid hm_getwhollycontainedcollectormark
syn keyword hmCommand		hm_hierarchy hm_idconvertmode hm_info hm_intersectlineline hm_ispointinsidesolid
syn keyword hmCommand		hm_lineapplychordaldev hm_linechordaldev hm_linefilleting hm_linelength hm_lineparameterization
syn keyword hmCommand		hm_mapelementstoplane hm_markclear hm_markclearall hm_marklength hm_markremove
syn keyword hmCommand		hm_marksearchmode hm_marktotable hm_metadata hm_morph_domaintypecount hm_morph_getcountercurrent
syn keyword hmCommand		hm_morph_getcountermaximum hm_morph_getdomainangle hm_morph_getdomainarcangle hm_morph_getdomainelems hm_morph_getdomainhandles
syn keyword hmCommand		hm_morph_getdomainlength hm_morph_getdomainnodes hm_morph_getdomainradius hm_morph_gethandledomains hm_morph_gethandlenode
syn keyword hmCommand		hm_morph_getmvoledge hm_morph_getmvolface hm_morph_getnodehandle hm_morph_getparameter hm_morphupdatecheck
syn keyword hmCommand		hm_nodelist hm_nodevalue hm_parentcomplist hm_pathmanager hm_projectpointtosegment
syn keyword hmCommand		hm_projectpointtosegmentwithangle hm_removedieattribute hm_runcommandfile hm_saveusermark hm_setdieattribute
syn keyword hmCommand		hm_setsolver hm_solverconvert hm_tableappend hm_tableclear hm_tableclearall
syn keyword hmCommand		hm_tablecopy hm_tabledifference hm_tableintersection hm_tablelist hm_tablelookup
syn keyword hmCommand		hm_tabletomark hm_triplecos hm_xformnodetolocal hm_xformvectoratpointtoglobal hm_xformvectoratpointtolocal
syn keyword hmCommand		hm_xpointlocal hm_xpointvectorlocal hm_ypointlocal hm_ypointvectorlocal hm_zpointlocal hm_zpointvectorlocal 


syn keyword hmEntityType		assemblies bags beamsectcols beamsects blocks
syn keyword hmEntityType		cards components connectors contactsurfs controlvols
syn keyword hmEntityType		curves ddvals dequations desvarlinks desvars
syn keyword hmEntityType		dobjrefs domains dvprels elements ellipsoids
syn keyword hmEntityType		equations faces groups handles lines
syn keyword hmEntityType		loadcols loads loadsteps materials mbjoints
syn keyword hmEntityType		mbplanes morphconstraints morphvolumes multibodies nodes
syn keyword hmEntityType		objectives opticonstraints opticontrols optidscreens optiresponses
syn keyword hmEntityType		optitableentrs outputblocks plots points properties
syn keyword hmEntityType		sensors sets shapes solids surfaces
syn keyword hmEntityType		symmetries systemcols systems tags titles
syn keyword hmEntityType		topolines topopoints vectorcols vectors 
syn keyword hmEntityType		elems comps assems props surfs mats

syn keyword hmEntityOption		exist
"end HyperMesh command

" -------------------------
" Tcl: Packages
" ------------------------- 

if exists("s:tcl_snit_active")
    runtime! syntax/tcl_snit.vim
endif

if exists("s:tcl_sqlite_active")
    runtime! syntax/tcl_sqlite.vim
endif

if exists("s:tcl_critcl_active")
    runtime! syntax/tcl_critcl.vim
endif

if exists("s:tcl_togl_active")
    runtime! syntax/tcl_togl.vim
endif

if exists("s:tcl_itcl_active")
    runtime! syntax/tcl_itcl.vim
endif

if exists("s:tcl_ttk_active")
    runtime! syntax/tcl_ttk.vim
endif

" -------------------------

if exists("s:tcl_highlight_all")
    let s:tcl_highlight_namespace_bold = 1
    let s:tcl_highlight_bookends = 1
    let s:tcl_highlight_primary = 1
    let s:tcl_highlight_expressions = 1
    let s:tcl_highlight_variables = 1
    let s:tcl_highlight_secondary = 1
    let s:tcl_highlight_options = 1
    let s:tcl_highlight_lcs_are_warnings = 1
    let s:tcl_comments_ignore_nested_braces = 1
endif

if version >= 508 || !exists("s:did_tcl_syn_inits")
    if version <= 508
        let s:did_tcl_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif
endif

" -------------------------
" Highlights: - Basic
" -------------------------
HiLink tclStart          Special
HiLink tclLContinueOK    Special
HiLink tclLContinueError Error
HiLink tclQuotes         String
HiLink tclNumber         Number
HiLink tclComment        Comment
HiLink tclComment2       Comment
HiLink tclCommentBraces  Comment
HiLink tclIfComment      Comment
HiLink tclIfCommentStart Comment
HiLink tclSpecial        Special
HiLink tclTodo           Todo
HiLink tclExpand         Underlined
HiLink tclREClassGroup   Special
HiLink tclREClass        Special
" ------------------
" Highlights: HyperMesh
HiLink hmCommand         WarningMsg
HiLink hmEntityType      Type
HiLink hmEntityOption    Special
"
"


if exists("s:tcl_highlight_primary")
    HiLink tclKeyword        Statement
    HiLink tclNamespace      Statement
    HiLink tclPrimary        Statement
    HiLink tclConditional    Underlined
    HiLink tclRepeat         Underlined
    HiLink tclException      Exception
    HiLink tclLabel          Label
    HiLink tkWidget          Statement
endif
" ------------------
if exists("s:tcl_highlight_lcs_are_warnings")
    hi! def link tclLContinueOk WarningMsg
endif
" ------------------
if exists("s:tcl_highlight_namespace_bold")
    hi! def link tclNamespace      Bold
endif
" ------------------
if exists("s:tcl_highlight_options")
    hi! def link tclOption         PreProc
endif
" ------------------
if exists("s:tcl_highlight_secondary")
    hi! def link tclSecondary      Type
    hi! def link tclSubcommand     Type
endif
" ------------------
if exists("s:tcl_highlight_variables")
    hi! def link tclVariable       Identifier
endif
" ------------------
if exists("s:tcl_highlight_expressions")
    hi! def link tclEnsemble       Special
    hi! def link tclMaths          Special
endif
" ------------------
HiLink tclProcName       Bold
HiLink tclProcDef        Bold
HiLink tclProcType       Bold
" ------------------
HiLink tkColor           Bold
HiLink tkWidgetCmds      tclSubcommand
HiLink tkWidgetOpts      tclOption
HiLink tclMagicName      tclKeyword
HiLink tkKeyword         tclKeyword
HiLink tkReserved        tclKeyword
HiLink tkDialog          tclKeyword
HiLink tkEvent           tclQuotes
HiLink tkWidgetName      tclQuotes


" -------------------------
" Highlights: - Extended
" -------------------------
HiLink tclAfterCmds tclSubcommand
HiLink tclArrayCmds tclSubcommand
HiLink tclArrayCmdsNamesOpts tclOption
HiLink tclBinaryCmds tclSubcommand
HiLink tclChanCmds tclSubcommand
HiLink tclChanCmdsConfigureOpts tclOption
HiLink tclChanCmdsCopyOpts tclOption
HiLink tclChanCmdsPutsOpts tclOption
HiLink tclClockCmds tclSubcommand
HiLink tclClockCmdsAddOpts tclOption
HiLink tclDictCmds tclSubcommand
HiLink tclDictCmdsFilterOpts tclOption
HiLink tclEncodingCmds tclSubcommand
HiLink tclExecOpts tclOption
HiLink tclFconfigureOpts tclOption
HiLink tclFcopyOpts tclOption
HiLink tclFileCmds tclSubcommand
HiLink tclFileCmdsAtimeOpts tclOption
HiLink tclFileCmdsAttributesOpts tclOption
HiLink tclFileCmdsCopyOpts tclOption
HiLink tclFileeventCmds tclSubcommand
HiLink tclGlobOpts tclOption
HiLink tclHistoryCmds tclSubcommand
HiLink tclHistoryCmdsAddCmds tclSubcommand
HiLink tclInfoCmds tclSubcommand
HiLink tclInterpCmds tclSubcommand
HiLink tclInterpCmdsCreateOpts tclOption
HiLink tclInterpCmdsInvokehiddenOpts tclOption
HiLink tclInterpCmdsLimitOpts tclOption
HiLink tclInterpSUBInvokehiddenOpts tclOption
HiLink tclInterpSUBLimitOpts tclOption
HiLink tclLsearchOpts tclOption
HiLink tclLsortOpts tclOption
HiLink tclMemoryCmds tclSubcommand
HiLink tclOpenOpts tclOption
HiLink tclPackageCmds tclSubcommand
HiLink tclPackageCmdsPresentOpts tclOption
HiLink tclPutsOpts tclOption
HiLink tclRegexpOpts tclOption
HiLink tclRegsubOpts tclOption
HiLink tclReturnOpts tclOption
HiLink tclSeekCmds tclSubcommand
HiLink tclSocketOpts tclOption
HiLink tclSourceOpts tclOption
HiLink tclStringCmds tclSubcommand
HiLink tclStringCmdsCompareOpts tclOption
HiLink tclStringCmdsIsClass tclEnsemble
HiLink tclStringCmdsIsClassAlnumOpts tclOption
HiLink tclStringCmdsMapOpts tclOption
HiLink tclSubstOpts tclOption
HiLink tclSwitchOpts tclOption
HiLink tclTraceCmds tclSubcommand
HiLink tclTraceCmdsAddCmds tclSubcommand
HiLink tclTraceCmdsAddCmdsCommandCmds tclSubcommand
HiLink tclTraceCmdsAddCmdsExecutionCmds tclSubcommand
HiLink tclTraceCmdsAddCmdsVariableCmds tclSubcommand
HiLink tclUnloadOpts tclOption
HiLink tclUnsetOpts tclOption
HiLink tclUpdateCmds tclSubcommand
HiLink tkBellOpts tclOption
HiLink tkClipboardCmds tclSubcommand
HiLink tkClipboardCmdsClearOpts tclOption
HiLink tkConsoleCmds tclSubcommand
HiLink tkFocusOpts tclOption
HiLink tkFontCmds tclSubcommand
HiLink tkFontCmdsActualOpts tclOption
HiLink tkFontCmdsFamiliesOpts tclOption
HiLink tkGrabCmds tclSubcommand
HiLink tkGrabOpts tclOption
HiLink tkGridCmds tclSubcommand
HiLink tkGridCmdsColumnconfigureOpts tclOption
HiLink tkGridOpts tclOption
HiLink tkOptionCmds tclSubcommand
HiLink tkPackCmds tclSubcommand
HiLink tkPackCmdsConfigureOpts tclOption
HiLink tkPackOpts tclOption
HiLink tkPlaceCmds tclSubcommand
HiLink tkPlaceCmdsConfigureOpts tclOption
HiLink tkPlaceOpts tclOption
HiLink tkSendOpts tclOption
HiLink tkTkCmds tclSubcommand
HiLink tkTkCmdsCaretCmds tclSubcommand
HiLink tkTkCmdsCaretCmdsWindowOpts tclOption
HiLink tkTkCmdsScalingOpts tclOption
HiLink tkTk_messageboxOpts tclOption
HiLink tkTkwaitCmds tclSubcommand
HiLink tkWinfoCmds tclSubcommand
HiLink tkWinfoCmdsAtomOpts tclOption
HiLink tkWmCmds tclSubcommand

" -------------------------
" Highlights: - Special Case
" -------------------------
HiLink tclNamespaceCmds               tclSubcommand
HiLink tclNamespaceEnsemble           tclEnsemble
HiLink tclNamespaceEnsembleCmds       tclSubcommand
HiLink tclNamespaceEnsembleExistsOpts tclOption
HiLink tclNamespaceExportOpts         tclOption
HiLink tkBindSubst                    tclQuotes
HiLink tkBindSubstGroup               tclQuotes
HiLink tkEventCmds                    tclSubcommand
HiLink tkEventFields                  tclOption
HiLink tkEventWhen                    tclString
HiLink tkCanvasItemOpts               tclOption
HiLink tkCanvasPsOpts                 tclOption
HiLink tkCanvasTagOpts                tclOption
HiLink tkWidgetCreate                 tclSubcommand
HiLink tkWidgetCreateArcOpts          tclOption
HiLink tkWidgetCreateBitmapOpts       tclOption
HiLink tkWidgetCreateCmds             tclEnsemble
HiLink tkWidgetCreateCommonOpts       tclOption
HiLink tkWidgetCreateImageOpts        tclOption
HiLink tkWidgetCreateLineOpts         tclOption
HiLink tkWidgetCreateOvalOpts         tclOption
HiLink tkWidgetCreatePhotoOpts        tclOption
HiLink tkWidgetCreatePolyOpts         tclOption
HiLink tkWidgetCreateRectOpts         tclOption
HiLink tkWidgetCreateTextOpts         tclOption
HiLink tkWidgetCreateWinOpts          tclOption
HiLink tkImageCmds                    tclSubcommand
HiLink tkWidgetImageCopyOpts          tclOption
HiLink tkWidgetImageDataOpts          tclOption
HiLink tkWidgetImagePutOpts           tclOption
HiLink tkWidgetImageReadOpts          tclOption
HiLink tkWidgetImageTransOpts         tclOption
HiLink tkWidgetImageWriteOpts         tclOption

HiLink tkTextWidgetOpts               tclOption
HiLink tkMarkCmds                     tclEnsemble
HiLink tkTagCmds                      tclEnsemble
HiLink tkTagOpts                      tclOption
HiLink tkWidgetSearchOpts             tclOption

HiLink tkScanCmds                     tclEnsemble
HiLink tkScrollCmds                   tclEnsemble
HiLink tkSelectCmds                   tclEnsemble
HiLink tkScrollbarElems               tclOption
HiLink tkScrollbarElems               tclString
HiLink tkWidgetMenu                   tclEnsemble
HiLink tkViewCmds                     tclEnsemble


delcommand HiLink

" -------------------------
" Hoodage:
" -------------------------

let b:current_syntax = "tcl"
" override the sync commands from the other syntax files
syn sync clear
" syn sync minlines=300
syn sync fromstart

" -------------------------

" vim:ft=vim
