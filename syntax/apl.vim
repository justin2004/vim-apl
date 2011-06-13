if !exists('main_syntax')
  if version < 600
    syntax clear
  elseif exists('b:current_syntax')
    finish
  endif
  let main_syntax = 'apl'
endif

syn case match

syn match aplInvalid /./
syn match aplWhitespace /\s\+/
syn match aplComment /[⍝#].*$/
syn match aplStatementSeparator /◇/
syn match aplNumber /¯\?[0-9]\+\%(\.[0-9]\+\)\?/
syn region aplString matchgroup=aplStringDelimiter start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=aplStringSpecial
syn region aplString matchgroup=aplStringDelimiter start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=aplStringSpecial
syn match aplStringSpecial /\\[0-7]\{1,3}\|\\x\x\x\|\\u[0-9A-Fa-f]\{4}\|\\./ contained
syn match aplOperator /\%([\.\\\/⌿⍀¨⍣]\|∘\.\)/
syn match aplFunction /[\+−×÷⌈⌊∣⍳\?⋆⍟○!⌹<≤=>≥≠≡≢∈⍷∪∩∼∨∧⍱⍲⍴,⍪⌽⊖⍉↑↓⊂⊃⌷⍋⍒⊤⊥⍕⍎⊣⊢]/
syn match aplFormalParameter /[⍺⍵]/
syn match aplNiladicFunction /⍬/
syn match aplIndex /[\[\];]/
syn region aplParen matchgroup=aplParenDelimiter start=/(/ end=/)/ contains=ALL
syn region aplLambda matchgroup=aplLambdaDelimiter start=/{/ end=/}/ contains=ALL
syn match aplIdentifier /[A-Za-z_][A-Za-z_0-9]*/
syn match aplIdentifier /[⎕⍞]/
syn match aplArrow /←/
syn region aplEmbedded matchgroup=aplEmbeddedDelimiter start=/«/ end=/»/ contains=@aplJS
syn include @aplJS syntax/javascript.vim

syn sync fromstart
syn sync maxlines=1000

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists('did_coffee_syn_inits')

  if version < 508
    let did_coffee_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink aplArrow               Statement
  HiLink aplComment             Comment
  HiLink aplEmbeddedDelimiter   Special
  HiLink aplFunction            Function
  HiLink aplFormalParameter     Special
  HiLink aplIdentifier          Normal
  HiLink aplIndex               Delimiter
  HiLink aplInvalid             Error
  HiLink aplLambdaDelimiter     Special
  HiLink aplNiladicFunction     Constant
  HiLink aplNumber              Constant
  HiLink aplOperator            Type
  HiLink aplParenDelimiter      Delimiter
  HiLink aplStatementSeparator  Statement
  HiLink aplStringDelimiter     Delimiter
  HiLink aplStringSpecial       Special
  HiLink aplString              String

  delcommand HiLink
endif

let b:current_syntax = 'apl'
if main_syntax == 'apl'
  unlet main_syntax
endif